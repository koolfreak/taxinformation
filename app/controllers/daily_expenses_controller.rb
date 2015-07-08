class DailyExpensesController < ApplicationController

	def new
	end

	def index
		time = Time.new
		@initExpenseDate = time.strftime("%m/%d/%Y")
	end

	def create
	end

	def update
	end

end
