class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    
    # スクリーンを考慮した予約の重複確認
    if Reservation.exists?(schedule_id: @reservation.schedule_id, sheet_id: @reservation.sheet_id, date: @reservation.date, screen_id: @reservation.sheet.screen_id)
      render json: { error: "その座席はすでに予約済みです" }, status: :bad_request and return
    end
    
    if @reservation.save
      redirect_to admin_reservations_path, notice: "予約が完了しました"
    else
      render json: { error: @reservation.errors.full_messages }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotUnique
    # ユニーク制約に違反した場合に 400 を返す
    render json: { error: "その座席はすでに予約済みです" }, status: :bad_request
  end
  

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    
    # スクリーンを考慮した予約の重複確認
    if Reservation.exists?(schedule_id: reservation_params[:schedule_id], sheet_id: reservation_params[:sheet_id], date: reservation_params[:date], screen_id: @reservation.sheet.screen_id) && 
       (Reservation.find_by(schedule_id: reservation_params[:schedule_id], sheet_id: reservation_params[:sheet_id], date: reservation_params[:date], screen_id: @reservation.sheet.screen_id) != @reservation)
      flash.now[:alert] = 'その座席はすでに予約済みです。'
      render :show and return
    end
  
    if @reservation.update(reservation_params)
      flash[:notice] = '予約が更新されました'
      redirect_to admin_reservation_path(@reservation)
    else
      flash.now[:alert] = 'エラーが発生しました。確認してください。'
      render :show
    end
  end
  
  
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    flash[:notice] = '予約が削除されました'
    redirect_to admin_reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email, :date)
  end
end
