class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :authenticate, only: %i[index edit show create destroy new]
  # GET /users or /users.json
  def index
    @users = User.all
    render :json=>{message:"User has been authorized"}
  end

  # GET /users/1 or /users/1.json
  def show
    @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render :json=>{message: "edit method"}
  end

  # POST /users or /users.json
  def create
    @user = User.new
    @user.name = params[:name]
    @user.mobile = params[:mobile]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    begin
      @user.save!
      render 'users/index'
    rescue => error
      raise UnknownError.new(error.message)
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    begin
      # @user = User.find(params[:id])
      raise ValidationError.new("You do not have the access to perform this action") if params[:id] != @user.id
      @user.name = params[:name]
      @user.password = params[:password]
      @user.save!

      render 'users/show'
    rescue ValidationError=> error
      raise ValidationError.new(error.message)
    rescue => error
      raise UnknownError.new(error.message)
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit( :name, :mobile, :password, :password_confirmation)
    end
end
