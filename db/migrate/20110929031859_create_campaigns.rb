class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.references :dm
      t.text :description
      t.boolean :private, :default => false, :null => false

      t.timestamps
    end
    add_index :campaigns, :dm_id
  end
end
