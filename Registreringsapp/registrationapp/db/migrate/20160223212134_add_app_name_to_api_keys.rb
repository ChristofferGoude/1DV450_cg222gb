class AddAppNameToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :app_name, :string
  end
end
