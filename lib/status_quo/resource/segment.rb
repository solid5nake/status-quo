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

      def schedule(schedule)
        @schedule = schedule
      end

      def confirm(&block)
        @confirm = block
      end

      def confirm!(moment = Time.now)
        value = @confirm.call
        if [true, false].include?(value)
          create_event! moment, value
        else
          raise InvalidConfirmationError, "Expected boolean (got #{value.inspect})"
        end
      end

    private

      def create_event!(moment, status)
        status = status ? "OK" : "FAIL"
        StatusQuo::Event.create :resource => resource, :segment => identifier, :moment => moment, :status => status
      end

    end
  end
end
