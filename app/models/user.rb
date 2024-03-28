class User < ApplicationRecord
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  has_secure_password
  validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_confirmation, presence: true, if: -> { password.present? }
  validates :password, length: { minimum: 4 }, if: -> { new_record? || !password.nil? }
end
