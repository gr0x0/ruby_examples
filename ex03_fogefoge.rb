require_relative 'ex03_ui'
require_relative 'ex03_heroi'

def le_mapa numero
  texto = File.read("ex03_mapa#{numero}.txt")
  mapa = texto.split "\n"
end

def encontra_jogador mapa
  char_do_heroi = "H"
  mapa.each_with_index do |linha_atual, linha|
    coluna_do_heroi = linha_atual.index char_do_heroi
    if coluna_do_heroi
      jogador = Heroi.new
      jogador.linha = linha
      jogador.coluna = coluna_do_heroi
      return jogador
    end
  end
  nil
end

def posicao_valida? mapa, posicao
  linhas = mapa.size
  colunas = mapa[0].size
  estourou_linhas = posicao[0] < 0 || posicao[0] >= linhas
  estourou_colunas = posicao[1] < 0 || posicao[1] >= colunas

  if estourou_linhas || estourou_colunas
    return false
  end

  valor_atual = mapa[posicao[0]][posicao[1]]
  if valor_atual =="X" || valor_atual =="F"
    return false
  end
  true
end

def posicoes_validas_a_partir_de mapa, posicao
  posicoes = []
  movimentos = [[+1, 0], [0, +1], [-1, 0], [0, -1]]
  movimentos.each do |movimento|
    nova_posicao = [posicao[0] + movimento[0], posicao[1] + movimento[1]]
    if posicao_valida? mapa, nova_posicao
      posicoes << nova_posicao
    end
  end
  posicoes
end

def move_fantasma mapa, linha, coluna
  posicoes = posicoes_validas_a_partir_de mapa, [linha, coluna]
  return if posicoes.empty?

  posicao = posicoes[rand posicoes.size]
  mapa[linha][coluna] = " "
  mapa[posicao[0]][posicao[1]] = "N"
end

def move_fantasmas mapa
  char_do_fantasma = "F"
  char_do_novo_fantasma = "N"
  mapa.each_with_index do |linha_atual, linha|
    linha_atual.chars.each_with_index do |char_atual, coluna|
      eh_fantasma = char_atual == char_do_fantasma
      if eh_fantasma
        move_fantasma mapa, linha, coluna
      end
    end
  end
  mapa.each_with_index do |linha_atual, linha|
    linha_atual.chars.each_with_index do |char_atual, coluna|
      if char_atual == char_do_novo_fantasma
        mapa[linha][coluna] = "F"
      end
    end
  end
end

def jogador_perdeu? mapa
  perdeu = !encontra_jogador(mapa)
end

def joga nome
  mapa = le_mapa 2

  while true
    desenha mapa

    direcao = pede_movimento
    heroi = encontra_jogador mapa
    nova_posicao = heroi.calcula_nova_posicao direcao
    next if !posicao_valida? mapa, nova_posicao.to_array

    heroi.remove_do mapa
    nova_posicao.coloca_no mapa

    move_fantasmas mapa
    if jogador_perdeu? mapa
      game_over
      break
    end
  end
end

def inicia_fogefoge
  nome = da_boas_vindas
  joga nome
end
