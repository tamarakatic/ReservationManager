class Employees::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  include ApplicationHelper

  # GET /resource/sign_up
  def new
    @employee = Employee.new(:manager_id => params[:manager_id],
                             :type => params[:type])
    @type = params[:type]

    super
  end

  # POST /resource
  def create
    password = generate_password
    params[:employee][:password] = password
    params[:employee][:password_confirmation] = password

    super
  end

  # GET /resource/edit
   def edit
     super
   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [
      :password_changed,
      :firstname,
      :lastname,
      :shoe_size,
      :birth_date,
      :clothing_size,
      :speciality])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :firstname,
      :lastname,
      :shoe_size,
      :birth_date,
      :clothing_size,
      :manager_id,
      :speciality])
  end
end
