require './lib/command'
require './lib/list'
require './lib/item'

class Complete < Command
  
  def execute(argv)
    
    argv.each do |index|
      unless validate_index(index)
        puts "[ERROR]数値を入力してください"
        return
      end
    end
    
    item_array = List.new.get_item_list

    argv.each do |v|
      index = v.to_i - 1
      if index < 0 || index > item_array.length - 1
        puts "[ERROR]Noが有効な範囲の値ではありません"
        return
      else
        item_array[index] = nil
      end
    end

    File.delete(DB)
    File.open(DB, "a") do |f|
      item_array.each do |item|
        unless item.nil?
          f.puts(item.to_db)
        end
      end
    end

  end

  def validate_index(index)
    if /\d+/ =~ index
      true
    else
      false
    end
  end

end
