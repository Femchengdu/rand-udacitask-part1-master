class TodoList
    # methods and stuff go here
    
    # Create a reader for the title and items	
    attr_reader :print_file, :items
    attr_accessor :title
    # Initialize todo list with a title and empty items array
    def initialize(list_title, file)
    	@title = list_title
    	@items = Array.new
        @print_file = File.new(file, "w+")
    end   

    # Create a new Item and adds it to the array of items
    def add_item new_item
    	item = Item.new new_item
    	@items.push item
    end	
    # Method to write the list
    def list_items
        count = 0
        @items.each do |block_variable|
            count += 1   
            block_variable.format_output block_variable, count
        end    
    end    

    # Method to print headding in ascii art
    def print_list_headding txt
        head = Artii::Base.new :font => 'slant'
        puts " ---------------------------------------------------------- "
        puts head.asciify txt
        puts " ---------------------------------------------------------  "
        puts "  "
    end

    # Method to print the title
    def print_title
        print_list_headding @title
    end
end

# User class
class User
    attr_reader :todolist, :name

    def initialize name, list_title, file
        @name = name
        @todolist = TodoList.new list_title, file
    end     
end

# Item class
class Item
    # methods and stuff go here
    attr_reader :description
    attr_writer :completion_status
    # Initialize items on a todo list
    def initialize item_description
    	@description = item_description
    	@completion_status = false
    end	 
    # Method for the completion status
    def completed?
         @completion_status
    end 
    # Method for the description
    def print_description
        item_desc = @description + "            "
    end  
    # Method to format the list item
    def format_output block_variable, count
        puts "#{count} - #{block_variable.print_description[0..20]} completed: #{block_variable.completed?}"
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
