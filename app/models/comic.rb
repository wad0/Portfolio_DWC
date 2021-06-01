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
    # 更新順
    when 'new'
      all.order(created_at: :DESC)
    when 'old'
      all.order(created_at: :ASC)
    # お気に入り度順
    when 'rate'
      all.order(evaluation: :DESC)
    when 'lowrate'
      all.order(evaluation: :ASC)
    # 完結
    when 'complete'
      Comic.where(complete: true).order('updated_at DESC')
    # 未完結
    when 'still'
      Comic.where(complete: false).order('updated_at DESC')
    end
  end

  validates :title, presence: true
  validates :evaluation, presence: true

  acts_as_taggable
end
