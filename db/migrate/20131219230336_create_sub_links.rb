class CreateSubLinks < ActiveRecord::Migration
  def change
    create_table :sub_links do |t|
      t.integer :sub_id, :null => false
      t.integer :link_id, :null => false

      t.timestamps
    end

    add_index :sub_links, :sub_id
  end
end
