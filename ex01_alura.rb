#Comments em ruby usam '#'
#'puts' recebe uma string entre aspas e escreve na tela, e 'gets' recebe um valor e o adiciona como string a uma variável
puts "Bem-vindo ao jogo da adivinhação"

#'def' serve para iniciar uma função, terminando-a com 'end', e usando 'return <parametro de retorno>' caso precise
def boas_vindas
  puts "Qual é o seu nome?"
  #Numa string, podemos usar o método '.strip' pra limpar os caracteres que não são letras, como o '\n' por exemplo
  nome = gets.strip
  #Se eu desejo adicionar uma variável a uma declaração impressa por um puts, uso um +<variavel>
  puts "\n\n"
  #Para concatenar na string, utiliza-se "<corpo da string>...#{<variavel>}...<corpo da string>". Dessa forma, o ruby já traduz
  #a variável para string, sem precisar fazer o cast. Pode-se fazer também usando o '+', mas lembrando de usar o '.to_s' pra tudo
  #que não é string
  puts "Começaremos o jogo para você, #{nome}"
  return nome
end

def pede_dificuldade
  puts "Qual o nível de dificuldade que deseja?
  (1 muito fácil, 2 fácil, 3 médio, 4, difícil, 5 muito difícil)"
  return dificuldade = gets.to_i
end

def randomiza_numero_secreto(dificuldade)
  case dificuldade
  when 1
    maximo_numero_secreto = 30
  when 2
    maximo_numero_secreto = 60
  when 3
    maximo_numero_secreto = 100
  when 4
    maximo_numero_secreto = 150
  else
    maximo_numero_secreto = 200
  end

  puts "Escolhendo um número secreto entre 1 e #{maximo_numero_secreto}..."
  #rand é uma fnç nativa que retorna um número aleatório entre 0 e 1, e se receber parâmetro retorna entre 0 e parâmetro
  numero_secreto = rand(maximo_numero_secreto) + 1
  puts "Escolhido... que tal adivinhar hoje nosso número secreto?"
  return numero_secreto
end

def pede_um_numero(tentativa, max_tentativas)
  puts "\n"
  #Para fazer o cast de int pra string, uso o método <variavel>.to_s
  puts "Tentativa #{tentativa} de #{max_tentativas.to_s}"
  puts "Entre com o número"
  #Como gets adiciona um valor como string a uma variável, preciso fazer o cast para inteiro se desejo compará-la com um inteiro.
  #Para tal, utilizo o método <variavel>.to_i
  chute = gets.to_i
  return chute
end

def verifica_se_acertou(numero_secreto, chute)
  #If/ else no ruby (usa o 'end' para terminar):
  acertou = numero_secreto == chute

  if acertou
    puts "Acertou!"
    return true
  end

  maior = numero_secreto > chute
  if maior
    puts "Errou! O número secreto é maior!"
  else
    puts "Errou! O número secreto é menor!"
  end
  return false
end

def joga(nome)
  dificuldade = pede_dificuldade
  numero_secreto = randomiza_numero_secreto(dificuldade)

  max_tentativas = 5
  #Criar um array é <nome> = [] para um vazio, ou <nome> = [<valor1>, <valor2>, ...] para um populado
  chutes = []

  #For no ruby (usa 'end' pra terminar):
  for tentativa in 1..max_tentativas
    #Perceba que essa chamada de função envia parâmetros sem estarem entre parêntesis. Esse é um padrão bastante utilizado.
    chute = pede_um_numero tentativa, max_tentativas
    #A forma mais simples de inserir um elemento no final do array é com '<<'
    chutes << chute
    #Assim imprimo o array inteiro, porém, se precisar percorrer elemento a elemento, posso fazer um 'for i in <array> ... end'
    puts "Você fez #{chutes.size} chute(s): #{chutes}"
    #O break quebra o loop como normal. Repare que posso botar 'break if...'
    break if verifica_se_acertou numero_secreto, chute
  end

  puts "Número secreto é: #{numero_secreto}"
end

def nao_quer_jogar?
  puts "Deseja jogar novamente? (S/N)"
  resposta = gets.strip
  return resposta.upcase == "N"
end

#Corpo principal do programa
nome = boas_vindas
loop do
  joga nome
  if nao_quer_jogar?
    break
  end
end
