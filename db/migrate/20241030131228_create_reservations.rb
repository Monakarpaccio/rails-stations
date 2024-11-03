class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    drop_table :reservations, if_exists: true
    create_table :reservations do |t|
      t.date :date, null: false
      t.bigint :schedule_id, null: false  # 型を bigint に変更
      t.bigint :sheet_id, null: false     # 型を bigint に変更
      t.string :email, null: false, comment: '予約者メールアドレス'
      t.string :name, null: false, limit: 50, comment: '予約者名'

      t.timestamps
    end
    add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true, name: 'reservation_schedule_sheet_unique'

    # 外部キーを追加
    add_foreign_key :reservations, :schedules, column: :schedule_id
    add_foreign_key :reservations, :sheets, column: :sheet_id
  end
end
