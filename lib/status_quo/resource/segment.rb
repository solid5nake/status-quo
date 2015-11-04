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

      def confirm!#(time = Time.now)
        value = @confirm.call
        if [true, false].include?(value)
          create_event! value
        else
          raise InvalidConfirmationError, "Expected boolean (got #{value.inspect})"
        end
      end

    private

      def create_event!(status)
        StatusQuo::Event.create :segment => identifier
      end

    end
  end
end
