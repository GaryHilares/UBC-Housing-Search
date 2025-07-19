class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
  end

  def create
    if !params.has_key?(:email) || !params.has_key?(:password) || !params.has_key?(:password_confirmation) || params[:password] != params[:password_confirmation]
      flash[:alert] = "Email is already associated to an account."
      redirect_to new_session_path
    elsif User.exists?(email_address: params[:email])
      flash[:alert] = "Email is already associated to an account."
      redirect_to new_user_path()
    else
      User.new(email_address: params[:email], password: params[:password]).save
      redirect_to new_session_path
    end
  end
end
