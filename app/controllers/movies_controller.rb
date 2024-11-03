class MoviesController < ApplicationController
  def index
    @movies = Movie.all

  # キーワードによる検索
  if params[:keyword].present?
    keyword = params[:keyword]
    @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

   # 公開状態のフィルタリング
   if params[:is_showing].present?
    @movies = @movies.where(is_showing: params[:is_showing] == "1")
  end
  end
   def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules.includes(:reservations)
  end

  def reservation
    # スケジュールIDと日付が指定されていない場合、映画リストにリダイレクト
    unless params[:schedule_id].present? && params[:date].present?
      return redirect_to movies_path, status: 302
    end

    # 映画、スケジュール、日付を取得
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @date = params[:date]
    @sheets = Sheet.all # 全座席情報を取得して表示
  end

end