require './lib/command'
require './lib/item'

class Add < Command
  
  def execute

    print "優先度(1 or 2 or 3): "
    level = gets.chomp
    unless validate_level(level)
      return
    end

    print "タイトル: "
    title = gets.chomp

    print "内容: "
    text = gets.chomp

    item = Item.new(level, title, text)

    File.open(DB, "a") do |f|
      f.puts(item.to_db)
    end
  end

  private

  def validate_level(level)
    if /[123]/ =~ level
      true
    else
      puts "[ERROR]優先度は1か２か３を指定してください。"
      false
    end
  end

end
