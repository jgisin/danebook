class CreateSexes < ActiveRecord::Migration
  def change
    create_table :sexes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
