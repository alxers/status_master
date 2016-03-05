class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :yesterday_info
      t.text :today_info
      t.text :blockers_info
      t.references :user, index: true, foreign_key: true
      t.boolean :goals_achieved, default: false, null: false
      t.date :date

      t.timestamps null: false
    end
  end
end
