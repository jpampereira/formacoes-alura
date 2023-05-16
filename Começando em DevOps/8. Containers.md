# Containers

- Antigamente criar e manter a infraestrutura de uma aplicação era uma tarefa custosa, já que necessitava da configuração de um servidor diferente para componente existente no sistema e ainda era necessário se preocupar com a comunicação entre essas máquinas.
  - Esse tipo de infraestrutura leva o nome de *On Premise*.
  - Além da dificuldade de se manter uma aplicação que possui componentes em máquinas diferentes, há a questão do preço;
  - Outra questão é a escalabilidade: Caso fosse necessário escalar a infraestrutura em determinadas épocas para suportar um maior número de requisições, era necessário configurar novos servidores físicos, e no restante do período em que eles não fossem utilizados, estes ficariam ociosos.

![Infraestrutura On Premise](Imagens/Infraestrutura%20On%20Premise.png)

- A primeira solução criada para facilitar essa questão de infraestrutura foram as **Máquinas Virtuais**.
  - Ambiente compartilhável: É criada uma imagem que descreve como aquele servidor deve funcionar e caso fosse necessários mais servidores com aquela mesma configuração, era necessário apenas replicar essa imagem;
  - Passível de centralização;
  - Rápida restauração: Caso fosse necessário reiniciar o servidor, poderia se utilizar a imagem para apenas voltar a um estado anterior de estabilidade;
  - Comunicação entre máquinas virtuais em um mesmo computador é mais simples do que máquinas reais.

- Desvantagens das VMs (*Virtual Machines*):
  - Um Sistema Operacional por VM;
  - Desperdício de recursos: Um SO por cada aplicação executando na máquina física;
  - Necessidade de hardware mais potente: Mesmo motivo do ponto anterior;
  - Dificuldade na criação.

![VMs x Containers](Imagens/VMs%20x%20Containers.png)

- Uma Máquina Virtual funciona em cima de um sistema chamado **Hypervisor**, que realiza o gerencimento de VMs e permite a comunicação entre os SOs das máquinas *Guest* e *Host*. Cada Máquina Virtual possui seu próprio SO, além da aplicação propriamente dita e suas bibliotecas necessárias.

- Os Containers funciona em cima de uma **Container Engine**, que funciona também como um gerenciador de ambientes personalizados. A diferença para as VMs é que os ambientes virtualizados possuem apenas a aplicação que deve ser executada e suas bibliotecas necessárias, recursos de SO, rede, etc, tudo isso é compartilhado com o SO da máquina *Host*, tornando-os mais leves que as Máquinas Virtuais.

- Vantagens dos containers:
  - Mais leve;
  - Sem custo de manutenção de vários SOs;
  - Mais rápido para provisionar (levantar).

- Da mesma forma que existem as imagens nas VMs, o mesmo conceito existe para os containers. Nessas imagens são especificadas qual a aplicação e todas as bibliotecas necessárias para ela funcionar e a partir delas podem ser gerados quantos containers forem necessários.
  - Fazendo uma analogia com POO, pense na imagem como uma Classe e o container como a instanciação dessa Classe, ou seja, um Objeto.
