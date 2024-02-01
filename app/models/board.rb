# frozen_string_literal: true

# 盤モデル
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(4) { Array.new(3) }
    setup_pieces
  end

  # ライオンが取られたかどうかをチェックするロジック
  def checkmate?(player)
    lion = find_lion(player)
    lion.nil?
  end

  # 指定された座標にある駒を返す
  def piece_at(position)
    row, col = position # すでにインデックス化された座標を使用
    @grid[row][col]
  end

  # 移動可能かの判定
  def can_move?(from, to, piece)
    # 駒の現在位置と移動先を取得
    position_to_index(from)
    to_row, to_col = position_to_index(to)

    # 移動先の座標が有効かどうかチェック
    return false unless valid_position?(to_row, to_col)

    # 駒の移動ルールに基づいて、移動できるかどうかを判断
    possible_moves = piece.moves
    possible_moves.include?([to_row, to_col])
  end

  # ボードの行と列のインデックスに変換
  def position_to_index(position)
    col = position[0].ord - 'A'.ord
    row = position[1].to_i - 1
    [row, col]
  end

  # 指定された位置の駒をクリアする
  def clear_piece(row, col)
    @grid[row][col] = nil
  end

  # 駒を配置し、その位置情報を更新する
  def place_piece(row, col, piece)
    piece&.update_position([row, col])
    @grid[row][col] = piece
  end

  private

  def setup_pieces
    # 先手の駒の配置
    place_piece(3, 0, Piece.new('G', :sente, [3, 0])) # キリン
    place_piece(3, 1, Piece.new('L', :sente, [3, 1])) # ライオン
    place_piece(3, 2, Piece.new('E', :sente, [3, 2])) # ゾウ
    place_piece(2, 1, Piece.new('C', :sente, [2, 1])) # ひよこ

    # 後手の駒の配置
    place_piece(0, 0, Piece.new('e', :gote, [0, 0])) # ゾウ
    place_piece(0, 1, Piece.new('l', :gote, [0, 1])) # ライオン
    place_piece(0, 2, Piece.new('g', :gote, [0, 2])) # キリン
    place_piece(1, 1, Piece.new('c', :gote, [1, 1])) # ひよこ
  end

  # 指定したプレイヤーのライオンを探す
  def find_lion(player)
    @grid.flatten.find { |piece| piece && piece.type.downcase == 'l' && piece.owner == player }
  end

  # 移動先が枠内にあるかチェック
  def valid_position?(row, col)
    row.between?(0, 3) && col.between?(0, 2)
  end
end
