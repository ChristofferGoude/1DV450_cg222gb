class FixApiKeyColumn < ActiveRecord::Migration
  def change
    rename_column :api_keys, :bleh, :access_token
  end
end
