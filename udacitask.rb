require_relative 'todolist.rb'
require 'artii'

# Initialize todo list
julia = User.new "Julia", "Julia's Stuff", "todolist.txt"

# Method to add a four new items
julia.todolist.add_item("Do laundry")
julia.todolist.add_item("Feed the cat")
julia.todolist.add_item("Buy cereal")
julia.todolist.add_item("Go dancing!")

# Print the list
julia.todolist.print_title
julia.todolist.list_items

# Delete the first item
julia.todolist.items.delete_at(0)

# Print the list
julia.todolist.print_title
julia.todolist.list_items

# Delete the second item
julia.todolist.items.delete_at(1)

# Print the list
julia.todolist.print_title
julia.todolist.list_items

# Update the completion status of the first item to complete
julia.todolist.items[0].completion_status = true

# Print the list
julia.todolist.print_title
julia.todolist.list_items

# Update the title of the list
julia.todolist.title = "My Todo List"

# Print the list
julia.todolist.print_title
julia.todolist.list_items


# Initialize user interaction
user_interaction = UserInteraction.new
#launc the user interaciton
user_interaction.launch_user_interaction! user_interaction.new_user.todolist