class StaticPagesController < ApplicationController
  skip_before_filter :prevent_guest_acesss, only: [
    :home,
    :register_web,
    :login_web,
    # :register_json,
    # :login_json
  ]
  # skip_before_filter :verify_authenticity_token, only: [
  #   :register_json,
  #   :login_json
  # ]

  # OK
  def register_web
    person = Person.new(registration_params)
    person.role = :CLERK

    if person.save
      # send activation email
      session[:token] = person.token
      flash[:success] = 'Sucessfully registered. Please check your email inbox for activation instructions'
    else
      flash[:warning] = person.errors.messages
    end

    flash.keep
    redirect_to home_path
  end

  # OK
  def home
    case current_person.role
    when 'GUEST'
      render 'public_home', layout: false
    else
      render 'private_home'
    end
  end

  # OK
  def login_web
    person = Person.find_by(email: login_params.fetch(:email))

    if person && person.authenticate(login_params.fetch(:password))
      session[:token] = person.token
      flash[:success] = 'Successfully logged in'
    else
      flash[:warning] = 'Bad email or password'
    end

    flash.keep
    redirect_to home_path
  end

  # OK
  def logout_web
    current_person.generate_new_token! unless current_person.GUEST?
    session.clear
    redirect_to home_path
  end

  # OK
  # def register_json
  #   person = Person.new(registration_params)
  #   person.role = :CLERK
  #
  #   if person.save
  #     # send activation email
  #     render_server_ok(person.token)
  #   else
  #     render_bad_request(person.errors.messages)
  #   end
  # end

  # def login_json
  #   person = Person.find_by(email: login_params.fetch(:email))
  #
  #   if person && person.authenticate(login_params.fetch(:password))
  #     render_server_ok(person.token)
  #   else
  #     render_bad_request('Bad email or password')
  #   end
  # end


  # def logout_json
  #   current_person.generate_new_token! unless current_person.GUEST?
  #   render_server_ok('Successfully logged out')
  # end

  private

  def registration_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :email_confirmation,
      :password,
      :biography
    )
  end

  def login_params
    params.permit(
      :email,
      :password
    )
  end
end
