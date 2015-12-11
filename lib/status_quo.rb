require "status_quo/engine"
require "status_quo/resource"
require "status_quo/notifier"
require "status_quo/version"

module StatusQuo

  class Error < StandardError; end
  class InvalidConfirmationError < Error; end

  def self.resources
    @resources ||= []
  end

  def self.watch(identifier, &block)
    resource = StatusQuo::Resource.new(identifier, &block)
    resources.push(resource)
  end

  def self.confirm!(moment = nil)
    resources.each do |resource|
      resource.confirm!(moment)
    end
  end

end
