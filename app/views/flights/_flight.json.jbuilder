json.extract! flight, :id, :flight, :schedule, :from, :to, :weekdays_reg_price, :weekdays_rew_price, :weekends_reg_price, :weekends_rew_price, :created_at, :updated_at
json.url flight_url(flight, format: :json)
