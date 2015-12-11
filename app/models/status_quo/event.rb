module StatusQuo
  class Event < ActiveRecord::Base
    self.table_name = "status_quo_events"
  end
end
