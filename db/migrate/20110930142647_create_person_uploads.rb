class CreatePersonUploads < ActiveRecord::Migration
  def change
    create_table :person_uploads do |t|
      t.string :upload, :null => false
      t.string :caption
      t.references :person, :null => false
      t.boolean :private, :default => true, :null => false
      t.boolean :visible_with_vp, :default => false, :null => false

      t.timestamps
    end
    add_index :person_uploads, :person_id
  end
end
