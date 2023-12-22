# 駒モデル
class Piece
  attr_reader :type, :owner

  def initialize(type, owner)
    @type = type
    @owner = owner
  end
end
