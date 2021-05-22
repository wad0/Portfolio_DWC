class Comic < ApplicationRecord

  belongs_to :user
  has_many :keeps, dependent: :destroy

  def kept_by?(user)
    keeps.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search
      Comic.where(['title LIKE ?', "%#{search}%"])
    else
      Comic.none
    end
  end

  def self.sort(sort)
    case sort
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'rate'
      return all.order(evaluation: :DESC)
    when 'lowrate'
      return all.order(evaluation: :ASC)
    end
  end

  validates :title, presence: true
  validates :evaluation, presence: true

  acts_as_taggable

end
