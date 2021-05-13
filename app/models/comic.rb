class Comic < ApplicationRecord

  belongs_to :user
  has_many :keeps, dependent: :destroy

  def  kept_by?(user)
    keeps.where(user_id: user.id).exists?
  end

end
