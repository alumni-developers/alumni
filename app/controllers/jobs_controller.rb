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
  end
  def newcourse
    @job  = Job.new
  end
  def newabroad
    @job  = Job.new
  end

  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job destroyed."
    redirect_to current_user
  end
end
