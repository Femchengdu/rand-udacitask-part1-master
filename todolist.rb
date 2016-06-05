class TodoList
    # methods and stuff go here
    
    # Create a reader for the title and items	
    attr_reader :title, :items
    attr_writer :title
    # Initialize todo list with a title and no items
    def initialize(list_title)
    	@title = list_title
    	@items = Array.new
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
