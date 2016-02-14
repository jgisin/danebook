class CreateHometowns < ActiveRecord::Migration
  def change
    create_table :hometowns do |t|
      t.string :city
      t.integer :state_id

      t.timestamps null: false
    end
  end
end
