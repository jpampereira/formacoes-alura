# Redes

## :one: Obtendo informações da rede

- Para obter informações de rede, como IP, máscara de rede e etc., executamos os seguintes comandos:
  - Windows:

    ![Comandos de Rede - Windows](Imagens/Comandos%20de%20Rede%20-%20Windows.png)

    - Nesse caso, a máquina estava conectada a Internet utilizando a interface de rede sem fio, portanto, essas informações devem ser consideradas. Caso estivesse conectada utilizando um cabo de rede, deveriamos considerar as informações da interface Ethernet 3.

  - Linux:

    ![Comandos de Rede - Linux](Imagens/Comandos%20de%20Rede%20-%20Linux.png)

- Entre as informações disponibilizadas por esses comandos:
  - **Endereço IP:** Identificador único da máquina na rede utilizado para o endereçamento de pacotes;
  - **Interface LOOPBACK:** Interface virtual muito utilizada em situações de desenvolvimento, que permite que um cliente e um servidor, ambos na mesma máquina, consigam se comunicar. É muito comum, ao invés de 127.0.0.1, utilizarmos **localhost**;
  - **MAC Address:** Identificador único da placa de rede que trabalha na camada de enlace de dados nos modelos OSI e TCP/IP. Ele é utilizado para diversas finalidades, como roteamento de pacotes em rede local, filtragem de acesso, autenticação e identificação de dispositivos. É possível, por exemplo, configurar um roteador para permitir que apenas determinados MAC Address consigam se conectar com aquela rede. Ele é composto por seis pares de dígitos hexadecimais separados por hífens ou dois pontos;

- Vale ressaltar que um endereço IP é composto de 32 bits, divididos em 4 grupos de 8 bits cada (octetos). Esse *range* de valores podem variar de 0 à 255.

- A ferramenta [IP Calculator](https://jodies.de/ipcalc) nos traz diversas informações sobre a nossa rede apenas com o fornecimento do IP da nossa máquina e a máscara de rede:

  ![IP Calculator](Imagens/IP%20Calculator.png)

  - **Address:** Endereço IP da máquina em questão;
  - **Netmask (ou máscara de rede):** Significa que os primeiros 24 bits (ou 3 octetos) identificam a rede, isto é, todos os dispositivos conectados a essa mesma rede terão o endereço IP com os primeiros 24 bits iguais. A convenção é colocar como o valor 255 os octetos que representam a rede e os demais com 0;
  - **Wildcard:** Essa informação é oposto da *Netmask*, isto é, informa quais octetos identificam a máquina. No exemplo acima, os três primeiros octetos identificam a rede, por isso encontram-se com o valor 0, enquanto o último octeto identifica a máquina, por isso o valor 255;
  - **Network:** Outra nomenclatura utilizada para identificar a rede, onde o valor anterior a barra representa o endereço IP da rede e o valor após a barra representa a máscara de rede;
  - **Broadcast:** O endereço de broadcast é utilizado quando deseja-se enviar mensagens para todos os dispositivos conectados na mesma rede.

- Na imagem acima, outra informação interessante e ainda não mencionada são **HostMin**, **HostMax** e **Hosts/Net**. Essas informações indicam quais possíveis valores mínimo e máximo de endereço IP uma máquina pode assumir, além do número máximo de dispositivos que podem ser conectados a essa rede. Mas então surge o questionamento: se um octeto varia de 0 à 255, para que servem os valores 0 e 255? No caso do endereço 255, já entendemos que ele é utilizado como IP de Broadcast, enquanto o 0 é utilizado para identificar quais octetos não compõe a máscara de rede.
  - O HostMin geralmente é reservado para o **Gateway Padrão** da rede, isto é, o dispositivo responsável por ser a porta de entrada e saída de dados daquela rede local. Comumente em uma rede doméstica, esse Gateway Padrão é o roteador Wi-Fi no qual os dispositivos se conectam para ter acesso a Internet.

## :two: IP Público x IP Privado

- A RFC 1918 define quais os endereços de rede são considerados privados, isto é, não são possíveis de serem acessados de qualquer ponto da Internet, sendo esses:
  - 10.0.0.0/8
  - 172.16.0.0/12
  - 192.168.0.0/16

- Exemplo: Eu estou conectado me minha rede local, no endereço 192.168.15.32 e desejo acessar um servidor localizado na empresa onde eu trabalho, no endereço 172.28.115.2. Se observarmos a imagem abaixo, podemos perceber que esse acesso direto não será possível, pois esse endereço IP encontra-se dentro do *range* de IPs Privados, sendo necessário realizar um acesso remoto utilizando uma VPN, por exemplo, antes de poder acessar esse servidor.

  ![IP Calculator](Imagens/IP%20Calculator%202.png)

  - Agora, se desejarmos acessar um servidor, também da minha empresa, no endereço 172.67.188.168, esse acesso será possível sem a necessidade de uma conexão remota prévia com a rede local, pois ele se encontra fora do *range* de IPs privados, sendo então, um IP Público.

## :three: Resolução de Nomes

- Seja uma situação onde temos uma aplicação que realiza chamadas para outra disponibilizada em um serviço de nuvem, como por exemplo, o AWS. Porém, por algum motivo, essa aplicação é migrada para o Azure, outro provedor de nuvem, que utiliza outro *range* de IPs. Imagine a dor de cabeça se todas as aplicações que utilizam esse sistema precisassem alterar em código o endereço IP que precisa ser chamado.  
  - Graças ao serviço de resolução de domínios/nomes ou DNS (*Domain Name Services*), isso não é necessário;
  - Basta apenas alterar no servidor de DNS o endereço IP ao qual aquele domínio faz referência, que todos os sistemas passarão a ser direcionados para a nova localização;
  - Portanto, uma dica: sempre que possível, utilize o nome do domínio ao invés do endereço IP em código.

- Outra vantagem do serviço de resolução de nomes é que é muito mais fácil para nós seres humanos guardarmos nomes como google.com, do que endereços IPs (se já é difícil em endereços do tipo IPV4, imagina no IPV6, onde são guardados 4 vezes mais bits).

- É possível fazer uma requisição para o servidor de DNS pelo endereço IP de um determinado domínio (o comando é o mesmo para Linux e Windows):

  ```Linux
    nslookup <dominio>
  ```

  - Exemplo:

    ![Comando nslookup](Imagens/Linux%20Terminal%20-%20Comando%20nslookup.png)

    - A primeira resposta é o endereço IP de um dos servidores do google na versão IPv4 e o segundo é na versão IPv6.  

- É possível obter mais informações:

  ```Linux
    dig @<servidor-dns> <dominio>
  ```

  - Esse comando é muito utilizado para debugar e encontrar possíveis falhas de DNS;
  - Exemplo:

    ![Comando dig](Imagens/Linux%20Terminal%20-%20Comando%20dig.png)

    - Na primeira linha do `ANSWER SECTION`, é retornado a resolução do domínio passado como parâmetro;
    - `Query time` retorna o tempo de resposta para aquela requisição;
    - `SERVER` retorna qual servidor de DNS retornou aquela resposta (no caso, como não foi passado nenhum servidor DNS como parâmetro, foi consultado o padrão configurado na máquina que é um servidor local);
    - `WHEN` retorna quando foi realizada a requisição;
    - `MSG SIZE rcvd` retorna o tamanho da mensagem de resposta.

  - Exemplo especificando um servidor de DNS:

    ![Comando dig com servidor DNS](Imagens/Linux%20Terminal%20-%20Comando%20dig%20especificando%20servidor.png)

- Para verificar quais os servidores DNS configurados na máquina:
  - Windows:

    ```Windows
      ipconfig /all
    ```

    - Exemplo:

      ![Prompt de Comando - ipconfig all](Imagens/Windows%20Prompt%20-%20ipconfig%20all.png)

      - No exemplo acima, o servidor de DNS padrão configurado é o Gateway Padrão da minha rede doméstica, onde provavelmente há informações de qual servidor DNS consultar.

  - Linux:

    ```Bash
      cat /etc/resolv.conf
    ```

    - Exemplo:

      ![Linux Terminal - resolv.conf](Imagens/Linux%20Terminal%20-%20resolv.conf.png)

      - No exemplo acima, é configurado um servidor DNS local para resolução de nomes.

- Nos sistema operacionais Linux, há um arquivo em `/etc/hosts` onde é possível configurar resoluções de nomes para endereços IPs. Deve-se ter em mente que este arquivo não funciona com substituto do servidor DNS e deve ser utilizado apenas para testes.

  ![Arquivo /etc/hosts](Imagens/Linux%20Terminal%20-%20hosts.png)

  - Por isso, ao digitarmos `localhost`, logo nossa máquina entende que desejamos nos conectar com a interface de LOOPBACK da nossa máquina:

    ![Ping em localhost](Imagens/Linux%20Terminal%20-%20Comando%20ping%20em%20localhost.png)
