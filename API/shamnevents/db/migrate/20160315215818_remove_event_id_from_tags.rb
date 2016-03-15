class RemoveEventIdFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :event_id
  end
end
