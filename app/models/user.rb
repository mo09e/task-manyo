class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many :tasks, dependent: :destroy

  before_destroy :can_not_destroy_admin_user
  before_update  :change_admin

  private
  def can_not_destroy_admin_user
    if self.admin && User.where(admin: true).count > 1
      throw(:abort)
    end
  end

  def change_admin
    if User.where(admin: true).count == 1 && self.admin_changed?(from: true, to: false)
      errors.add :base, "管理者が一人も居ない状態にはできません！"
      throw(:abort)
    end
  end
end
