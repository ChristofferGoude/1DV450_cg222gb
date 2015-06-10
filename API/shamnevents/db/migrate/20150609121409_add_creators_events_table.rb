class AddCreatorsEventsTable < ActiveRecord::Migration
  def change
    create_table :creators_events, :id => false do |t|
      t.integer "creator_id"
      t.integer "event_id"
    end
    
    add_index :creators_events, ["creator_id", "event_id"]
  end
end
