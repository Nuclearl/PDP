class RoomsController < ApplicationController
  def show
    @room = Room.find_by(id: params[:id])
  end
end
