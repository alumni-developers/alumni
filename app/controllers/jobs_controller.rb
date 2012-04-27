class JobsController < ApplicationController
  
  def index
  end
  
  def show
    @job=Job.find(params[:id])
    @title=@job.institution
    @user=@job.user    
  end

  def createjob
    @job  = current_user.jobs.build(params[:job].merge({:job_type =>"job"}))
    if @job.save
      flash[:success] = "Job created!"
      redirect_to current_user
    else
      render 'pages/home'
    end
  end

  def createcourse
    @job  = current_user.jobs.build(params[:job].merge({:job_type =>"course"}))
    if @job.save
      flash[:success] = "Job created!"
      redirect_to current_user
    else
      render 'pages/home'
    end
  end

    def createabroad
    @job  = current_user.jobs.build(params[:job].merge({:job_type =>"abroad"}))
    if @job.save
      flash[:success] = "Job created!"
      redirect_to current_user
    else
      render 'pages/home'
    end
  end

  def newjob
    @job  = Job.new
    @title = "Crea una nova entrada de feines"
  end
  def newcourse
    @job  = Job.new
    @title = "Crea una nova entrada de cursos"
  end
  def newabroad
    @job  = Job.new
    @title = "Crea una nova entrada d'estades a l'estranger"
  end

  def update
    @job  = current_user.jobs.find(params[:id])
    if @job.update_attributes(params[:job])
      flash[:success] = "Entrada actualitzada!"
      redirect_to current_user
    else
      render 'pages/home'
    end
  end
  def edit
    @job  = current_user.jobs.find(params[:id])
    @title = "Edita una entrada"
  end



  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job destroyed."
    redirect_to current_user
  end
end
