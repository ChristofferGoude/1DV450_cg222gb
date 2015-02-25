class AddApiKeyToApiKey < ActiveRecord::Migration
  def change
    add_column :api_keys, :api_key, :string
  end
end
