class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

        has_many :user_mangas
        has_many :mangas, through: :user_mangas
        
        validates :name, presence: true

  after_create :send_welcome_email
 
  protected
  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_later
  end
  
end
