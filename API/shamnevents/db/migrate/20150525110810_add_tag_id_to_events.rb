class AddTagIdToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :tag_id
  end
end
