# Infrastructure as Code (IaC)

- Independentemente da plataforma ao qual as aplicações são executadas, elas possuem uma coisa em comum: ela precisam de um ambiente onde podem ser criadas, testes e publicadas para o usuário final.

- Esse ambientes são formados por elementos de hardware como memória, processador, disco rígido, placa de rede, além de elementos de software como Sistema Operacional, a aplicação em sí, bibliotecas de apoio, etc.

- Cada um desses elementos requer manutenção periódica, afim de não afetar a disponibilidade da aplicação final, o que mostra que a tarefa de criar e manter um ambiente é uma tarefa trabalhosa. E se pensarmos no contexto de uma aplicação real, a mesma é formada por diferentes ferramentas, ou seja, existem diferentes ambientes que necessitam dessa manutenção.
  - Muito trabalho;
  - Uma única aplicação possuirá ao menos três ambientes: Desenvolvimento, Homologação e Produção (e esses devem ser iguaizinhos).

- Uma ação bastante adotada pelos times responsáveis pela infraestrutura das aplicações é possuir um checklist, que auxilia durante os processos de criação e manutenção.
  - Porém, apesar da existência do checklist, o processo continua sendo feito de forma manual, o que eu traz duas questões: é caro e arriscado.
  - Caro pois a tarefa irá consumir recursos humanos por um determinado período de tempo, que dependendo da complexidade, pode ser alto;
  - Arriscado pois qualquer tarefa executada de forma manual possui o fator humano, isto é, por algum descuido ou falta de atenção, um passo do checklist pode ser ignorado, por exemplo, acarrentando em problemas.

*"Verifica-se que qualquer coisa que pode dar errado no mar, geralmente da errado, mais cedo ou mais tarde."* Alfred Holt, 1877.

- E mesmo que esses fatores não sejam relevantes, ainda existem outros dois problemas: hardware é caro, além de ser subutilizado pelas aplicações que ele roda.

- Uma alternativa para essa questão é a **Virtualização**.
  - Redução de custos com aquisição, manutenção e espaço;
  - Facilita dimensionar recursos físicos, evitando a subutilização das máquinas.

- Duas alternativas muito utilizadas do mercado nos dias de hoje são: Vagrant e Docker.

- O Vagrant utiliza o método de virtualização baseado em máquinas virtuais (também conhecido como virtualização full):

  ![Virtualição via VM](Imagens/Virtualização%20via%20VM.png)

  - Nesse modelo, os ambientes são virtualizados em cima do Hypervisor, que funciona como gerenciador dos ambientes. Além de gerenciar os ambientes, o Hypervisor realiza toda a comunicação entre os ambientes virtualizados e o SO da máquina host, para que seja possível usufruir do hardware que a máquina física dispõe.
  - Esse ambientes virtualizados são completos, isto é, possuem seu próprio Sistema Operacional, junto da aplicação e de todas as suas bibliotecas auxiliare necessárias.

- O Docker utiliza o modelo de virtualização baseado em containeres:

  ![Virtualização via Container](Imagens/Virtualização%20via%20Container.png)

  - Esse modelo é mais compacto se comparado a virtualização de máquinas virtuais, pois os containers são compostos apenas pela aplicação e suas bibliotecas auxiliares. O Sistema Operacional é compartilhado entre máquinas *host* e *guest*, tornando esse modelo mais leve e mais rápido de iniciar, pois não necessita de um Sistema Operacional próprio que precisa ser inicializado toda vez que a aplicação irá ser iniciada.

- Essas soluções apresentadas permite automatizar o processo de criação de ambientes, onde as configurações são expressas através de arquivos.

- Nas imagens abaixo podemos ver um exemplo de arquivo de configuração do ambiente feita pelo Vagrant.
  - No primeiro arquivo, são especificadas configurações do ambiente, como Sistema Operacional que deve ser instalado, quantidade de memória em disco, memória RAM, e CPUs, portas disponíveis para acesso externo:

    ![Arquivo de Configuração Vagrant 1](Imagens/Arquivo%20de%20configuração%20Vagrant%201.png)

  - No segundo arquivo, são especificadas as configurações de aprovisionamento da solução, isto é, quais bibliotecas e dependências devem ser instaladas para garantir que a solução funcione corretamente no ambiente configurado:

    ![Arquivo de Configuração Vagrant 2](Imagens/Arquivo%20de%20configuração%20Vagrant%202.png)

- Se temos as configurações dos ambientes salvas em arquivos, podemos versioná-las junto do código da aplicação.
