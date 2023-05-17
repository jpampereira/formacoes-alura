# TCP e UDP

- A arquitetura da rede de computadores é baseada no modelo de camadas, onde cada uma delas possui uma função específica e há uma relação de dependência entre ela e a diretamente mais abaixo. Em cada uma dessas camadas existem protocolos variados, que permitem a comunicação e transmissão de dados entre aplicações/dispositivos das mais diferentes maneiras.
  - Esse modelo também é conhecido como **Pilha de Protocolos**;
  - Os modelos mais famosos que explicam o funcionamento da internet são o OSI, que possui sete camada e o TCP/IP, que possui 5 camadas e é comumente refereciado como o modelo utilizado pela Web;
  - No modelo TCP, por exemplo, as cinco camadas são classificadas da seguinte forma:

    | Camada | Nome       | Descrição                                                                             |
    | :----: | :---------:| :-----------------------------------------------------------------------------------: |
    | 1      | Aplicação  | Protocolos responsáveis pela comunicação nas aplicações.                              |
    | 2      | Transporte | Protocolos responsáveis pela comunicação e transmissão de pacotes entre dispositivos. |
    | 3      | Rede       | Protocolos responsáveis pelo roteamento dos pacotes pela rede.                        |
    | 4      | Enlace     | Protocolos responsáveis pelo tratamento das comutações, etc.                          |
    | 5      | Física     | Protocolos para transmissão de dados por meio de sinais elétricos.                    |

    - No caso acima, os protocolos da camada 3 (Rede), são responsáveis por realizar o roteamento dos pacotes pela rede para irem de um ponto à outro, existindo várias formas de se realizar isso através de diferentes algoritmos. Porém, essa camada possui dependência das camadas 1 (Física) e 2 (Enlace) para que ela funcione, mas ao mesmo tempo, não está preocupada em como essas camadas abaixo realizam essas tarefas, desde que sejam feitas, havendo uma abstração.

- Outra coisa que é importante de se entender é que o fato de uma mesma camada possuir diferentes tecnologias, não significa que existam protocolos melhores do que outros e sim aqueles que se encaixam melhor em determinada situação. Os protocolos **TCP** e **UDP** são uma ótima opção para exemplificar como protocolos de uma mesma camada são mais adequados em diferentes situações.

- O **UDP** (*User Datagram Protocol*) é um protocolo da camada de transporte não voltado para conexão, isto é, não é necessário estabelecer uma comunicação entre os dispositivos para que os dados sejam enviados.
  - O grande problema do UDP é sua confiabilidade, uma vez que não há o estabelecimento de comunicação entre as pontas e a entrega de pacotes não é garantida, havendo assim perdas de dados durante a transmissão;
  - Sua grande vantagem é a questão da velocidade, permitindo comunicações rápidas, uma vez que não é necessário um processo de estabelecimento de conexão entre as pontas.

- O **TCP** (*Transmission Control Protocol*), por outro lado, é um protocolo da camada de transporte voltado para conexão, havendo o estabelecimento de conexão entre as pontas utilizando um aperto de mão de três vias, o *three way handshake, também conhecido como **SYNC**, **SYN-ACK**, **ACK**.
  - Como funciona o *three way handshake*:

    1. O Host A deseja se conectar ao Host B e para isso envia um pacote de sincronização (**SYN**chronize);
    2. O Host B recebe esse pacote e responde com a confirmação da sincronização (**SYN**chronize-**ACK**nowledge);
    3. Por fim, o Host A manda uma confirmação para o Host B (**ACK**nowledge), assim estabelecendo a conexão.
  
  - O estabelecimento da conexão previamente ao envio de dados propicía confiabilidade na entrega dos dados e o respeito na ordem de entrega dos dados.

- Conhecendo os dois protocolos, poderiamos chegar a conclusão, equivocada, de que o **TCP** é melhor do que o **UDP**, já que este garante a entrega dos dados. Porém, como explicado, não existem protocolos melhores e piores, e sim, protocolos mais adequados para determinadas situações.
  - O protocolo UDP será mais adequado em situações onde a perda de dados não é um problema e que a velocidade seja prioridade, como por exemplo, sistemas de streaming e jogos online, onde a perda pequena de dados não causará uma degradação do serviço e a velocidade é primordial para garantir a melhor experiência do usuário;
  - O protocolo TCP é mais adequado em casos onde deve-se priorizar a confiabilidade na entrega dos dados em relação a sua velocidade, como por exemplo, aplicativos de mensagens instantâneas;
  - Se utilizássemos o protocolo UDP em um aplicativo de mensagens instantâneas, por exemplo, a perda, mesmo que mínima, de pacotes, pode causar o não envio de mensagens, além da entrega das mesmas fora de ordem, tornando a comunicação entre os usuários confusa. A velocidade também não é um fator primordial nesse tipo de aplicação;
  - Se optassemos pelo uso do protocolo TCP em um serviço de jogo online, por exemplo, não haveria a perda de pacotes, por outro lado, seu envio seria mais demorado, por conta da necessidade de se estabelecer a conexão previamente ao seus envio, causando os famigerados *lags*. Nesse caso, como velocidade é primordial e a perda de alguns pacotes não irá causar uma degradação considerável na aplicação, optasse pelo uso do UDP.

- Essa mesma lógica se aplica para os protocolos das demais camadas.
