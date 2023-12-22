# 駒モデル
class Piece
  attr_reader :type, :owner

  def initialize(type, owner)
    @type = type
    @owner = owner
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

  private

  # ライオンの動き
  def lion_moves(current_position)
    row, col = current_position
    moves = []
    (-1..1).each do |row_offset|
      (-1..1).each do |col_offset|
        next if row_offset.zero? && col_offset.zero?

        moves << [row + row_offset, col + col_offset]
      end
    end
    moves.select { |r, c| valid_position?(r, c) }
  end

  # ゾウの動きを定義
  def elephant_moves(current_position)
    row, col = current_position
    moves = [[-1, -1], [-1, 1], [1, -1], [1, 1]].map do |row_offset, col_offset|
      [row + row_offset, col + col_offset]
    end
    moves.select { |r, c| valid_position?(r, c) }
  end

  # キリンの動きを定義
  def giraffe_moves(current_position)
    row, col = current_position
    moves = [[-1, 0], [1, 0], [0, -1], [0, 1]].map do |row_offset, col_offset|
      [row + row_offset, col + col_offset]
    end
    moves.select { |r, c| valid_position?(r, c) }
  end

  # ひよこの動きを定義
  def chick_moves(current_position, owner)
    row, col = current_position
    row_offset = owner == :sente ? -1 : 1
    [[row + row_offset, col]].select { |r, c| valid_position?(r, c) }
  end

  # 移動先が枠内にあるか
  def valid_position?(row, col)
    row.between?(0, 3) && col.between?(0, 2)
  end
end
