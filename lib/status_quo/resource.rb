class StatusQuo::Resource

  def initialize(identifier, &block)
    @identifier = identifier
    block.call if block_given?
  end

  def identifier
    @identifier
  end

  def segments
    @segments ||= []
  end

end
