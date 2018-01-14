require './lib/command'
require './lib/list'
require './lib/item'

class Complete < Command
  
  def execute
    
    print "Noを入力してください:"
    temp_index = gets.chomp
    unless validate_index(temp_index)
      return
    end
    index = temp_index.to_i
    index -= 1
    
    item_array = List.new.get_item_list

    if index < 0 || index > item_array.length - 1
      puts "Noが有効な範囲の値ではありません"
    else
      item_array.delete_at(index)
    end

    File.delete(DB)
    File.open(DB, "a") do |f|
      item_array.each do |item|
        f.puts(item.to_db)
      end
    end

  end

  def validate_index(index)
    if /\d+/ =~ index
      true
    else
      puts "[ERROR]数値を入力してください"
      false
    end
  end

end
