def salva_ranking nome, pontos_totais
  conteudo = "#{nome}\n#{pontos_totais}"
  File.write "ex02_ranking.txt", conteudo
end

def le_ranking
  conteudo = File.read "ex02_ranking.txt"
  conteudo.split "\n"
end
