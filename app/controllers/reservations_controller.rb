class ReservationsController < ApplicationController
# 座席予約フォームの表示

def new
  if params[:date].blank? || params[:sheet_id].blank?
    redirect_to movies_path, alert: "必要なパラメータが不足しています。"
  else
  @reservation=Reservation.new
  @movie = Movie.find(params[:movie_id])
  @schedule = Schedule.find(params[:schedule_id])
  @sheet = Sheet.find_by(id: params[:sheet_id])
  @schedule_id = @schedule.id
  @date = params[:date]
  @movie_id = params[:movie_id]
  end
end

# 座席予約の登録処理
 def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to movie_path(@reservation.schedule.movie.id), status: 302
    else
      flash[:alert] = "その座席はすでに予約済みです"
    redirect_to movie_reservation_path(movie_id: @reservation.schedule.movie.id, 
        schedule_id: @reservation.schedule_id, 
        date: @reservation.date), status: 302
    end
  end


private

def reservation_params
  params.require(:reservation).permit(:name, :email, :schedule_id, :sheet_id, :date)
end

end
