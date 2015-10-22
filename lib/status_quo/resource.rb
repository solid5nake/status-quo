require "status_quo/resource/segment"

module StatusQuo
  class Resource

    def initialize(identifier, &block)
      @identifier = identifier
      instance_exec &block if block_given?
    end

    def identifier
      @identifier
    end

    def segments
      @segments ||= []
    end

    def segment(identifier, &block)
      segment = StatusQuo::Resource::Segment.new(identifier, &block)
      segments.push(segment)
    end

  end
end
