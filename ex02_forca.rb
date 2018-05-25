
require_relative 'ex02_ui'
require_relative 'ex02_ranking'

def escolhe_palavra_secreta
  #Essa é a forma ideal de pegar um dado de um arquivo, porque não joga ele na memória. Para tal, põe-se o número de elementos
  #do arquivo na primeira linha.
  avisa_escolhendo_palavra
  dicionario = File.new ("ex02_dicionario.txt")
  qtd_de_palavras = dicionario.gets.to_i
  nr_palavra_secreta = rand(qtd_de_palavras)
  for linha in 1..(nr_palavra_secreta - 1)
    dicionario.gets
  end
  palavra_secreta = dicionario.gets.strip
  dicionario.close
  avisa_palavra_escolhida palavra_secreta
end

def palavra_mascarada chutes, palavra_secreta
  mascara = ""
  for letra in palavra_secreta.chars
    if chutes.include? letra
      mascara << letra
    else
      mascara << "_"
    end
  end
  mascara
end

def pede_chute_valido chutes, erros, mascara
  cabecalho_de_tentativa chutes, erros, mascara
  loop do
    chute = pede_um_chute
    if chutes.include? chute
      avisa_chute_efetuado chute
      next
    else
      return chute
    end
  end
end

def joga(nome)
  palavra_secreta = escolhe_palavra_secreta

  erros = 0
  chutes = []
  pontos_ate_agora = 0

  while erros < 5
    mascara = palavra_mascarada chutes, palavra_secreta
    chute = pede_chute_valido chutes, erros, mascara
    chutes << chute

    chutou_uma_letra = chute.size == 1
    if chutou_uma_letra
      letra_procurada = chute[0]
      total_encontrado = 0
      total_encontrado = palavra_secreta.count letra_procurada
      if total_encontrado == 0
        avisa_letra_nao_encontrada
        erros+=1
      else
        avisa_letra_encontrada total_encontrado
      end
    else
      acertou = chute == palavra_secreta
      if acertou
        avisa_acertou_palavra
        pontos_ate_agora += 100
        break
      else
        avisa_errou_palavra
        pontos_ate_agora -=30
        erros +=1
      end
    end
  end

  puts "\n\nA palavra secreta era #{palavra_secreta}!"
  avisa_pontos pontos_ate_agora
  pontos_ate_agora
end

def jogo_da_forca
  nome = da_boas_vindas
  pontos_totais = 0

  avisa_campeao_atual le_ranking

  loop do
    pontos_totais += joga nome
    avisa_pontos_totais pontos_totais
    if le_ranking[1].to_i < pontos_totais
      salva_ranking nome, pontos_totais
    end
    break if não_quer_jogar?
  end
end
