# お題
[どうぶつ将棋を作ろう STEP1](https://github.com/luxiar/enjoy_ruby/wiki/%E3%81%A9%E3%81%86%E3%81%B6%E3%81%A4%E3%81%97%E3%82%87%E3%81%86%E3%81%8E%E3%82%92%E4%BD%9C%E3%82%8D%E3%81%86-STEP1)

# ゲーム開始方法
ターミナルのanimal_shogiディレクトリで以下を入力
```
bin/play
```

### 進め方 
1. 先手、後手の順番で入力を促す
    * 例) 先手: 入力してください 
1. 駒を移動先を入力してもらう
    * From,Toのようにカンマ区切りで入力を行う
    * From, Toはそれぞれ[アルファベット][数値][駒]のような形式で入力を行う
        * 例) A4G,A3G
    * 駒台からの場合はFromの入力を行わない　【未実装】
        * 例) A3G
    * 移動先でひよこがニワトリに成った場合はToはpで表現　【未実装】
    * 以下のケースはエラーメッセージを出力後、再度入力を促す
        * 入力フォーマットミス
        * 置けない箇所を指定している
        * 手持ちに駒が存在しない　【未実装】
1. ライオンが取られた場合は勝敗を表示して終了する
1. 終了しない場合は手番を交代してループ

* 相手の駒を取得した場合は自分の手番の表記で表示する(後手が先手の駒をとったらC->cで表示)　【未実装】

例)

```
後手: c
   | A | B | C |
 1 | e | l | g |
 2 |   |   |   |
 3 |　 | c |   |
 4 | G | L | E | 
後手:
```


# 設計の記録（Chat-GPTさん作）
## 構成
![image](https://github.com/ChisatoMatoba/animal_shogi/assets/149556430/b557597c-0cb3-4833-8810-7cb16170c873)


## 概要
### Boardモデル (board.rb):
盤面を表す@gridという2次元配列を持っています。

初期化時に駒を配置するsetup_piecesメソッドがあります。

ライオンが取られたかどうかをチェックするcheckmate?メソッドがあります。

### Pieceモデル (piece.rb):
駒の種類(type)、所有者(owner)、現在位置(current_position)を持っています。

駒の移動ルールを定義するmovesメソッドがあります。

### GameController (game_controller.rb):
ゲームの進行を管理します。

ユーザーからの入力を受け取り、有効な移動かどうかをチェックするvalid_move?メソッドがあります。

勝敗の判定を行うgame_over?メソッドがあります。

### BoardView (board_view.rb):
盤面のレイアウトを表示するdisplayメソッドがあります。

## フローチャート
![board-zany-wisecracker (1)](https://github.com/ChisatoMatoba/animal_shogi/assets/149556430/74c4fa7c-26d3-45cd-8167-03d5fb7d00e5)


