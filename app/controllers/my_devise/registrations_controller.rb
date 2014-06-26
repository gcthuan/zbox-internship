class MyDevise::RegistrationsController < Devise::RegistrationsController

  def update
	super
	#@job = Job.find_by_name(current_user.job_name)
	#  if @job.valid?
	#	  @users.jobs << @job
	#  end
  end

end