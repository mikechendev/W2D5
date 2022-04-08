require_relative 'list'
require 'byebug'
class TodoBoard

    def initialize
        @lists = {}
    end

    def get_command
        puts 'enter command'
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            @lists[args[0]] = List.new(args[0])
        when 'ls'
            @lists.each { |k,v| puts k }
        when 'showall'
            @lists.each { |k,v| v.print }
        when 'mktodo'
            @lists[args[0]].add_item(*args[1..-1])
        when 'toggle'
            @lists[args[0]].toggle_item(args[1].to_i)
        when 'rm'
            @lists[args[0]].remove_item(args[1].to_i)
        when 'purge'
            @lists[args[0]].purge
        when 'up'
            @lists[args[0]].up(args[1].to_i, args[2].to_i)
        when 'down'
            @lists[args[0]].down(args[1].to_i, args[2].to_i)
        when 'swap'
            @lists[args[0]].swap(args[1].to_i, args[2].to_i)
        when 'sort'
            @lists[args[0]].sort_by_date!
        when 'priority'
            @lists[args[0]].print_priority
        when 'print'
            case args.length
            when 1
                @lists[args[0]].print
            when 2
                @lists[args[0]].print_full_item(args[1].to_i)
            end
        when 'quit'
            return false
        else
            puts 'Sorry, that command is not recognized'
        end
        true
    end

    def run
        until get_command == false
            get_command
        end
    end
end