class CreateSheets < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:sheets)
      create_table :sheets do |t|
        t.integer :column
        t.string :row
      end
    end
  end
end
