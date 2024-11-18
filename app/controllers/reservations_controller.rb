class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movies_path, alert: "必要なパラメータが不足しています。", status: 302
    else
      @reservation = Reservation.new
      @movie = Movie.find(params[:movie_id])
      @schedule = Schedule.find(params[:schedule_id])
      @sheet = Sheet.find_by(id: params[:sheet_id])
      @schedule_id = @schedule.id
      @date = params[:date]
      @movie_id = params[:movie_id]
    end
  end

  def create
    screen_id = reservation_params[:screen_id]
    Rails.logger.info("Received screen_id: #{screen_id}")
  
    if screen_id.blank?
      flash[:alert] = "スクリーンIDが提供されていません。"
      redirect_to movies_path, status: 302
      return
    end

    @schedule = Schedule.find(reservation_params[:schedule_id])
    @screen = Screen.find_by(screen_id)
  
    
    # デバッグ用にスクリーンの情報を確認
    if @screen.nil?
      Rails.logger.debug("スクリーンが見つかりません。screen_id: #{params[:screen_id]}")
      flash[:alert] = "スクリーンが見つかりません。"
      redirect_to movies_path and return
    end
  
    # 予約がすでに存在するか確認
    existing_reservation = Reservation.where(
      schedule_id: reservation_params[:schedule_id],
      sheet_id: reservation_params[:sheet_id],
      date: reservation_params[:date]
    ).exists?
  
    if existing_reservation
      # 既に予約がある場合
      flash[:alert] = "その座席はすでに予約済みです"
      redirect_to movie_reservation_path(movie_id: reservation_params[:movie_id], schedule_id: reservation_params[:schedule_id], date: reservation_params[:date]), status: 302
    else
      # 新規予約の作成
      @reservation = Reservation.new(reservation_params.merge(user: current_user, screen_id: @screen.id))
  
      if @reservation.save
        flash[:notice] = "予約が完了しました"
        redirect_to movie_path(@reservation.schedule.movie.id), status: 302
      else
        flash[:alert] = "予約に失敗しました: #{@reservation.errors.full_messages.join(', ')}"
        redirect_to movie_reservation_path(movie_id: reservation_params[:movie_id], schedule_id: reservation_params[:schedule_id], date: reservation_params[:date]), status: 302
      end
    end
  end
  

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :schedule_id, :sheet_id, :date, :screen_id)
  end
end  
