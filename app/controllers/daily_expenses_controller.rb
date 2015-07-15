
require 'date'

class DailyExpensesController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def new
	end

	def index
		time = Time.new
		@initExpenseDate = time.strftime("%m/%d/%Y")
	end

	def create
		@dailyExpense = DailyExpense.new(items: params[:items],amount: params[:amount])
		@dailyExpense.expenseDate = Date.strptime(params[:dateEntry],"%m/%d/%Y")
		@dailyExpense.user = current_user

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
		@dailyExpense = current_user.daily_expense.find(params[:id])
		@dailyExpense.delete
		render :json => { 
		         :success => true
		    }.to_json
	end
	
	def getDateExpense
		expenseDate = Date.strptime(params[:expenseDate],"%m/%d/%Y")
		expenses =  current_user.daily_expense.where(:expenseDate => expenseDate)  #params[:expenseDate]
		arr = Array.new
		for ex in expenses
			arr << [ex.items, ex.amount, ex.id]
		end
		render :json => { 
		         :data => arr
		    }.to_json
	end
end
