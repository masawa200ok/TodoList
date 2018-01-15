require './lib/item'
require './lib/add'
require './lib/list'
require './lib/complete'

class Todo

  def run(argv)

    command = argv.shift
    case command
    when 'add'
      Add.new.execute
    when 'complete'
      Complete.new.execute(argv)
    when 'list'
      List.new.execute(argv)
    else
      syntax
    end

  end

  def syntax
    text = <<~TEXT
      <syntax>
        ruby todo.rb <command> <option>

      <command>
        list     - Todoリストを表示する 
        add      - Todoリストに追加する
        complete - Todoリストから完了する

      <option>
        list
          -f タイトル、内容で、指定した文字列でフィルタリングを行う
          -l 優先度でフィルタリングする

        complete
          完了するNoを指定する
    TEXT
    puts text
  end
end

Todo.new.run(ARGV)

