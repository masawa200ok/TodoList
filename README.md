# TodoList

## Todo管理ツール

Todo管理ツールです。

### syntax

ruby todo.rb &lt;command&gt; &lt;option&gt;

### command

- list     - Todoリストを表示する
- add      - Todoリストに追加する
- complete - Todoリストから削除する

### option

- listコマンドには以下のオプションがあります。

  - -fタイトルと内容でフィルターしたい文字列
  - -lフィルターしたい優先度（1 or 2 or 3）

- completeコマンドにはlistで確認したNoをオプションとして指定します。
  
  `ruby todo.rb complete 2`
  
  複数指定することができます。
  
  `ruby todo.rb complete 2 3`
