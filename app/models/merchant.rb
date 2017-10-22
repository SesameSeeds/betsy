class Merchant < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :nullify

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, uniqueness: true

  def average_rating
    return if !products # exit if no products

    num_reviews = 0
    rating = 0

    products.each do |product|
      product.reviews.each do |review|
        num_reviews += 1
        rating += review.rating
      end
    end

    return (rating.to_f / num_reviews).round(1)
  end
  # validate :merchant_cannot_have_user_of_another_merchant
  #
  # #TODO Ask about has_one relationships
  # def merchant_cannot_have_user_of_another_merchant
  #   other_merchants = Merchant.where.not(id: self.id)
  #   other_merchants.each do |merchant|
  #     if merchant.user == self.user
  #       errors.add(:user, "user can't belong to more than one merchant")
  #     end
  #   end
  # end
end
