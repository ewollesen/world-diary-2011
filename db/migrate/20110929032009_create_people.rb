class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.references :campaign
      t.text :description

      t.timestamps
    end
    add_index :people, :campaign_id
  end
end
