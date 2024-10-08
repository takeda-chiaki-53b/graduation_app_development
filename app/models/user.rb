class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 権限判定用
  enum role: { general: 0, brand_admin: 1, app_admin: 2 }

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :products, dependent: :destroy

  # スコープ
  scope :brand_admins, -> { where(role: "brand_admin") }

  # オブジェクトの user_idがユーザーオブジェクトのidと一致するかどうかを判定
  def own?(object)
    id == object&.user_id
  end
end
