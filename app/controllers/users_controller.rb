class UsersController < ApplicationController
  before_filter :authenticate, :only=>[ :edit, :update, :update]
  before_filter :correct_user, :only=>[ :edit, :update] 
  
  def create
	@user = User.new(params[ :user])
	if @user.save
		sign_in @user
		flash[:success]="Benvingut al CFIS-Alumni!"
		redirect_to @user
	else
		@title="Registrar-se"
		render 'new'
	end
  end

  def index
    @title="Tots els alumni"
	@users=User.paginate(:page=>params[ :page])
  end
  
  def show
    @user = User.find(params[ :id])
    @title = @user.name
  end

  def new
	@user = User.new
    @title="Sign up"
  end

  def edit
	@title="Edit user"
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

  private

	def authenticate
		deny_access unless signed_in?
	end

	def correct_user
		@user=User.find(params[ :id])
		redirect_to(root_path) unless current_user?(@user)
	end
end
