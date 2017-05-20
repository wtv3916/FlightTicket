class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.string :flight
      t.datetime :schedule
      t.string :from_addr
      t.string :to_addr
      t.integer :weekdays_reg_price
      t.integer :weekdays_rew_price
      t.integer :weekends_reg_price
      t.integer :weekends_rew_price
    end
  end
end
