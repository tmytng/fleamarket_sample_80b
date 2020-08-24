class ProductImg < ApplicationRecord
    belongs_to :product, optional: true
    mount_uploader :image, ImageUploader
    validates :image, presence: true
end