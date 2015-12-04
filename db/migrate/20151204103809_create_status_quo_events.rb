class CreateStatusQuoEvents < ActiveRecord::Migration
  def change
    create_table :status_quo_events do |t|
      t.string :resource
      t.string :segment
      t.datetime :moment
      t.string :status
      t.timestamps
    end
  end
end
