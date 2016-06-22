require_relative 'todolist.rb'
require 'artii'





# Method to print headding in ascii art

def print_list_headding txt
	head = Artii::Base.new :font => 'slant'
	puts " ---------------------------------------------------------- "
	puts head.asciify txt
	puts " ---------------------------------------------------------  "
	puts "  "
end

def completed? block_variable
	block_variable.completion_status
end	

# Method to format the items output
def format_items items_array
	count = 0
	items_array.each do |block_variable|
		description = block_variable.description + "            "
		status = completed? block_variable
		count += 1
		puts "#{count} - #{description[0..20]}Completed: #{status}"
	end
end	

# Method to print the list

def print_list title, item_list
	print_list_headding title
    format_items item_list
end
=begin
# save user

def save_user user
	if User.add_user user
		puts "#{user.name} saved successfully!!"
	else
		puts "Problem saving #{user.name}"
	end		
end	
=end
# Old way
julia = User.new "Julia", "Julia's Stuff", "todolist.txt"

# Method to add a four new items
julia.todolist.add_item("Do laundry")
julia.todolist.add_item("Feed the cat")
julia.todolist.add_item("Buy cereal")
julia.todolist.add_item("Go dancing!")

# Print the list
print_list julia.todolist.title, julia.todolist.items

# Delete the first item
julia.todolist.items.delete_at(0)

# Print the list
print_list julia.todolist.title, julia.todolist.items

# Delete the second item
julia.todolist.items.delete_at(1)

# Print the list
print_list julia.todolist.title, julia.todolist.items

# Update the completion status of the first item to complete
julia.todolist.items[0].completion_status = true

# Print the list
print_list julia.todolist.title, julia.todolist.items

# Update the title of the list
julia.todolist.title = "My Todo List"

# Print the list
print_list julia.todolist.title, julia.todolist.items


# Initialize user interaction
user_interaction = UserInteraction.new
#launc the user interaciton
user_interaction.launch_user_interaction! user_interaction.new_user.todolist
