class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: :slugged
end