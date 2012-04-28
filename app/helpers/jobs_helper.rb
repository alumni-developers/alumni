module JobsHelper

<<<<<<< HEAD
  def job_title (job)
      case job.job_type
        	when "job"
        		{:job_title => "de treball", :empresa => "Empresa", :departament => "Departament", :position => "Posicio", :currentjob => "Feina actual" }
        	when "course"
        		{:job_title => "de curs", :empresa => "Institucio que ho impartia", :departament => "Departament", :position => "Tipus de curs", :currentjob => "En curs"}
          when "abroad"
        		{:job_title => "d'estada a l'estranger"}
      end
=======
  def job_text (job)
     case job.job_type
	when "job"
		{:job_title => "de treball", :empresa => "Empresa", :departament => "Departament", :position => "Posicio", :currentjob => "Feina actual" }
	when "course"
		{:job_title => "de curs", :empresa => "Institucio que l'impartia", :departament => "Nom del curs", :position => "Tipus de curs", :currentjob => "En curs"}
        when "abroad"
		{:job_title => "d'estada a l'estranger", :currentjob => "Estada actual"}
     end
>>>>>>> 23b115056e6ffb44e76cf38357f5331dd912f427
  end
  
  def date_format (month)
     if month.nil?
	"%Y"
     else
	"%m/%Y"
     end
  end  

  def e_date (job)
     if job.current_job==1
	"Avui"
     else
 	job.e_date.strftime(date_format(job.e_month))
     end
  end

  def s_date(job)
     job.s_date.strftime(date_format(job.s_month))
  end
  
  def e_date_long (job)
     if job.current_job==1
	" fins avui."
     else
 	job.e_date.strftime(" fins al #{date_format(job.e_month)}.")
     end
  end

  def s_date_long (job)
     job.s_date.strftime("Des del #{date_format(job.s_month)}")
  end
end

