class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :AccessToken

      t.timestamps
    end
  end
end
