require './lib/item'
require './lib/add'
require './lib/list'
require './lib/complete'

class Todo

  # Todoリストメインルーチン
  def run(argv)

    # コマンド
    command = argv.shift
    case command
    when 'add'
      Add.new.execute
    when 'complete'
      Complete.new.execute(argv)
    when 'list'
      List.new.execute(argv)
    else
      # 正しいコマンドが渡されていないのでコマンドの詳細表示
      syntax
    end

  end

  # コマンドの詳細表示
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
          -p 優先度でフィルタリングする

        complete
          完了するNoを指定する
    TEXT
    puts text
  end
end

# Todoリスト起動
Todo.new.run(ARGV)

