class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update] 
  before_filter :admin_user,   :only => [:create, :new, :destroy]
  
  def create
    @user = User.new(params[ :user])
    if @user.save
      #sign_in @user
      flash[:success] = "Usuari creat!"
      #redirect_to @user
    else
      @title = "Afegir un nou usuari"
      render 'new'
    end
  end

  def index
    @title = "Tots els alumni"
    @users = User.paginate(:page=>params[ :page])
  end
  
  def show
    @user = User.find(params[ :id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Registre"
  end

  def edit
    @title = "Editar usuari"
  end

  def update
    @user=User.find(params[ :id])
    if @user.update_attributes(params[ :user])
      flash[ :success] = "Perfil actualitzat."
      redirect_to @user
    else
      @title = "Editar usuari"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

	def authenticate
		deny_access unless signed_in?
	end

	def correct_user
		@user=User.find(params[ :id])
		redirect_to(root_path) unless current_user?(@user)
	end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
