class Item
 
  attr_reader :level, :title, :text

  def initialize(level, title, text)
    @level = level
    @title = title
    @text = text
  end

  def to_db
    "#{@level}|#{@title}|#{@text}"
  end

  def to_list
    "優先度: #{@level}, タイトル: #{@title}, 内容: #{@text}"
  end
end
