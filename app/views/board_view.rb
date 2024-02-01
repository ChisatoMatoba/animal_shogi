# frozen_string_literal: true

# ボードのレイアウトを表示
class BoardView
  def self.display(board)
    puts '   | A | B | C |'
    board.grid.each_with_index do |row, i|
      row_str = row.map { |cell| cell.nil? ? ' ' : cell.to_s }.join(' | ')
      puts "#{i + 1} | #{row_str} |"
    end
  end
end
