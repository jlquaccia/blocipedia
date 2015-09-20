class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy
end