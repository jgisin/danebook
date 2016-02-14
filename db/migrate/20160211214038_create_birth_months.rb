class CreateBirthMonths < ActiveRecord::Migration
  def change
    create_table :birth_months do |t|
      t.string :month
      t.string :abbr

      t.timestamps null: false
    end
  end
end
