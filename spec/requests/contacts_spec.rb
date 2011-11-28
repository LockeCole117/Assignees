require 'spec_helper'

describe "Contacts" do
 	before do
		#Since the Task model has a many to one relationship with the Assignee model, we need to create an Assignee model 
			# To establish the relationship.
		@assignee = Assignee.new #Create a New Assignee
		@assignee.assignee = "Test Assignee Tasks"
		@assignee.description = "A Very Simple Description for Assignee Tasks"
		@assignee.save()

		@contact = Contact.new #Create a new contact for the assignee
		@contact.name = "John Smith"
		@contact.email = "jsmith@google.com"
		@contact.phone = "0118 999 881 999 119 7253"
		@contact.save()
	end

  describe "GET /contacts" do
    it "displays some Contacts" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit assignees_path
      page.should have_content "John Smith"
      #save_and_open_page
    end

    it "searches for an Assignee based on a Contact Name" do
    	visit assignees_search_path

    	fill_in 'search', :with => 'John Smith'

    	click_button 'Search Assignee'

    	current_path.should == assignees_search_path
    
    	# Look for:
    		# The Description.
    		# the other Tags
    		# The Title

    	# save_and_open_page

    	page.should have_content 'Test Assignee'
    	page.should have_content 'A Very Simple Description' 
    	page.should have_content 'Sample Task'
    end

    it "searches for an Assignee based on a Contact Phone Number" do
    	visit assignees_search_path

    	fill_in 'search', :with => '0118 999 881 999 119 7253'

    	click_button 'Search Assignee'

    	current_path.should == assignees_search_path
    
    	# Look for:
    		# The Description.
    		# the other Tags
    		# The Title

    	# save_and_open_page

    	page.should have_content 'Test Assignee'
    	page.should have_content 'A Very Simple Description' 
    	page.should have_content 'Sample Task'
    end

    it "searches for an Assignee based on a Contact Email" do
    	visit assignees_search_path

    	fill_in 'search', :with => 'jsmith@google.com'

    	click_button 'Search Assignee'

    	current_path.should == assignees_search_path
    
    	# Look for:
    		# The Description.
    		# the other Tags
    		# The Title

    	# save_and_open_page

    	page.should have_content 'Test Assignee'
    	page.should have_content 'A Very Simple Description' 
    	page.should have_content 'Sample Task'
    end


  end

  describe "PUT /contacts" do
	it "edits an assignee's contact name" do
		visit assignees_path
		click_link 'Edit'

		current_path.should == edit_assignee_path(@assignee)

		find_field('assignee[contacts_attributes][0][name]').value.should have_content 'John Smith'

		fill_in 'assignee[contacts_attributes][0][name]', :with => 'John Doe'

		click_button 'Update Assignee'

		current_path.should == assignees_path

		page.should have_content 'Assignee has been updated'
	end

	it "edits an assignee's contact name (but fails b/c its blank)" do
		visit assignees_path
		click_link 'Edit'

		current_path.should == edit_assignee_path(@assignee)

		find_field('assignee[contacts_attributes][0][name]').value.should have_content 'John Smith'

		fill_in 'assignee[contacts_attributes][0][name]', :with => ''

		click_button 'Update Assignee'

		current_path.should == assignees_path

		page.should_not have_content 'Assignee has been updated'
	end

	it "edits an assignee's contact email" do
		visit assignees_path
		click_link 'Edit'

		current_path.should == edit_assignee_path(@assignee)

		find_field('assignee[contacts_attributes][0][email]').value.should have_content 'jsmith@google.com'

		fill_in 'assignee[contacts_attributes][0][email]', :with => 'jdoe@gmail.com'

		click_button 'Update Assignee'

		current_path.should == assignees_path

		page.should have_content 'Assignee has been updated'
	end

	it "edits an assignee's contact email (but fails because it is not a valid email)" do
		visit assignees_path
		click_link 'Edit'

		current_path.should == edit_assignee_path(@assignee)

		find_field('assignee[contacts_attributes][0][email]').value.should have_content 'jsmith@google.com'

		fill_in 'assignee[contacts_attributes][0][email]', :with => 'jdoe@gmailcom'

		click_button 'Update Assignee'

		current_path.should == assignees_path

		page.should have_content 'Assignee has been updated'
	end

	it "edits an assignee's contact phone number" do
		visit assignees_path
		click_link 'Edit'

		current_path.should == edit_assignee_path(@assignee)

		find_field('assignee[contacts_attributes][0][phone]').value.should have_content '0118 999 881 999 119 7253'

		fill_in 'assignee[contacts_attributes][0][phone]', :with => '555-555-5555'

		click_button 'Update Assignee'

		current_path.should == assignees_path

		page.should have_content 'Assignee has been updated'
	end

  end

  describe "DELETE /tasks" do

 #  	it "should delete a Task" do
	# 	visit assignees_path
	# 	find("#assignee_#{@assignee.id}").click_link 'Delete'
	# 	page.should have_content 'Assignee has been deleted'
	# 	page.should have_no_content 'Test Assignee'
	# end

  end
end
