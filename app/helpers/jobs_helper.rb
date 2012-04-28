module JobsHelper

  def job_title (job)
     case job.job_type
	when "job"
		{:job_title => "de treball", :empresa => "Empresa", :departament => "Departament", :position => "Posicio", :currentjob => "Feina actual" }
	when "course"
		{:job_title => "de curs", :empresa => "Institucio que ho impartia", :departament => "Departament", :position => "Tipus de curs", :currentjob => "En curs"}
        when "abroad"
		{:job_title => "d'estada a l'estranger"}
     end
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

end

