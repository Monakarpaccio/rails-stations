class CreateScreens < ActiveRecord::Migration[7.1]
  def change
    create_table :screens do |t|
      t.string :name
      t.references :movie, null: false, foreign_key: true
      t.integer :screen_number

      t.timestamps
    end
  end
end
