def da_boas_vindas
  puts "Bem vindo ao Foge-foge!"
  puts "Qual é seu nome?"
  nome = gets.strip
  puts "\n"
  puts "Começaremos o jogo para você #{nome}"
  nome
end

def desenha mapa
  puts mapa
end

def pede_movimento
  puts "Para onde deseja ir?"
  movimento = gets.strip.upcase
end

def game_over
  puts "\n\n\n"
  puts "Game Over!"
end
