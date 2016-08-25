class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  EMAIL_REGEX = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|‌​([A-Za-z0-9]+\++))*[‌​A-Za-z0-9]+@((\w+\-+‌​)|(\w+\.))*\w{1,63}\‌​.[a-zA-Z]{2,6}$/‌​i
  validates :name, :email, :password, presence: true, :on => :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

end
