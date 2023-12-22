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

  def lion_moves
    # ライオンの動きを定義
  end

  def elephant_moves
    # ゾウの動きを定義
  end

  def giraffe_moves
    # キリンの動きを定義
  end

  def chick_moves
    # ひよこの動きを定義（プロモーション含む）
  end
end
