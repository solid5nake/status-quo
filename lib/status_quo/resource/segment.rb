module StatusQuo
  class Resource
    class Segment

      def initialize(identifier, &block)
        @identifier = identifier
        instance_exec &block if block_given?
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

    end
  end
end
