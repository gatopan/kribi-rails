class Token < ApplicationRecord
  self.inheritance_column = nil

  enum reedemed: {
    false: 0,
    true: 1
  }

  enum type: {
    access: 0,
    activation: 10,
    reset_password: 20,
    assign_privilege: 30
  }

  validates :token, {
    presence: true
  }

  before_validation do
    self.token ||= calculated_token
  end

  def calculated_token
    calculated_token = nil

    loop do
      calculated_token = SecureRandom.hex
      break unless self.class.exists?(token: calculated_token)
    end

    calculated_token
  end
end
