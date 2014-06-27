class MyDevise::RegistrationsController < Devise::RegistrationsController

  def update
	super
	@job = Job.find_by_name(current_user.job_name)
	  unless @job.nil?
	  	unless current_user.jobs.where(:id => @job.id).any?
		  current_user.jobs << @job
		  current_user.update_attributes :status => "Submitted"
		end
	  end
  end

 end