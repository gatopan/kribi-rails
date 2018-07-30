class Person < ApplicationRecord
  has_secure_password validations: false
  mount_uploader(:avatar, AvatarUploader)

  enum role: {
    GUEST: 0,
    CLERK: 10,
    REVIEWER: 20,
    APPROVER: 30,
  }

  before_validation do
    self.token ||= calculated_token
  end

  validates :first_name, {
    presence: true
  }
  validates :last_name, {
    presence: true
  }
  validates :biography, {
    presence: true
  }
  validates :email, {
    presence: true,
    confirmation: true,
    uniqueness: true,
    email: true
  }
  validates :password, {
    presence: true,
    on: :create # NOTE Explicit context fixes validations during update, conflicts with has_secure_password
  }
  validates :role, {
    presence: true
  }
  validates :token, {
    presence: true
  }

  def full_name
    if GUEST?
      'Guest'
    else
      "#{first_name} #{last_name}"
    end
  end

  def calculated_token
    calculated_token = nil

    loop do
      calculated_token = SecureRandom.hex
      break unless self.class.exists?(token: calculated_token)
    end

    calculated_token
  end

  def generate_new_token!
    self.token = calculated_token
    save!
  end

  def allowed_statuses
    case role
    when 'APPROVER'
      ['PENDING', 'REVIEWED', 'APPROVED']
    when 'REVIEWER'
      ['PENDING', 'REVIEWED']
    when 'CLERK'
      ['PENDING']
    else
      raise StandardError.new('Not implemented')
    end
  end
end
