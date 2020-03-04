require 'rails_helper'

RSpec.describe "As a visitor on the discount show page" do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @merchant_1 = @megan.users.create!(name: "Meg", address: "123 main", city: "Denver", state: "CO", zip: 80204, email: "merchant1@gmail.com", password: "password", role: 1)

    @discount_1 = @megan.discounts.create!(description: 'Small Discount', item_threshold: 20, percent_discount: 5 )

    @discount_2 = @megan.discounts.create!(description: 'Large Discount', item_threshold: 40, percent_discount: 10 )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit "/merchant"
    click_link "Discounts"
  end

  it "I can see discount info" do
    click_link "#{@discount_1.description}"

    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")

    expect(page).to have_content("#{@discount_1.description}")
    expect(page).to have_content("Item threshold: #{@discount_1.item_threshold}")
    expect(page).to have_content("Percent discount: #{@discount_1.percent_discount}")
  end
end
