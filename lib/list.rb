require './lib/item'
require './lib/command'

class List < Command
  
  def execute(argv)
    unless item_array = get_item_list
      return
    end

    item_array = filter_by_keyword(argv, item_array)
    item_array = filter_by_level(argv, item_array)

    item_array.each_with_index do |item, idx|
      puts item.to_list
    end
  end

  def get_item_list
    item_array = []

    unless File.exists?(DB)
      return nil
    end

    File.open(DB, "r") do |f|
      f.each_line do |line|
        array = line.split("|")
        item = Item.new(0, array[0], array[1], array[2])
        item_array.push(item)
      end
    end

    item_array.sort! do |a, b|
      a.to_db <=> b.to_db
    end

    item_array.each_with_index do |item, index|
      item.index = index + 1
    end

    item_array
  end

  def filter_by_keyword(argv, item_array)
    keyword = ""
    argv.each do |v|
      if m = /^-f(.+?)$/.match(v)
        keyword = m[1]
        break
      end
    end
    if keyword == ""
      return item_array
    end

    return_array = []
    item_array.each do |item|
      if /#{keyword}/ =~ item.title
        return_array.push(item)
      elsif /#{keyword}/ =~ item.text
        return_array.push(item)
      end
    end
    return_array
  end

  def filter_by_level(argv, item_array)
    level = ""
    argv.each do |v|
      if m = /^-l(\d+?)$/.match(v)
        level = m[1]
        break
      end
    end
    if level == ""
      return item_array
    end

    return_array = []
    item_array.each do |item|
      if level.to_i == item.index
        return_array.push(item)
      end
    end
    return_array
  end
end
