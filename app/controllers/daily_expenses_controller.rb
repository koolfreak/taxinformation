
require 'date'

class DailyExpensesController < ApplicationController

	def new
	end

	def index
		time = Time.new
		@initExpenseDate = time.strftime("%m/%d/%Y")
	end

	def create
		@dailyExpense = DailyExpense.new(items: params[:items],amount: params[:amount])
		@dailyExpense.expenseDate = Date.strptime(params[:dateEntry],"%m/%d/%Y")

		if @dailyExpense.save
			render :json => { 
		         :success => true
		    }.to_json
		else
			render :json => { 
		         :success => false
		    }.to_json
		end
			
	end

	def update 
	end

	def destroy
		@dailyExpense = DailyExpense.find(params[:id])
		@dailyExpense.delete
		render :json => { 
		         :success => true
		    }.to_json
	end
	
	def getDateExpense
		expenseDate = Date.strptime(params[:expenseDate],"%m/%d/%Y")
		expenses =  DailyExpense.where(:expenseDate => expenseDate)  #params[:expenseDate]
		arr = Array.new
		for ex in expenses
			arr << [ex.items, ex.amount, ex.id]
		end
		render :json => { 
		         :data => arr
		    }.to_json
	end
end
