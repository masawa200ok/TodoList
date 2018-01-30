require './lib/command'
require './lib/item'

# Todoリストに項目追加クラス
class Add < Command
  
  def execute

    print "優先度(1 or 2 or 3): "
    level = STDIN.gets.chomp
    unless validate_level(level)
      return
    end

    print "タイトル: "
    title = STDIN.gets.chomp

    print "内容: "
    text = STDIN.gets.chomp

    item = Item.new(0, level, title, text)

    # Todoアイテムをファイルへ追加
    File.open(DB, "a") do |f|
      f.puts(item.to_db)
    end
  end

  private

  # 優先順位は１か２か３であることをチェック
  def validate_level(level)
    if /[123]/ =~ level
      true
    else
      puts "[ERROR]優先度は1か２か３を指定してください。"
      false
    end
  end

end

