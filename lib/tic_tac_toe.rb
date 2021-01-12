WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left col
  [1,4,7],  # Middle col
  [2,5,8],  # Right col
  [0,4,8],  # Diag 1
  [2,4,6]  # Diag 2
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input = input.to_i
  index = input - 1
end

def move(board, index, character)
  def update_array_at_with(array, index, value)
    array[index] = value
  end

  update_array_at_with(board, index, character)
  board
end

def position_taken?(board, index)
  if ((board[index] == " ") || (board[index] == "") || (board[index] == nil))
    return false
  else
    return true
  end
end

def valid_move?(board, index)
  if (index > 8 || index < 0)
    return false
  else
    if position_taken?(board, index)
      return false
    else
      return true
    end
  end
end

def turn_count(board)
  x = 0
  y = 0
  while x < board.length
    board.each do |turns|
      if board[x] == "X" || board[x] == "O"
        y += 1
      end
      x += 1
    end
  end
  return y
end

def current_player(board)
  if turn_count(board) % 2 != 0
    return "O"
  else
    return "X"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combinations|
    if (board[win_combinations[0]]== "X" && board[win_combinations[1]]=="X" && board[win_combinations[2]]=="X") ||
       (board[win_combinations[0]]== "O" && board[win_combinations[1]]=="O" && board[win_combinations[2]]== "O")
      return win_combinations
    end
  end
  return false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
  return false
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |win_combinations|
      if (board[win_combinations[0]]== "X" && board[win_combinations[1]]=="X" && board[win_combinations[2]]=="X")
        return "X"
      elsif (board[win_combinations[0]]== "O" && board[win_combinations[1]]=="O" && board[win_combinations[2]]== "O")
        return "O"
      end
    end
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  if over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
  end
end
