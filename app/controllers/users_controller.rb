class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_request, only: %i[update]
  after_action :chill
  # GET /users or /users.json
  def index
    @users = User.all
    render :json=>{message:"User has been authorized"}
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    puts "in edit method"
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
      render json: {message: "record created successfully"}
      # format.html { redirect_to @user, notice: "User was successfully created." }
      # format.json { render :show, status: :created, location: @user }
    rescue =>error
      render json: {message: error}
      # format.html { render :new, status: :unprocessable_entity }
      # format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    begin
      @user = User.find(params[:id])
      @user.name = params[:name]
      @user.password = params[:password]
      @user.save!

      render :json=>{message:"Updated successfully"}
    rescue =>error
      render json:{message:error}
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

    def chill
      puts "just after action"
    end
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit( :name, :mobile, :password, :password_confirmation)
    end
end
