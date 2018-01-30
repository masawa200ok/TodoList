require './lib/command'
require './lib/list'
require './lib/item'

# Todoアイテムを完了するクラス
class Complete < Command
  
  def execute(argv)
    
    # 削除するNoがただし以下チェックする
    argv.each do |index|
      unless validate_index(index)
        puts "[ERROR]数値を入力してください"
        return
      end
    end
 
    # Todoアイテムのリストを取得
    item_array = List.new.get_item_list

    # コマンドラインパラメータのループ（完了するアイテムのNo）
    argv.each do |v|
      index = v.to_i - 1
      if index < 0 || index > item_array.length - 1
        puts "[ERROR]Noが有効な範囲の値ではありません"
        return
      else
        item_array[index] = nil
      end
    end

    # DBファイル削除
    File.delete(DB)

    # DBファイル作成、Todoアイテムを書き込む
    File.open(DB, "a") do |f|
      item_array.each do |item|
        unless item.nil?
          f.puts(item.to_db)
        end
      end
    end

  end

  # 削除するNoがただし以下チェックする
  def validate_index(index)
    if /\d+/ =~ index
      true
    else
      false
    end
  end

end
