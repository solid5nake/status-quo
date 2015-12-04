module StatusQuo
  class Resource
    class Segment

      def initialize(resource, identifier, &block)
        @resource = resource
        @identifier = identifier
        instance_exec &block if block_given?
      end

      def resource
        @resource
      end

      def identifier
        @identifier
      end

      def recipient(recipient = nil)
        if recipient.nil?
          @recipient
        else
          @recipient = recipient
        end
      end

      def schedule(schedule)
        @schedule = schedule
      end

      def confirm(&block)
        @confirm = block
      end

      # Runs the given confirm block and notifies about failed confirmations when expected.
      def confirm!(moment = nil)
        moment ||= Time.now
        result = instance_exec moment, &@confirm
        if [true, false].include?(result)
          event = create_event! moment, result
          notify(event) unless result
        else
          raise InvalidConfirmationError, "Expected boolean (got #{result.inspect})"
        end
      end

      def response_code(uri, http_code)
        uri = URI(uri)
        response = Net::HTTP.get_response(uri)
        regexp = Regexp.new http_code.to_s
        !!(response.code =~ regexp)
      end

    private

      def create_event!(moment, status)
        status = status ? "OK" : "FAIL"
        StatusQuo::Event.create :resource => resource, :segment => identifier, :moment => moment, :status => status
      end

      def notify(event)
        if recipient
          StatusQuo::Notifier.event_notice(recipient, event).deliver_now
        end
      end

    end
  end
end
