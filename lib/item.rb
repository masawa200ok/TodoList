class Item
 
  attr_accessor :index, :level, :title, :text

  def initialize(index, level, title, text)
    @index = index
    @level = level
    @title = title
    @text = text
  end

  def to_db
    "#{@level}|#{@title}|#{@text}"
  end

  def to_list
    "No: #{@index}, 優先度: #{@level}, タイトル: #{@title}, 内容: #{@text}"
  end
end
