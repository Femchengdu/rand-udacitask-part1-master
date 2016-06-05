require_relative 'todolist.rb'

# Creates a new todo list
julias_stuff = TodoList.new("Julia's stuff")

# Add four new items
julias_stuff.add_item("Do laundry")
julias_stuff.add_item("Feed the cat")
julias_stuff.add_item("Buy cereal")
julias_stuff.add_item("Go dancing!")

# Print the list
puts julias_stuff.items.inspect
puts julias_stuff.items.length
puts julias_stuff.items[0]

# Delete the first item
julias_stuff.items.delete_at(0)
# Print the list
puts julias_stuff.items.inspect
# Delete the second item
puts julias_stuff.items.length

# Print the list
puts julias_stuff.items.inspect

# Update the completion status of the first item to complete

julias_stuff.items[0].completion_status = true


# Print the list
puts julias_stuff.items.inspect

# Update the title of the list
julias_stuff.title = "Julia's Monday morning list"

# Print the list
puts julias_stuff.items.inspect
