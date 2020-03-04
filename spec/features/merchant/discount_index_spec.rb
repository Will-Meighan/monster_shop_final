require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

    @merchant_1 = @megan.users.create!(name: "Meg", address: "123 main", city: "Denver", state: "CO", zip: 80204, email: "merchant1@gmail.com", password: "password", role: 1)

    @discount_1 = @megan.discounts.create!(description: 'Small Discount', item_threshold: 20, percent_discount: 5 )

    @discount_2 = @megan.discounts.create!(description: 'Large Discount', item_threshold: 40, percent_discount: 10 )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit "/merchant"
  end

  it "has a link to the discounts index page" do
    click_link "Discounts"
    expect(current_path).to eq("/merchant/discounts")

    within"#discount-#{@discount_1.id}" do
      expect(page).to have_link(@discount_1.description)
    end

    within"#discount-#{@discount_2.id}" do
      expect(page).to have_link(@discount_2.description)
    end
  end

  it "has a link to add a new discount from merchant discounts index page" do
    click_link "Discounts"
    expect(current_path).to eq("/merchant/discounts")

    click_link "Add Discount"
    expect(current_path).to eq("/merchant/discounts/new")

    fill_in :description, with: "20% discount"
    fill_in :item_threshold, with: 5
    fill_in :percent_discount, with: 20
    click_button "Submit"

    expect(current_path).to eq("/merchant/discounts")
    expect(page).to have_content("Your discount has been added.")
  end

end
