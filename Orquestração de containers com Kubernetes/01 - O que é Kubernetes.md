# O que é Kubernetes?

- Antes de falar sobre Kubernetes, é importante entendermos o funcionamento de outra tecnologia diretamente ligada: a virtualização baseada em containers. Esse tipo de virtualização surge como uma alternativa a virtualização baseada em máquinas virtuais, possuindo vantagens como ser mais simples de instalar e manipular, ser mais leve, pois encapsula em um ambiente isolado apenas o necessário para que a aplicação funcione, como bibliotecas, ambiente de execução (*runtime environment*) e o código, além de outras vantagens; tudo isso descrito em um arquivo chamado de imagem, uma espécie de molde (fazendo uma analogia com POO, as imagens seriam as classes e os containers as classes instanciadas, isto é, os objetos). A ferramenta mais popular quando falarmos de containerização é o **Docker**.

- Essa tecnologia tornou-se extremamente popular nos últimos anos na forma como distribuir e rodar a aplicação, estando fortemente ligada as arquiteturas de microsserviços, onde os diferentes componentes que compõe uma aplicação, como por exemplo, Front-End, Back-End, Banco de Dados, Servidor de Proxy, etc., são separados e executados em ambientes isolados, mesmo que na mesma máquina.

- Esse modelo de microsserviços e a containerização trazem benefícios como a divisão de sistemas em partes menores, facilitando a manutenção e escalabilidade de cada um dos componententes que compõe a solução. Porém, trouxe novos desafios, como questões de disponibilidade, escalabilidade, sincronismo entre os ambientes e seu monitoramente, conexões de rede, mapeamento de diretórios entre ambiente virtualizado e máquina host, etc.

- Nesse contexto de gerenciar essas questões dos containers, entra o **Kubernetes**, um projeto *open-source* desenvolvido pela Google. A palavra Kubernetes tem origem grega e significa "timoneiro" ou "piloto", dando a entender que ele é quem irá guiá-los (os containers) para funcionem da melhor forma possível, igual a o capitão de um navio.
  - Isso também justifica o fato do símbolo do Kubernetes ser o timão de um navío;
  - Também é conhecido como Orquestrador de Containers.

- O Kubernetes não é a única solução para orquestração de containers. O próprio Docker possui sua ferramenta chamada Docker Compose.
