class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
  end

  def search
    @flights = Flight.where(origin: params[:origin], destination: params[:destination])
    .where("departure >= ? AND departure <= ?", params[:start_date], params[:end_date])
    render :index
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
