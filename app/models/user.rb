class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_initialize :default_to_standard
  has_many :wikis, dependent: :destroy
  # maybe try :wikis, dependent: :delete_all ???


  after_save do 
    if role_changed?
      if role == "standard"
        wikis.where(private: true).each do |w|
          w.private = false
          w.save
        end
      end
    end
  end

  def admin?
    role == 'admin'
  end

  # Paid accounts
  def premium?
    role == 'premium'
  end

  # Free accounts
  def standard?
    role == 'standard'
  end

  def default_to_standard
    self.role = 'standard' if self.role.nil?
    # Apparently the line below will force the field to true even if you explicitly initialize it to false..
    # self.role ||= 'standard' if self.role.nil?
  end
end