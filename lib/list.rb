require './lib/item'
require './lib/command'

class List < Command
  
  def execute
    
    item_array = get_item_list

    item_array.each_with_index do |item, idx|
      idx += 1
      puts "No:#{idx} - #{item.to_list}"
    end

  end

  def get_item_list

    item_array = []

    File.open(DB, "r") do |f|
      f.each_line do |line|
        array = line.split("|")
        item = Item.new(array[0], array[1], array[2])
        item_array.push(item)
      end
    end

    item_array.sort! do |a, b|
      a.to_db <=> b.to_db
    end

    item_array
  end

end
