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

      if valid_move?(input)
        make_move(input)
        break if game_over?

        switch_turn
      else
        puts '無効な入力です。もう一度入力してください。'
      end
    end

    puts "ゲーム終了！ #{winner}の勝利です！" if game_over?
  end

  private

  def display_board
    BoardView.display(@board)
    puts "#{@current_turn == :sente ? '先手' : '後手'}: 入力してください"
  end

  def prompt_move
    # ユーザーからの入力を受け取る
  end

  def valid_move?(input)
    # 入力された移動が有効かチェックする
  end

  def make_move(input)
    # ボードを更新する
  end

  def game_over?
    # 勝敗の判定を行う
  end

  def switch_turn
    @current_turn = @current_turn == :sente ? :gote : :sente
  end

  def winner
    # 勝者を決定する
  end
end
