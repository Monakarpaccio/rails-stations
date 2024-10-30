module Admin
class Admin::SchedulesController < ApplicationController
  def index
    @schedules = Schedule.includes(:movie).where.not(start_time: nil, end_time: nil)
  end

  def new 
    @movie= Movie.find(params[:movie_id])
    @schedule=@movie.schedules.new
  end

  def create
    @movie= Movie.find(params[:movie_id])
    @schedule=@movie.schedules.new(schedule_params)
    if @schedule.save
       redirect_to admin_movie_path(@movie), notice: 'スケジュールが追加されました。'
    else
       render :new 
    end  
  end

  def edit
       @schedule = Schedule.find(params[:id])
  end
    
      def update
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
         redirect_to admin_schedule_path(@schedule), notice: 'スケジュールが更新されました。'
        else
         render :edit
       end
      end
    
      def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        redirect_to admin_schedules_path, notice: 'スケジュールが削除されました。'
      end

      def show
        @schedule = Schedule.find(params[:id])
      end

      private
    
      def schedule_params
        params.require(:schedule).permit(:start_time, :end_time)
      end

    end
  end
