require "yaml"

config = YAML.load_file(File.expand_path("../database.yml", __FILE__))
database = config["database"]

ActiveRecord::Base.establish_connection config.merge("database" => nil)
ActiveRecord::Base.connection.create_database database, {:charset => "utf8", :collation => "utf8_unicode_ci"} rescue nil
ActiveRecord::Base.establish_connection config

ActiveRecord::Base.connection.drop_table(:status_quo_events)
ActiveRecord::Base.connection.create_table(:status_quo_events) do |t|
  t.string :resource
  t.string :segment
  t.datetime :moment
  t.string :status
  t.timestamps :null => false
end

ActiveRecord::Base.connection.truncate(:status_quo_events)
