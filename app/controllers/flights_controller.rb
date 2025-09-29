class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
  end

  def search
    if params[:origin].blank? || params[:destination].blank? || params[:start_date].blank? || params[:end_date].blank?
      @flights = []
      flash.now[:alert] = "All search fields are required."
    else
      @flights = Flight.where(origin: params[:origin], destination: params[:destination])
        .where("departure >= ? AND departure <= ?", params[:start_date], params[:end_date])
    end
    render :index
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
