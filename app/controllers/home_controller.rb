class HomeController < ApplicationController

	def index
		if authenticate_user!
			redirect_to :controller => 'daily_expenses', :action => 'index'
		end
	end
end
