class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        if resource.active_for_authentication?
          flash[:notice] = "Welcome! You have signed up successfully."
          redirect_to after_sign_up_path_for(resource), status: 302 and return
        else
          flash[:notice] = "You have signed up successfully. However, we could not sign you in."
          redirect_to after_inactive_sign_up_path_for(resource), status: 302 and return
        end
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    root_path
  end
end
