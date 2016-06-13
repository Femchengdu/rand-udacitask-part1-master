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

# Method to format the items output
def format_items items_array
	count = 0
	items_array.each do |block_variable|
		description = block_variable.description + "            "
		status = block_variable.completion_status
		count += 1
		puts "#{count} - #{description[0..20]}Completed: #{status}"
	end
end	

# Method to print the list

def print_list title, item_list
	print_list_headding title
    format_items item_list
end


# Creates a new todo list
julias_stuff = TodoList.new("Julia's Stuff")

# Add four new items
julias_stuff.add_item("Do laundry")
julias_stuff.add_item("Feed the cat")
julias_stuff.add_item("Buy cereal")
julias_stuff.add_item("Go dancing!")

# Print the list
print_list julias_stuff.title, julias_stuff.items

# Delete the first item
julias_stuff.items.delete_at(0)

# Print the list
print_list julias_stuff.title, julias_stuff.items

# Delete the second item
julias_stuff.items.delete_at(1)

# Print the list
print_list julias_stuff.title, julias_stuff.items

# Update the completion status of the first item to complete
julias_stuff.items[0].completion_status = true

# Print the list
print_list julias_stuff.title, julias_stuff.items

# Update the title of the list
julias_stuff.title = "My Todo List"

# Print the list
print_list julias_stuff.title, julias_stuff.items


# Start user interaction

user_interaction = UserInteraction.new
user_interaction.launch_user_interaction!(julias_stuff)

