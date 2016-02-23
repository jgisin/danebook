class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :birth_month_id
      t.integer :year_id
      t.integer :birth_day
      t.integer :sex_id
      t.integer :user_id

      t.integer :college_id
      t.integer :hometown_id
      t.integer :currently_live_id
      t.string :telephone
      t.text :words_to_live_by
      t.text :about_me

      t.integer :profile_photo_id

      t.timestamps null: false
    end
  end
end
