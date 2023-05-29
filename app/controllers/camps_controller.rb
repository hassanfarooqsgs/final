class CampsController < ApplicationController
  before_action :set_camp, except: %i[index] 

  def index    
    @camps= Camp.page(params[:page]).per(3)

    if params[:search].present?
      @camps = Camp.search(params[:search]).page(params[:page]).per(3)
    end

    column = params[:column] || 'id'
    direction = params[:direction] || 'asc'
    @camps = @camps.order("#{column} #{direction.upcase}") 
  end

  def edit; end
  
  def new
    @camp=Camp.new
  end
  
  def show; end
  
  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to camps_path, notice: 'Camp created successfully.'
    else
      render :new
    end
  end
  
  def export_csv
    @camps = Camp.all
    require 'csv'
    
    respond_to do |format|
      format.csv { send_data @camps.to_csv, filename: 'camp.csv' }
    end
  end
  
  def update
    if @camp.update(camp_params)
    redirect_to camps_path, notice: 'Camp updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_path, notice: 'Camp deleted successfully.'
  end
  
  def status
    @camp.update(status: @camp.inactive? ? 'active' : 'inactive')
    redirect_to camps_path, notice: 'Camp status updated successfully.'
  end

  def select
    @active_camps = Camp.where(status: 'active')
  end

  private
  def set_camp
    @camp = Camp.find_by(id: params[:id])
  end

  def camp_params
    params.require(:camp).permit(
     :title,
     :location,
     :id, 
     :start_date, 
     :end_date, 
     :status
    )
  end
end
