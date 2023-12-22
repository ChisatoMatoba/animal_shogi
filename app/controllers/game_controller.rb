# ゲームの進行管理
class GameController
  def initialize
    @board = Board.new
    @current_turn = :sente # 先手から開始
  end

  def play
    loop do
      display_board
      input = prompt_move
      break if input == 'quit'

      # ルールに合った入力であれば移動する
      if valid_move?(input)
        make_move(input)
        # 勝敗が決まれば終わり
        break if game_over?

        # 先手と後手を交代
        switch_turn
      else
        puts '無効な入力です。もう一度入力してください。(やめるときはquit)'
      end
    end

    puts "ゲーム終了！ #{winner}の勝利です！" if game_over?
  end

  private

  # ターンの前にボードの現状とアナウンス
  def display_board
    BoardView.display(@board)
    puts "#{@current_turn == :sente ? '先手' : '後手'}: 入力してください（例: A4G,A3G）"
  end

  # ユーザーからの入力を受け取る
  def prompt_move
    gets.chomp
  end

  # 入力された移動が有効かチェックする（全部OKのときだけtrueを返す）
  def valid_move?(input)
    from, to = parse_input(input) # 入力を座標に変換
    return false unless from && to && valid_format?(from, to)

    from_index = @board.position_to_index(from) # 座標をインデックスに変換
    piece = @board.piece_at(from_index) # インデックス化された座標を使用
    return false unless piece && piece.owner == @current_turn
    return false unless @board.can_move?(from, to, piece)

    true
  end

  # 駒を動かしてボードを更新する
  def make_move(input)
    from, to = parse_input(input)
    from_row, from_col = @board.position_to_index(from)
    to_row, to_col = @board.position_to_index(to)
    piece = @board.piece_at([from_row, from_col]) # fromの駒を取得
    @board.clear_piece(from_row, from_col) # 元の位置の駒をクリア
    @board.place_piece(to_row, to_col, piece) # 新しい位置に駒を配置
  end

  # 勝敗の判定を行う
  def game_over?
    @board.checkmate?(:sente) || @board.checkmate?(:gote)
  end

  # 先手と後手を交代
  def switch_turn
    @current_turn = @current_turn == :sente ? :gote : :sente
  end

  # 勝者を決定する
  def winner
    return '後手' if @board.checkmate?(:sente)

    '先手' if @board.checkmate?(:gote)
  end

  # 入力が正規表現に合っていれば座標に変換
  def parse_input(input)
    # [アルファベット][数値][駒], [アルファベット][数値][駒]になっているか
    match = input.match(/([A-C][1-4][a-zA-Z]),([A-C][1-4][a-zA-Z])/)
    [match[1], match[2]] if match
  end

  # 入力のフォーマットが正しいかチェック
  def valid_format?(from, to)
    /^[A-C][1-4][a-zA-Z]$/ =~ from && /^[A-C][1-4][a-zA-Z]$/ =~ to
  end
end
