require_relative 'item'
require 'byebug'
class List
    attr_accessor :label
    attr_reader :items

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = nil)
        description ||= ''
        item = Item.new(title, deadline, description)
        if item
            @items << item
            return true
        else
            return false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index >= 0 && index < @items.length
    end

    def swap(index_1, index_2)
        if valid_index?(index_1) && valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            raise 'invalid index'
            return false
        end
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items.first
    end

    def print
        lines = '-'*60
        puts lines
        puts @label.center(60)
        puts lines
        puts 'Index'.ljust(7) + '|'.ljust(3) + 'Item'.ljust(20) + '|'.ljust(3) + 'Deadline'.ljust(15) + '|'.ljust(3) + 'Done'
        puts lines
        @items.each_with_index do |item, i|
            puts "#{i}".ljust(7) + '|'.ljust(3) + "#{item.title}".ljust(20) + '|'.ljust(3) + "#{item.deadline}".ljust(15) + '|'.ljust(3) + "[#{item.done}]"
        end
        puts lines
    end

    def print_full_item(index)
        lines = '-'*60
        puts lines
        puts "#{@items[index].title}".ljust(33) + "#{@items[index].deadline}".ljust(18) + "[#{@items[index].done}]"
        puts "#{@items[index].description}"
        puts lines
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount = nil)
        (amount.nil? || amount == 0) ? amount = 1 : amount = amount
        i = index
        return false if !valid_index?(i)
        amount.times do
            swap(i, i-1)
            i -= 1
            break if i == 0
        end
        true
    end

    def down(index, amount = nil)
        (amount.nil? || amount == 0) ? amount = 1 : amount = amount
        i = index
        last_idx = @items.index(@items.last)
        return false if !valid_index?(i)
        amount.times do
            swap(i, i+1)
            i += 1
            break if i == last_idx
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        if valid_index?(index)
            @items.delete(@items[index])
            return true
        else
            return false
        end
    end

    def purge
        to_purge = []
        @items.each do |item|
            to_purge << item if item.done == true
        end
        to_purge.each { |item| remove_item(@items.index(item)) }
    end
end