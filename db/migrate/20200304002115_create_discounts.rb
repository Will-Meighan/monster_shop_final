class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :description
      t.integer :item_threshold
      t.integer :percent_discount
      t.timestamps
    end
  end
end
