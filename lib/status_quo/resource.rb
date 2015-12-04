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
      segment = StatusQuo::Resource::Segment.new(self.identifier, identifier, &block)
      segments.push(segment)
    end

    def confirm!(moment = nil)
      segments.each do |segment|
        segment.confirm!(moment)
      end
    end

  end
end
