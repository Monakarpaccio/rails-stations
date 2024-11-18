class AddUserToReservations < ActiveRecord::Migration[7.1]
  def change
  
    reversible do |dir|
      dir.up do
        Reservation.reset_column_information
        Reservation.find_each do |reservation|
          # 仮にemailでユーザーを識別し、既存の予約に紐づける
          user = User.find_by(email: reservation.email)
          reservation.update(user: user) if user
        end
      end
    end
  end
end
