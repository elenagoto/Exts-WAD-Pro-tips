class UsersController < ApplicationController
    # Includes
  include RolesHelper

  # Before actions
  before_action :ensure_authenticated,   only: [:index, :edit, :update, :destroy]
  before_action :set_user,               only: [:show, :edit, :update, :destroy]
  before_action :authorize_to_edit_user, only: [:edit, :update]
  before_action :ensure_admin,           only: [:index, :destroy]

  # Actions
  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        session[:user_id] = @user.id
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        # In this format call, the flash message is being passed directly to
        # redirect_to().  It's a caonvenient way of setting a flash notice or
        # alert without referencing the flash Hash explicitly.
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_to_edit_user
      redirect_to account_path unless can_edit_user?(@user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :avatar, :password)
    end
end
