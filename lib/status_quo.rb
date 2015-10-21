require "status_quo/resource"
require "status_quo/version"

module StatusQuo

  def self.resources
    @resources ||= []
  end

  def self.watch(identifier, &block)
    resource = StatusQuo::Resource.new(identifier, &block)
    resources.push(resource)
  end

end
