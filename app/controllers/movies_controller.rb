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
end