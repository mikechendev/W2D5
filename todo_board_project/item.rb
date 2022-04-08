class Item

    attr_accessor :title, :description
    attr_reader :deadline, :done

    def self.valid_date?(date_string)
        arr = date_string.split('-')
        arr[0].length == 4 && (1..12).to_a.include?(arr[1].to_i) && (1..31).to_a.include?(arr[2].to_i)
    end

    def initialize(title, deadline, description)
        @title = title
        if !Item.valid_date?(deadline)
            raise 'invalid date'
        else
            @deadline = deadline
        end
        @description = description
        @done = false
    end

    def deadline=(new_deadline)
        if !Item.valid_date?(new_deadline)
            raise 'invalid date'
        else
            @deadline = new_deadline
        end
    end

    def toggle
        @done == false ? @done = true : @done = false
    end

end
