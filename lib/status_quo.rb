require "active_record"
require "action_mailer"

require "status_quo/engine" if defined?(Rails::Engine)
require "status_quo/resource"
require "status_quo/event"
require "status_quo/notifier"
require "status_quo/version"

ActionMailer::Base.view_paths = File.expand_path("../../app/views", __FILE__)

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
