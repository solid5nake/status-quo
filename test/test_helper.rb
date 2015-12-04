require_relative "test_helper/coverage"

require "minitest/autorun"
require "mocha/setup"
require "rails/all"

require "bundler"
Bundler.require :default, :development

require_relative "test_helper/database"

StatusQuo::Notifier.delivery_method = :test

def project_file(path)
  File.expand_path "../../#{path}", __FILE__
end
