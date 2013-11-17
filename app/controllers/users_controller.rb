class UsersController < ApplicationController
  before_action :signed_in, only: [:edit, :update, :newpost]
  before_action :correct_user, only: [:edit, :update]

  # GET /users/1
  # GET /users/1.json
  def show
     @user = User.find(params[:id])
    @stashes=Stash.where(user_id: @user.id)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to @user
      else
        render action: 'edit'
      end
    end
  end

def newpost
  stash=Stash.find(params[:stash][:id])
  stash.posts.create(:url=>params[:url])
        redirect_to :back
  end

def newstash
  current_user.stashes.create(:name=>params[:name], :user_id=>current_user.id, :score=>0)
        redirect_to :back
end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(signin_url, notice:'Incorrect User') unless current_user==@user
    end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
