require "active_record"

require "status_quo/resource"
require "status_quo/event"
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

  def self.confirm!
    resources.each do |resource|
      resource.confirm!
    end
  end

end
