class HoardController < ApplicationController
  
  def index
    @user = params[:user]
  end

end
