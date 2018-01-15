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
      Complete.new.execute
    when 'list'
      List.new.execute(argv)
    else
      syntax
    end

  end

  def syntax
    text = <<~TEXT
      <syntax>
        ruby todo.rb <command>

      <command>
        list     - Todoリストを表示する 
        add      - Todoリストに追加する
        complete - Todoリストから削除する
    TEXT
    puts text
  end
end

Todo.new.run(ARGV)

