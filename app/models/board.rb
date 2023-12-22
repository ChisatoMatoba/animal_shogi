# 盤モデル
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(4) { Array.new(3) }
    setup_pieces
  end

  private

  def setup_pieces
    # 先手の駒の配置
    place_piece(3, 0, Piece.new('G', :sente)) # キリン
    place_piece(3, 1, Piece.new('L', :sente)) # ライオン
    place_piece(3, 2, Piece.new('E', :sente)) # ゾウ
    place_piece(2, 1, Piece.new('C', :sente)) # ひよこ

    # 後手の駒の配置
    place_piece(0, 0, Piece.new('e', :gote)) # ゾウ
    place_piece(0, 1, Piece.new('l', :gote)) # ライオン
    place_piece(0, 2, Piece.new('g', :gote)) # キリン
    place_piece(1, 1, Piece.new('c', :gote)) # ひよこ
  end

  def place_piece(row, col, piece)
    @grid[row][col] = piece
  end
end
