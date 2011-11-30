class AssigneesController < ApplicationController

	def show
		begin
			@Title = "Assignee Overview"
			@assignee = Assignee.find params[:id] 
		rescue
			redirect_to :root
		end

	end

	def index
		@Title = "Assignees List"
		@assignees = Assignee.all

		@assignee = Assignee.new
		3.times{
			@assignee.tasks.build
		}
	end

	def create
		@Title = "New Assignee"
		Assignee.create params[:assignee]
		flash[:notice] = "Assignee has been created"
		redirect_to :back
	end

	def edit
		begin
			@Title = "Edit Assignee"
			@assignee = Assignee.find params[:id] #find the Assignee currently being looked for
		rescue
			redirect_to :root
		end
	end

	def update
		assignee = Assignee.find params[:id] #find the Assignee currently being looked for

		if assignee.update_attributes params[:assignee]
				#Find all the contacts with their delete flag hit, and delete them
			# params[:contacts_attributes].each{
			# 	|x|
			# 	if(x.delete == 1)
			# 		assignee.delete(x)
			# 	end
			# }
			# the update was successful, redirect to the main page and inform the user
			flash[:notice] = "Assignee has been updated"
			redirect_to assignees_path
		else
			# the update was not successful, rediret back to the editing page
			flash[:error] = "There was an error updating the Assignee"
			redirect_to :back 
		end
	end

	def destroy
		Assignee.destroy params[:id]
		
		flash[:error] = "Assignee has been deleted"
		redirect_to :back
	end

	def search
		@Title = "Search"
		@assignees = Assignee.search(params[:search])
	end
end
