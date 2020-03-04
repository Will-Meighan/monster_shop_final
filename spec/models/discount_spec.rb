require 'rails_helper'

RSpec.describe Discount do
  describe 'Validations' do
    it {should validate_presence_of :description}
    it {should validate_presence_of :item_threshold}
    it {should validate_presence_of :percent_discount}
  end

  describe 'Relationships' do
    it {should belong_to :merchant}
  end
end
