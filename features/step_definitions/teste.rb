Dado("que possua a mensagem {string}") do |message|
  @message = message
end

Quando("o valor da variável de mensagem for exibida no terminal") do
  @log = QaServices::LogService.new
  @log.log_info(@message)
end

Então("o projeto foi criado com sucesso") do
  @log.log_info("Parabéns QA, está tudo certo! bora Codar")
end