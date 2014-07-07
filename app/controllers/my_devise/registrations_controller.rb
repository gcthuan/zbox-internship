class MyDevise::RegistrationsController < Devise::RegistrationsController
  def create 
	 super
   resource.create_activity :create, owner: resource
  end 

=begin
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        flash[:success] = "You have successfully applied for the job. Please wait until we finish considering your document."
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
=end
 end