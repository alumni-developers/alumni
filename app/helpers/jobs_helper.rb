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
end
#title, institution, department, position, current_job
