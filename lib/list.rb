require './lib/item'
require './lib/command'

# Todoアイテムの一覧を表示するクラス
class List < Command
  
  def execute(argv)
    # Todoアイテムを取得
    unless item_array = get_item_list
      return
    end

    # コマンドオプション：キーワードによるフィルタ
    item_array = filter_by_keyword(argv, item_array)
    
    # コマンドオプション：優先度によるフィルタ
    item_array = filter_by_priority(argv, item_array)

    # 標準出力に表示
    item_array.each_with_index do |item, idx|
      puts item.to_list
    end
  end

  # TodoアイテムをDBファイルから取得
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

     # 優先順位等でソート
    item_array.sort! do |a, b|
      a.to_db <=> b.to_db
    end

    # TodoアイテムにNoを振る
    item_array.each_with_index do |item, index|
      item.index = index + 1
    end

    # Todoアイテムのリストを返す
    item_array
  end

  # コマンドオプション：キーワードによるフィルタ
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

  # コマンドオプション：優先度によるフィルタ
  def filter_by_priority(argv, item_array)
    level = ""
    argv.each do |v|
      if m = /^-p(\d+?)$/.match(v)
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
