class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity_type
      t.integer :activity_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :activities, [:activity_type, :activity_id]
  end
end
