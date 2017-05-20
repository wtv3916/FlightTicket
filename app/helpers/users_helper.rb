module UsersHelper
	def regular?
		if current_user.customer_type == 'regular'
			return true
		else 
			return false
		end
	end
	def reward?
		if current_user.customer_type == 'reward'
			return true
		else 
			return false
		end
	end
end
