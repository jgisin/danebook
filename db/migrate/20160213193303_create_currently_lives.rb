class CreateCurrentlyLives < ActiveRecord::Migration
  def change
    create_table :currently_lives do |t|
      t.string :city
      t.integer :state_id

      t.timestamps null: false
    end
  end
end
