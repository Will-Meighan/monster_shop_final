class Discount < ApplicationRecord
  validates_presence_of :description,
                        :item_threshold,
                        :percent_discount

  belongs_to :merchant
end
