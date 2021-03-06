class StaticPagesController < ApplicationController
  skip_before_action :prevent_guest_acesss, only: [
    :home,
    :register_web,
    :login_web,
    # :register_json,
    # :login_json
  ]
  # skip_before_action :verify_authenticity_token, only: [
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
      if PlantGrossCapacityReading.APPROVED.last
        last_approved_reading = PlantGrossCapacityReading.APPROVED.last
        @target_datetime = last_approved_reading.target_datetime
        # start_of_approved_day_time = Time.utc(target_datetime.year, target_datetime.month, target_datetime.day )

        target_datetimes = 24.times.map{|hour| Time.utc(@target_datetime.year, @target_datetime.month, @target_datetime.day, hour)}
      else
        # start_of_approved_day_time = Time.now
        @target_datetime = Time.now
        target_datetimes = 24.times.map{|hour| Time.utc(@target_datetime.year, @target_datetime.month, @target_datetime.day, hour)}
      end

      # @approved_plant_gross_capacity_readings = PlantGrossCapacityReading.APPROVED.where("target_datetime >= (?)", start_of_approved_day_time)
      @approved_plant_gross_capacity_readings = PlantGrossCapacityReading.APPROVED.where(target_datetime: target_datetimes)
      render 'private_home'
    end
  end

  # OK
  def login_web
    person = Person.find_by(email: login_params.fetch(:email))

    if person && person.authenticate(login_params.fetch(:password))
      session[:token] = person.token
      flash[:success] = 'Successfully logged in.'
    else
      flash[:warning] = 'Wrong email or password.'
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

  def export
    @body_class = 'export'

    # NOTE: MODEL_LOADER
    Dir.glob("./app/models/*.rb").map{|path| path.sub("./app/models/", '')}.each do |line|
      model_name = line.split('.').first
      model_name.camelize.constantize
    end
    @interval_models = AbstractIntervalModel.descendants
    @event_models = AbstractEventModel.descendants
  end

  #TODO: Refactor, my eyes!
  def all_dumps
    pwd = Dir.pwd
    Dir.chdir(Rails.root + './public')
    target = './dumps.zip'
    rule = './*.xml'
    FileUtils.rm_f(target)
    `zip -r #{target} #{rule}`
    Dir.chdir(pwd)
    file = File.open(Rails.root + './public' + target)
    send_file(file)
  end

  def generate_dumps
    service = Kribi::Exporter::Performer.new(:all)
    service.perform

    flash[:success] = 'Sucessfully generated dumps.'
    flash.keep
    redirect_to request.referrer
  end

  def readme
    render 'readme'
  end

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
