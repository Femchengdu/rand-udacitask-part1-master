class TodoList
    # methods and stuff go here
    
    # Create a reader for the title and items	
    attr_reader :title, :items, :print_file
    attr_writer :title
    # Initialize todo list with a title and no items
    def initialize(list_title)
    	@title = list_title
    	@items = Array.new
        @print_file = File.new("todolist.txt", "w+")
    end   

    # Create a new Item and adds it to the array of items
    def add_item(new_item)
    	item = Item.new(new_item)
    	@items.push(item)
    end	
end

class Item
    # methods and stuff go here
    attr_reader :description, :completion_status
    attr_writer :completion_status
    # Initialize items on a todo list
    def initialize(item_description)
    	@description = item_description
    	@completion_status = false
    end	   
end


class UserInteraction

    class Config
        @@actions = ['title', 'add', 'delete', 'update', 'print', 'quit']

        def self.actions
            @@actions
        end
    end

    def initialize
        # Start the user interaction
        puts "  "
        puts ".................Initializing interactive interface! ............."   
        puts "  " 
    end

    # Add item to the list

    def add list_object
        puts "\nAdd a new list item:  \n\n"
        list_item = gets.chomp.strip
        list_object.add_item list_item
        puts "\nlist item added!! \n\n"
    end 

    # Delete an item from the list
    def deleting_item list_object
        print "Type the number of the list item to delete: "
        position = gets.chomp.strip
        unless position == 1
            list_object.items.delete_at(position.to_i - 1) 
        else
            list_object.items.delete_at(0)     
        end    
    end    

    # Update the completion status
    def status_update list_object
        print "Type list item position: "
        position = gets.chomp.strip
        print "Type list item status: "
        status = gets.chomp.strip
        unless position == 1
            list_object.items[position.to_i - 1].completion_status = status
        else 
            list_object.items[0].completion_status = status  
        end  
        puts "\nStatus updated!! \n\n"   
    end    


    # Update the title of the list
    def change_title list_object
        print "Type the new title: "
        new_title = gets.chomp.strip
        list_object.title = new_title
        puts "\nTitle updated!! \n\n"
    end

    # Formating output to the screen

    # List headding

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
            description = block_variable.description + "                        "
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
=begin
    # Update the title of the list
    def set_list_file list_object
        print "Type the name of the file to write to: "
        list_file = gets.chomp.strip
        list_object.print_file = new_title
    end
=end

    # Method to write the list to a file
    def list_to_file list_object
        puts "Writing todo list to file........."
        # Initialize text file
        report_file = list_object.print_file
        # Save old value of stdout  
        old_out = $stdout
        # Set stdout to textfile
        $stdout = report_file
        # Print the todo list
        print_list list_object.title, list_object.items
        # Close file
        report_file.close
        # Reset stdout
        $stdout = old_out
    end


    def get_action
        action = nil
        # Ask for user input until we get a valid response
        until Config.actions.include?(action)
            puts "Actions: " + Config.actions.join(", ") if action
            print "> "
            user_response = gets.chomp
            action = user_response.downcase.strip
        end

        return action
    end   

    def do_action(action, list_object)
        # do some action with the key word
        case action
        when 'title'
            change_title list_object
        when 'add'
            add list_object
        when 'print'
            print_list list_object.title, list_object.items   
        when 'delete'
            deleting_item list_object
        when 'update'
            status_update list_object    
        when 'quit'
            list_to_file list_object
            puts "Todo list written to file!" 
            return :quit    
        else
            puts "\n Wrong command.\n"
        end 
    end 
    
    def launch_user_interaction! list_object
        # Introduction to the todo lists
        introduction
        # action loop
        result = nil
        until result == :quit
            #   do the action
            action = get_action
            result = do_action(action, list_object)
        end
        # Conclusion
        conclusion
    end

    def introduction
        puts "\n\n<<<< Welcome to the Todo List program >>>>\n\n"
        puts "\n\n<<<<<<<This is an interactive guide to help you manage your todo list.>>>>>>>>\n\n"
        puts "\n\n<<<< add: This adds a new item to the list>>>>\n\n"
        puts "\n\n<<<< delete: This deletes an item from the list>>>>\n\n"
        puts "\n\n<<<< update: This updates the completion status of an item on the list>>>>\n\n"
        puts "\n\n<<<< title: This changes the title of the list>>>>\n\n"
        puts "\n\n<<<< quit: This quits the interactive menu and writes the list to a file>>>>\n\n"
        puts "Hit any key followed by enter to proceed...........\n\n"
    end
    
    def conclusion  
        puts "\n<<<< Goodbye! >>>>\n\n\n"
    end 

end    
