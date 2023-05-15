# Linux

- É muito importante aprender sobre Linux pois eles possuem grande importância na construção do back-end das soluções que compõe a Internet.

- Há diferentes distribuições disponíveis para uso de acordo com as demandas de aplicações e usuários. A seleção de uma determinada distribuição deve levar em conta os objetivos e preferências de uso.

- Principais distribuições/sabores (*flavours*) existentes:
  - Ubuntu;
  - Debian;
  - Red Hat;
  - Fedora;
  - CentOS;
  - Suse;
  - Gentoo.

![Distribuições Linux](Imagens/Distribuições%20Linux.png)

- LTS (*Long Term Support*): Versões que possuirão suporte por bastante tempo.

- Para questões de aprendizado, podemos utilizar o Linux instalando ele diretamente na nossa máquina, como Sistema Operacional principal, ou através de virtualização (Máquinas Virtuais ou Containers Docker).

## :one: Servidor Linux

- No curso, foi criado um servidor Linux, utilizando uma imagem do **Ubuntu Server** na versão `22.04.2`. Após instalá-lo, para descobrir seu endereço IP podemos utilizar o seguinte comando:

  ```Bash
    ip addr
  ```

  ![Linux Terminal- Comando ip addr](Imagens/Linux%20Terminal%20-%20Comando%20ip%20addr.png)

  - A interface 1 é a de **LOOPBACK**, conhecida também como `127.0.0.1` ou `localhost`, muito acessada quando queremos acessar aplicações que estão rodando diretamente na nossa máquina.

  - Na interface 2, o endereço IP circulado em vermelho será utilizado para realizar o acesso a máquina de forma remota.

- Para permitir conexões via SSH, é necessário instalar a biblioteca `openssh-server`:

  ```Bash
    sudo apt-get install openssh-server
  ```

## :two: Gerenciador de Pacotes

- Para instalarmos bibliotecas no Sistema Operacional Linux, devemos manipular os gerenciadores de pacotes, utilizado para instalá-las, atualizá-las ou removê-las.
  - No caso da distribuição Ubuntu, o gerenciador de pacotes é o `apt-get`.

- Antes de instalar ou atualizar qualquer pacote, uma boa prática é realizar a atualização dos repositórios configurados na máquina:

  ```Bash
    sudo apt-get update
  ```

  - Quando realizamos esse comando, a máquina atualiza seu repositório local de bibliotecas com os repositórios remotos, assim, quando instalarmos uma nova ferramenta, a mesma será atualizada para a versão mais recente (há não ser que você defina qual versão deseja baixar).

- É possível alterar os repositório remotos.

## :three: Privilégios de Administrador

- Para executar determinados comandos (como por exemplo, manipulação do gerenciador de pacotes), é necessário inserir o comando `sudo` a frente do restante dos comandos.

- O comando `sudo` vem de *Super User Do*, ou em português, "Faça como administrador". Ele concede momentameamente privilégios de administrador para o usuário que está executando o comando (desde que esse usuário possa ter esse privilégio), assim como quando executamos o Prompt de Comando do Windows no modo Administrador.

- Uma boa prática é sempre utilizarmos usuários normais para realizar tarefas no sistema e utilizar o usuário `root` ou os privilégios de administrador quando de fato forem necessários.

## :four: Security Shell (SSH)

- Geralmente vamos utilizar um servidor Linux que está localizado em outra máquina e para isso, precisamos nos conectar a ela.

- O protocolo SSH é um protocolo que oferece acesso remoto seguro a máquinas e servidores, estabelecendo uma comunicação criptografada entre cliente e servidor, garantindo que os dados trafegádos entre essas duas pontas não possam ser interceptados.

- Para acessar uma máquina ou servidor, via SSH:

  ```BAT
    ssh <usuario>@<endereco_ip> [options]
  ```

  ![Conexão SSH](Imagens/SSH.png)

- É possível passar *flags* ou *options* para alterar o comportamento do comando SSH. Entre as mais famosas estão:
  - `-p`: Permite alterar a porta em que será realizada a conexão. Por padrão, o SSH utiliza a porta 22;
  - `-i`: Permite indicar o arquivo que armazena a chave SSH para realizar a autenticação.

- Para finalizar a conexão, utilizamos o comando `exit`.

## :five: Anatomia do Terminal

![Anatomia do Terminal](Imagens/Linux%20Terminal%20-%20Anatomia.png)

- `jpamp`: Nome do usuário conectado;
- `ubuntu-alura`: Hostname da máquina ao qual o usuário está conectado;
- `~`: Indica a pasta de trabalho atual (nesse caso, esse símbolo representa a pasta do usuário em `/home`);
- `$`: Indica que o usuário em questão não possui privilégios de administrador. Caso possuísse, o símbolo apresentado seria o `#`.

## :six: Comandos de Navegação

- Para descobri o diretório de trabalho atual:

  ```Bash
    pwd
  ```

  - Esse comando retorna o caminho absoluto para o diretório de trabalho atual, isto é, o caminho entre o diretório raiz do sistema `/` e o atual.

- Listar os conteúdos de um diretório:

  ```Bash
    ls
  ```

  - Podemos utilizar parâmetros para alterar o formato da saída do comando:
    - `-a`: Listar todos os arquivos existentes no diretório, mesmo aqueles que começam com `.` (arquivos ocultos);
    - `-l`: Listar todos os arquivos existentes no diretório com detalhes (permissões, *owner* e grupo do arquivo, tamanho em bytes, etc.);
    - `-h`: Torna a leitura mais simples. Exemplo: Sem esse parâmetro, o tamanho do arquivo é impresso em Bytes, o que pode ser difícil para leitura e entendimento do usuário. Caso o parâmetro em questão seja utilizado, esse número é impresso utilizando unidades de medida, como `M` (Megabytes) e `G` (Gigabytes).

- O Linux possui uma estrutura de diretórios padrão conhecida como *Filesystem Hierarchy Standard* (FHS):

  ![Filesystem Hierarchy Standard](Imagens/Filesystem%20Hierarchy%20Standard.png)

  - Assim como o `C:` é a pasta raiz nos sistemas operacionais Windows, a `/` é o diretório raiz dos sistemas *Unix Like*.

- Para alterarmos o diretório de trabalho:

  ```Bash
    cd <destino>
  ```

  - O destino pode ser um caminho **absoluto** ou **relativo**, onde o primeiro representa o caminho para o diretório de destino a partir do diretório raiz, enquanto o segundo é o caminho entre o diretório atual de trabalho e o de destino. Exemplo:

    1. O diretório atual de trabalho encontra-se em `/home/jpamp/documentos/faculdade`;
    2. O diretório de destino encontra-se em `/mnt/pendrive/fotos/viagem`;
    3. Para acessar o destino utilizando o caminho absoluto, escrevemos: `cd /mnt/pendrive/fotos/viagem`;
    4. Para acessar o destino utilizando o caminho relativo, escrevemos: `cd ../../../mnt/pendrive/fotos/viagem`;

  - Para ir direto para o diretório do nosso usuário em `/home`, digitamos `cd` ou `cd ~`, independentemente do diretório de trabalho atual;
  - O valor `..` faz referência ao diretório hierarquicamente acima do diretório de trabalho atual. Exemplo:

    1. O diretório atual de trabalho encontra-se em `/home/jpamp/documentos`;
    2. Executamos o comando `cd ..`;
    3. Agora, o diretório de trabalho atual é o `/home/jpamp`.

  - Assim como podemos utilizar o `..` para referenciar o diretório hierarquicamente acima, podemos utilizar o `.` para referenciar o diretório atual;
  - O comando `cd -` retorna ao diretório anterior. Exemplo:

    1. O diretório atual é o `/etc`;
    2. Executamos o comando `cd /var/log` para mudar de diretório;
    3. Se executarmos `cd -`, dentro de `/var/log`, voltamos para `/etc`, pois foi o último diretório visitado antes do atual.

## :seven: Manual dos Comandos

- Para entender o funcionamento de um comando e os parâmetros existentes, podemos consultar sua documentação:

  ```Bash
    <comando> --help
  ```

  ou

  ```Bash
    man <comando>
  ```

## :eight: Manipulando Arquivos e Diretórios

### :arrow-right: Criar

- Para criar um arquivo:

  ```Bash
    touch <nome_arquivo>
  ```

  - É possível criar vários arquivos de uma só vez:

    ```Bash
      touch <nome_arquivo_1> <nome_arquivo_2> ... <nome_arquivo_n>
    ```

- Para criar um diretório:

  ```Bash
    mkdir <nome_diretorio>
  ```

  - É possível criar diretórios de forma aninhada utilizando o parâmetro `-p`:

    ```Bash
      mkdir <nome_diretorio_1>/<nome_diretorio_2>/<nome_diretorio_3>/...
    ```

    - No exemplo acima, o diretório 1 será criado na pasta corrente, o diretório 2 será criado dentro do 1, o diretório 3 será criado dentro do 2, e assim em diante...

- Para criarmos arquivos e diretórios com nomes contendo espaços, devemos utilizar a contrabarra. Exemplo:

  ```Bash
    mkdir diretorio\ 1
  ```

### :arrow-right: Remover

- Para remover um arquivo:

  ```Bash
    rm <nome_arquivo>
  ```

- Para remover um diretório:

  ```Bash
    rmdir <nome_diretorio>
  ```

  - Podemos remover diretórios utilizando o comando `rm`, desde que insiramos o parâmetro `-r`, de recursividade;
  - Se tentarmos apagar um diretório que possui conteúdos, o terminal irá reclamar e impedir a realização da operação. Para forçar a deleção, utilizamos o parâmetro `-f`. Tomar cuidado com esse parâmetro, pois uma vez deletados, os conteúdos não podem ser recuperados.

### :arrow-right: Copiar

- Para copiar tanto arquivos quanto diretórios:

  ```Bash
    cp <origem> <destino>
  ```

  - Para copiarmos diretórios, devemos utilizar o parâmetro `-r`, de recursividade.

- Se o destino for um diretório não existente, o mesmo será criado.

### :arrow-right: Mover e Renomear

- Para mover e renomear arquivos e diretórios, utilizamos o mesmo comando `mv`. O que vai diferenciar se ele está sendo utilizado para uma função ou outra é a origem e o destino passados como parâmetros.
  - Caso origem e destino sejam os mesmos, significa que desejamos renomear o arquivo. Caso origem e destino possuam caminhos diferentes, significa que desejamos realizar o deslocamento dos conteúdos selecionados.

  ```Bash
    mv <origem> <destino>
  ```

## :nine: Globbings

- Globbings, mais conhecidos como **caractéres Coringa**, permitem potencializar o uso do terminal.

- Seja o seguinte cenário, onde temos um diretório com os seguintes arquivos:

  ```Linux
    texto1.pdf 
    texto2.pdf 
    arq1 
    arq2 
    arq3
    arq8
    arq10
    arq20
    arq30
    arq100
    tmp1
    tmp2
  ```

  - Para listar apenas os arquivos com extensão `.pdf`:

    ```Bash
      ls *.pdf
    ```

    - Resultado:

      ```Linux Terminal
        texto1.pdf texto2.pdf
      ```
  
  - Para listar apenas os arquivos que começam com `arq` e que possuem apenas dois dígitos:

    ```Bash
      ls arq??
    ```

    - Resultado:

      ```Linux Terminal
        arq10 arq20 arq30
      ```

  - Para listar apenas os arquivos que possuem três caractéres, seguidos de um número entre 1 e 5:

    ```Bash
      ls ???[1-5]
    ```

    - Resultado:

      ```Linux Terminal
        arq1 arq2 arq3 tmp1 tmp2
      ```

  - Para listar apenas arquivos com possuam três caractéres, seguidos do número 1 ou 3:

    ```Bash
      ls ???[1,3]*
    ```

    - Resultado:

      ```Linux Terminal
        arq1 arq3 arq10 arq30 arq100 tmp1
      ```

- Dado os exemplos acima, podemos observar os seguintes caractéres coringa:

  | Caractére | Descrição |
  | :-------: | :-------: |
  | * | Qualquer coisa |
  | ? | Substitui um único caractére |
  | [-] | Determina um range de valores alfanuméricos |
  | [,] | Determina uma lista de possíveis valores |

- O Terminal Linux é *Case Sensitive*.

## :ten: Conteúdo de Arquivos

- Imprimir o conteúdo de um arquivo no terminal:

  ```Bash
    cat <nome_arquivo>
  ```

- Filtrar conteúdo:

  ```Bash
    grep <filtro> <nome_arquivo>
  ```

  - Caso `<nome_arquivo>` seja `*`, a busca será realizada em todos os arquivos do diretório corrente;
    - Utilizando o parâmetro `-r`, caso o diretório corrente possua diretórios descendentes, a busca pelo conteúdo também será realizada nos mesmos.
    - É possível utilizar outros parâmetros para alterar a resposta do comando:
      - `-i`: Ignora caractéres maiúsculos e minúsculos;
      - `-l`: Ao invés de retornar as linhas dos arquivos que deram *match* com o filtro, retorna o nome desses arquivos;
      - `-L`: Retorna os arquivos cujo conteúdo não deu *match* com o filtro;
      - `-E`: Permite que o filtro seja uma Expressão Regular (Essa expressão regular deve ser passada entre aspas duplas). Outra alternativa é utilizar o comando `egrep`, que aceita expressões regulares sem a necessidade de se utilizar uma *flag*.

- Imprimir o conteúdo de forma paginada:

  ```Bash
    more <nome_arquivo>
  ```

  - Tecla `Enter` ou `Espaço` para ir para a próxima página;
  - Tecla `b` para voltar a página anterior;
  - Tecla `q` para sair da exibição.

- Imprimir o conteúdo linha-a-linha:

  ```Bash
    less <nome_arquivo>
  ```

  - Tecla `Enter`, `Espaço` ou `Seta para cima` para ir para exibir a próxima linha;
  - Tecla `Seta para baixo` para voltar a página anterior;
  - Tecla `q` para sair da exibição.

- Para visualizar as primeiras e últimas linhas de um arquivo, respectivamente:

  ```Bash
    head <nome_arquivo>
  ```

  ```Bash
    tail <nome_arquivo>
  ```

  - Por padrão são exibidas dez linhas, mas podemos utilizar o parâmetro `-n` para determinar essa quantidade.

## :one::one: Busca de Arquivos

- É possível buscar por arquivos, de forma recursiva, a partir de um ponto do sistema de arquivos:

  ```Bash
    find <ponto_de_partida> -name <nome_arquivo>
  ```

  - Exemplo: Caso a busca seja realizada a partir de `/`, todas os diretórios do sistema de arquivos serão verificados procurando pelo arquivo em questão;
  - É possível limitar a profundidade da recursividade, utilizando o parâmetro `-maxdepth`.

- É possível realizar essa busca para encontrar arquivos e diretórios que sofrerão alteração ou foram criados nos últimos X minutos:

  ```Bash
    find <ponto_de_partida> -amin -<valor>
  ```

- É possível fazer essa mesma busca em dias:

  ```Bash
    find <ponto_de_partida> -atime -<valor>
  ```

- Outra possibilidade é buscar arquivos por tamanho:

  ```Bash
    find <ponto_de_partida> -asize <tamanho_arquivo><unidade>
  ```

  - Se utilizar o sinal negativo ou positivo antes de `<tamanho_arquivo>`, estamos dizendo que queremos arquivo abaixo e acima daquele tamanho, respectivamente. Caso nenhum sinal seja passado, serão procurados arquivos com aquele exato tamanho;
  - A unidade, por exemplo, pode ser `M`, que representa **Megabytes**.

## :one::two: Redirecionando a Saída Padrão

- Por padrão, quando executamos um comando para visualizar informações, as mesmas são impressas no próprio terminal. Podemos redirecionar esse conteúdo que será apresentado para arquivos.

- Para redirecionar o conteúdo sobreescrevendo o arquivo de destino:

  ```Bash
    echo <mensagem> > <nome_arquivo>
  ```

- Para redirecionar o conteúdo incrementando o arquivo de destino:

  ```Bash
    echo <mensagem> >> <nome_arquivo>
  ```

- O comando para visualização de informações não precisa ser necessariamente o `echo`. Pode ser outro, como por exemplo, `ls`, `cat`, etc.

- Exemplo:

  1. Executamos o comando `echo Olá, Mundo! > arquivo_saida.txt`. Nesse momento, o conteúdo do arquivo é composto por uma única linha com a frase "Olá Mundo!";
  2. Executamos o comando `echo Olá, João! > arquivo_saida.txt`. Nesse momento, o conteúdo do arquivo é composto por uma única linha com a frase "Olá, João!". Percebemos que o conteúdo do arquivo foi sobreescrito;
  3. Executamos o comando `echo Olá, Pessoal! >> arquivo_saida.txt`. Nesse momento, o conteúdo do arquivo é composto por duas linhas "Olá, João!" e "Olá, Pessoal!". Percebemos que o conteúdo do arquivo foi incrementado.

## :one::three: Agrupamento de comandos

- O símbolo de Pipe (`|`) permite o encadeamento de comandos na mesma linha, onde a saída do primeiro comando é utilizada como entrada para o segundo comando e assim em diante.

### :arrow-right: Exemplo 1

- Outra possibilidade para se utilizar o `grep`, visto anteriormente, é junto de outros comandos:
  - Filtrar conteúdo de um arquivo impresso:

    ```Bash
      cat <nome_arquivo> | grep <filtro>
    ```

  - Filtrar arquivos de um diretório:

    ```Bash
      ls | grep <filtro>
    ```

### :arrow-right: Exemplo 2

- Nosso cliente solicitou um arquivo com as últimas cinquenta linhas do arquivo de log do sistema:

  ```Bash
    tail -n 50 /var/log/syslog | grep systemd > /home/user/log.txt
  ```

### :arrow-right: Exemplo 3

- Ordenar o conteúdo de um arquivo:

  ```Bash
    cat <nome_arquivo> | sort
  ```

## :one::four: Filtrar colunas de um arquivo

- Vimos anteriormente que podemos utilizar o grep para filtrar as linhas de um arquivo. Porém, e se quisermos filtrar as colunas?

- Utilizando o cenário do exemplo 2 do tópico anterior. Nosso cliente solicitou que o arquivo contesse apenas as informações de *timestamp* do log e a informação impressa, ignorando as demais informações:

- O conteúdo original do arquivo `log.txt` é o seguinte:

  ![Linux Terminal - Comando cut](Imagens/Linux%20Terminal%20-%20Comando%20cut.png)

- Podemos visualizar que as colunas do arquivo são **delimitadas** por espaços. Essa informação será importante para a construção do comando que será executado. Outra informação pertinente é que queremos apenas o conteúdo das colunas 1, 2, 3 e 6 em diante.

- Comando para filtrar as colunas:

  ```Bash
    cat logs | cut -d " " -f1-3,6- > log_filtrado.txt
  ```

  - O parâmetro `-id` é utilizado para indicar o delimitador que será utilizado para "quebrar" o arquivo. No nosso exemplo, o delimitador é o espaço;
  - O parâmetro `-f` é utilizado para indicar as colunas que queremos extrair. No nosso exemplo, as colunas extraídas foram 1 à 3 e da 6 até o final;
  - O conteúdo gerado foi redirecionado para `log_filtrado.txt`.

  ![Linux Terminal - Comando cut 2](Imagens/Linux%20Terminal%20-%20Comando%20cut%202.png)

## :one::five: Editores de Texto

- Os editores de texto via linha de comando Linux mais conhecidos são o `nano` e o `vi`.

- O `nano` é mais recente e possui a preferência dos usuários por conta de sua interface simples, muito similar a um editor de texto clássico como o bloco de notas.

- Para abrir um arquivo no nano:

  ```Bash
    nano <nome_arquivo>
  ```

  - Caso nenhum arquivo seja passado como parâmetro, será aberto um novo documento.

- Porém, pode ocorrer o caso de você estar utilizando uma máquina que não possui o nano e o seu usuário não possui privilégios suficientes para realizar uma instalação. Nesse caso, a alternativa é utilizar o Vi (nas distribuições mais recentes é chamado de VIM - *VI Improved*).
  - Os usuário possuem um certo pavor desse editor de texto pois ele não é tão intutivo quanto o nano.

- Para abrir um arquivo no vi:

  ```Bash
    vi <nome_arquivo>
  ```

  - Assim como no nano, caso nenhum arquivo seja passado como parâmetro, um novo documento será aberto.

- O VI de fato não é um editor de texto tão simples de se manipular se comparado ao Nano. Ele pode exemplo possui dois modos, um de inserção e outro de linha de comando. O primeiro modo é quando o usuário deseja editar o conteúdo do arquivo, enquanto o segundo é o modo para realizar operações, como salvar um arquivo, fechar o editor de texto, etc.

- Comandos básicos no VI:

  | Modo    | Comando                 | Descrição                                                                   |
  | :-----: | :---------------------: | :-------------------------------------------------------------------------: |
  | Edição  | `i`                     | Inserir conteúdo no arquivo.                                                |
  | Comando | `:`                     | Entrar em modo linha de comando.                                            |
  | -       | `Esc`                   | Alternar entre modo de linha de comando e edição.                           |
  | Comando | `:q`                    | Sair do editor de texto.                                                    |
  | Comando | `:x`                    | Salvar as alterações e sair do editor de texto.                             |
  | Comando | `:q!`                   | Sair do editor de texto sem salvar as alterações.                           |
  | Edição  | `r`                     | *Replace* - Alterar apenas o caractére selecionado.                         |
  | Comando | `:w <novo_nome>`        | Salvar o arquivo com um novo nome.                                          |
  | Edição  | `<qtd> dd`              | Recorta quantidade de linhas a partir daquela que o curso esta posicionado. |
  | Comando | `:<linha>`              | Posicionar o cursor em determinada linha do arquivo.                        |
  | Comando | `gg`                    | Posicionar o cursor na primeira linha do arquivo.                           |
  | Comando | `G`                     | Posicionar o cursor na última linha do arquivo.                             |
  | Comando | `/<conteudo>`           | Buscar por determinado conteúdo no arquivo (*Finder*).                      |
  | Edição  | `p`                     | Colar conteúdo abaixo da linha onde o cursor está posicionado.              |
  | Edição  | `P`                     | Colar conteúdo acima da linha onde o cursor está posicionado.               |
  | Edição  | `u`                     | *Undo* - Desfazer alteração realizada na linha.                             |
  | Edição  | `<qtd> yy`              | Copiar linhas a partir da linha selecionada.                                |
  | Edição  | `:s/<pattern>/<novo>/g` | Funcionalidade de *Find and Replace* - o `g` é de global.                   |

- No último comando, o `g` de global vale apenas para a linha. Para substituir todas as ocorrências daquele padrão do texto, independentemente da linha em que ele esteja, devemos fazer:

  ```Bash
    :%s/<pattern>/<novo>/g
  ```
