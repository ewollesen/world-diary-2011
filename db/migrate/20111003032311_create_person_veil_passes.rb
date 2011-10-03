class CreatePersonVeilPasses < ActiveRecord::Migration
  def change
    create_table :person_veil_passes do |t|
      t.references :person, :null => false
      t.references :user, :null => false
      t.boolean :includes_uploads, :default => true, :null => false

      t.timestamps
    end
    add_index :person_veil_passes, :person_id
    add_index :person_veil_passes, :user_id
  end
end
