# frozen_string_literal: true

# 駒モデル
class Piece
  attr_reader :type, :owner

  def initialize(type, owner, current_position)
    @type = type
    @owner = owner
    @current_position = current_position
  end

  # 移動ルール
  def moves
    case type
    when 'L', 'l' # ライオン
      lion_moves
    when 'E', 'e' # ゾウ
      elephant_moves
    when 'G', 'g' # キリン
      giraffe_moves
    when 'C', 'c', 'P', 'p' # ひよこ/にわとり
      chick_moves
    end
  end

  # オブジェクトが文字列として必要なときにto_sする
  def to_s = type

  # 駒の現在位置を更新する
  def update_position(new_position)
    @current_position = new_position
  end

  private

  # ライオンの動き
  def lion_moves
    row, col = @current_position
    moves = []
    (-1..1).each do |row_offset|
      (-1..1).each do |col_offset|
        next if row_offset.zero? && col_offset.zero?

        moves << [row + row_offset, col + col_offset]
      end
    end
    moves
  end

  # ゾウの動きを定義
  def elephant_moves
    row, col = @current_position
    [[-1, -1], [-1, 1], [1, -1], [1, 1]].map do |row_offset, col_offset|
      [row + row_offset, col + col_offset]
    end
  end

  # キリンの動きを定義
  def giraffe_moves
    row, col = @current_position
    [[-1, 0], [1, 0], [0, -1], [0, 1]].map do |row_offset, col_offset|
      [row + row_offset, col + col_offset]
    end
  end

  # ひよこの動きを定義
  def chick_moves
    row, col = @current_position
    row_offset = @owner == :sente ? -1 : 1
    [[row + row_offset, col]]
  end
end
