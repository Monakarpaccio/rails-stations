module Admin
class Admin::MoviesController < ApplicationController
  def index
    @movies=Movie.all
  end

  def new 
    @movie=Movie.new
  end

  def create
    @movie=Movie.new(movie_params)
    if @movie.save
      flash[:notice] = '映画が登録されました。'
      redirect_to admin_movies_path
    else 
      flash[:notice]= '登録失敗しました'
      render :new
     end
  end

  def edit
    @movie= Movie.find(params[:id])
  end

  def update
   @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = "映画情報が更新されました。"
     redirect_to admin_movies_path
    else
      flash[:alert] = "エラーが発生しました。もう一度確認してください。"
      render :edit
   end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "映画が削除されました。"
    redirect_to admin_movies_path
  end

private
  def movie_params
  params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end
end