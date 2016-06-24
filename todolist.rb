class TodoList
    # methods and stuff go here
    
    # Create a reader for the title and items	
    attr_reader :print_file
    attr_accessor :title
    # Initialize todo list with a title and empty items array
    def initialize(list_title, file)
    	@title = list_title
        @print_file = File.new(file, "w+")
    end   

    # Create a new Item and adds it to the array of items
    def create_item new_item
    	Item.add_list_item new_item
    end	

    #Delete an item from the list
    def delete_item position
        Item.delete_list_item position
    end  

    # Update item status
    def update_item_status position, value
        Item.update_status_at position, value
    end    

    # Method to print the items
    def list_items
       Item.format_list      
    end  


    # Method to print headding in ascii art
    def print_list_headding txt
        head = Artii::Base.new :font => 'slant'
        puts " ---------------------------------------------------------- "
        puts head.asciify txt
        puts " ---------------------------------------------------------  "
        puts "  "
    end

    # Method to print the list title
    def print_title
        print_list_headding @title
    end
end

# User class
class User
    attr_reader :todolist, :name
    # Initialize and interactive user
    def initialize name, list_title, file
        @name = name
        @todolist = TodoList.new list_title, file
    end     
end

# Item class
class Item
    # The items arrary
    @@list_items = []
    # methods and stuff go here
    attr_reader :description
    attr_writer :completion_status
    # Initialize items on a todo list
    def initialize item_description
    	@description = item_description
    	@completion_status = false
    end	

    # Add an item to the list array
    def self.add_list_item description
        new_item = Item.new description
        @@list_items.push new_item
    end

    # Delete a list item form the list array
    def self.delete_list_item position
        @@list_items.delete_at position
        puts "\n\nList item deleted at position - #{position.to_i + 1}\n\n"
    end  

    # Update status at position
    def self.update_status_at position, value
        @@list_items.at(position).completion_status = value
        puts "\n\n Status updated! \n\n"
    end      

    # Return the completion status of the item    
    def completed?
        @completion_status
    end 

    # A list of the items
    def self.list_of_items
        @@list_items
    end    
    
    # Format the list of items
    def self.format_list
        count = 0
        @@list_items.each do |block_variable|
            item_desc = block_variable.description + "                "
            status = block_variable.completed?
            count += 1
        puts "#{count} - #{item_desc[0..20]}Completed: #{status}"
        end     
    end    
end

# Class for user interaction
class UserInteraction

    attr_reader :new_user
    class Config
        @@actions = ['title', 'add', 'delete', 'update', 'print', 'quit']

        def self.actions
            @@actions
        end
    end

    # create user
    def create_user
        print "Type a user name: "
        name = gets.chomp
        print "Type a list title: "
        title = gets.chomp
        print "Type the file name with the .txt extension: "
        file = gets.chomp
        User.new name, title, file
    end 
    # Method to initialize the user object

    def initialize
        # Start the user interaction
        puts "  "
        puts ".................Initializing interactive interface! ............." 
        @new_user = create_user   
    end

    # Add item to the list
    def add list_object
        puts "\nAdd a new list item:  \n\n"
        list_item = gets.chomp.strip
        list_object.create_item list_item
        puts "\nlist item added!! \n\n"
    end 

    # Delete an item from the list
    def deleting_item list_object
        print "Type the number of the list item to delete: "
        position = gets.chomp.strip
        unless position == 1
            list_object.delete_item(position.to_i - 1) 
            #items.delete_at
        else
            list_object.delete_item(0)     
        end    
    end    

    # Update the completion status
    def status_update list_object
        print "Type list item position: "
        position = gets.chomp.strip
        print "Type list item status: "
        status = gets.chomp.strip
        unless position == 1
            list_object.update_item_status position.to_i - 1, status
        else 
            list_object.update_item_status 0, status  
        end  
    end    


    # Update the title of the list
    def change_title list_object
        print "Type the new title: "
        new_title = gets.chomp.strip
        list_object.title = new_title
        puts "\nTitle updated!! \n\n"
    end

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
        list_object.print_title
        list_object.list_items   
        # Close file
        report_file.close
        # Reset stdout
        $stdout = old_out
    end

    # Method to get the action from user
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
    # Method to do the selected action
    def do_action(action, list_object)
        # do some action with the key word
        case action
        when 'title'
            change_title list_object
        when 'add'
            add list_object
        when 'print'
            #print_list list_object.title, list_object.items
            list_object.print_title
            list_object.list_items   
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
    # Method to launch the user interaction    
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
    # Method to print intorductory instructions
    def introduction
        puts "\n\n<<<< Welcome to the Todo List program >>>>\n\n"
        puts "\n\n<<<<<<<This is an interactive guide to help you manage your todo list.>>>>>>>>\n\n"
        puts "\n\n<<<< add: This adds a new item to the list>>>>\n\n"
        puts "\n\n<<<< delete: This deletes an item from the list>>>>\n\n"
        puts "\n\n<<<< update: This updates the completion status of an item on the list>>>>\n\n"
        puts "\n\n<<<< title: This changes the title of the list>>>>\n\n"
        puts "\n\n<<<< print: This prints the list to the command line.>>>>\n\n"
        puts "\n\n<<<< quit: This quits the interactive menu and writes the list to a file>>>>\n\n"
        puts "Hit any key followed by enter to proceed...........\n\n"
    end
    
    def conclusion  
        puts "\n<<<< Goodbye! >>>>\n\n\n"
    end 
end    
