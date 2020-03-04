require 'rails_helper'

RSpec.describe "As a visitor on the edit discount page" do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @merchant_1 = @megan.users.create!(name: "Meg", address: "123 main", city: "Denver", state: "CO", zip: 80204, email: "merchant1@gmail.com", password: "password", role: 1)

    @discount_1 = @megan.discounts.create!(description: 'Small Discount', item_threshold: 20, percent_discount: 5 )

    @discount_2 = @brian.discounts.create!(description: 'Large Discount', item_threshold: 40, percent_discount: 10 )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit '/merchant'
    click_link "Discounts"
  end

  it "I can edit a discount" do
    expect(page).to_not have_link("#{@discount_2.description}")
    click_link "#{@discount_1.description}"

    click_link "Edit"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

    fill_in :description, with: ""

    click_on "Update"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")
    expect(page).to have_content("Description can't be blank")

    fill_in :description, with: "Free"

    click_on "Update"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")
    expect(page).to have_content("Free")
    expect(page).to_not have_content("Small Discount")
  end

end
