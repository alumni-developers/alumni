class UsersController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update] 
  before_filter :admin_user,   :only => [:create, :new, :destroy]
  
  def create
    @user = User.new(params[ :user])
    if @user.save
      #sign_in @user
      flash[:success] = "Usuari creat!"
      redirect_to users_path
    else
      @title = "Afegir un nou usuari"
      render 'new'
    end
  end

  def index
    @title = "Tots els alumni"
    search_p=User.search(params[:search])
    if !search_p.empty?
       users_relation=User.where(search_p[0],search_p[1])
       if users_relation.empty?
          flash.now[:notice] = "No s'ha trobat cap resultat, es mostra el directori complet."
         users_relation = User
       end
    else
       users_relation = User
    end
    @users = users_relation.paginate(:page=>params[:page],:per_page=>10)
  end
  
  def show
    @user = User.find(params[ :id])
    @title = @user.name
    @jobs = @user.jobs.find(:all, :conditions => ['job_type LIKE ?', "job"])
    @courses = @user.jobs.find(:all, :conditions => ['job_type LIKE ?', "course"])
    @abroad = @user.jobs.find(:all, :conditions => ['job_type LIKE ?', "abroad"])
  end

  def new
    @user = User.new
    @title = "Registre"
  end

  def edit
    @user=User.find(params[ :id])
    @title = "Editar usuari"
  end

  def update
    @user=User.find(params[ :id])
    if @user.update_attributes(params[:user])
      flash[ :success] = "Perfil actualitzat."
      sign_in @user
      redirect_to @user
    else
      @title = "Editar usuari"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuari eliminat."
    redirect_to users_path
  end

  private

	def correct_user
		@user=User.find(params[ :id])
		redirect_to(users_path) unless (current_user?(@user) or current_user.admin?)
	end
	
	def tab
	   respond_to do |format|
	     format.js
	   end
	end
end
