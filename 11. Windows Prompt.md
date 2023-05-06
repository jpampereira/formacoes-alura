# Windows Prompt

## :one: Como acessar o Prompt de Comando

- Alternativa 1: Para acessar o Prompt de Comando do Windows podemos clicar no símbolo do Windows na nossa barra de tarefas ou na tecla Windows do teclado, digitar `cmd` no buscador e selecionar a opção **Prompt de Comando**.

- Alternativa 2: Selecionar a combinação de teclas `Windows + R` e digitar na janela que abrir `cmd`.

- Em ambos os casos será aberta a janela com a seguinte aparência:

  ![Prompt de Comando](Imagens/Prompt%20de%20Comando.png)

  - Na primeira linha podemos visualizar a versão do Prompt de Comando que está sendo utilizada;
  - Na segunda linha podemos visualizar a empresa detentora dos direitos da aplicação;
  - Na terceira linha observamos o cursor de digitação. As informações à esquerda do símbolo `>` indicam a pasta corrente no qual o Prompt de Comando se encontra.

- As pastas são separadas pelo `\`.

- Qualquer coisa que realizamos pela interface gráfica pode ser realizada pela linha de comando (talvez não com a mesma facilidade), como por exemplo, acessar uma determinada pasta, criar, ler, modificar, remover um arquivo txt, etc.

- O diretório `C:` é conhecido como diretório raiz.

## :two: Comandos Básicos

- Listar os arquivos presentes em uma pasta (se o parâmetro não for passado, serão listados os conteúdos da pasta corrente):

  ```BAT
    dir <caminho_da_pasta>
  ```

- Navegar de uma pasta para outra:

  ```BAT
    cd <caminho_da_pasta_destino>
  ```

- Navegar para o diretório hierarquicamente acima:

  ```BAT
    cd ..
  ```

- Limpar o Prompt de Comando:

  ```BAT
    cls
  ```

- Imprimir uma mensagem:

  ```BAT
    echo <mensagem>
  ```

## :three: Diretórios Importantes

- **Users:** Pastas dos usuários existentes no computador. Todo conteúdo existente dentro delas só é visível através da conta do usuário que estiver logado na máquina, como arquivos `.txt`, imagens, vídeos, downloads realizados, etc.

- **Program Files:** Armazena as pastas das aplicações 64 bits de terceiros instaladas na máquina.

- **Program Files (x86):** Armazena as pastas das aplicações 32 bits de terceiros instaladas na máquina.

- **Windows:** Armazena todos os arquivos que compõe o Sistema Operacional.

- O comando `tree` nos permite visualizar a estrutura de pastas do nosso SO no formato de árvore, a partir do ponto no qual o comando esteja sendo executado. Esse comando pode ser útil para entender a estrutura de um projeto:

  ![Comando tree](Imagens/Windows%20Prompt%20-%20Comando%20tree.png)

## :four: Manipulação de Arquivos

- Criação de uma pasta:

  ```BAT
    mkdir <caminho>\<nome_da_pasta>
  ```

- Imprimir o conteúdo de um arquivo:

  ```BAT
    type <caminho>\<nome_arquivo>
  ```

- Consultar a documentação de um comando:

  ```BAT
    help <nome_do_comando>
  ```

- Mover um arquivo:

  ```BAT
    move <caminho_origem>\<nome_arquivo> <caminho_destino>
  ```

- Imprimir o conteúdo de um arquivo de forma paginada (interessante para arquivos extensos, como logs de sistemas):

  ```BAT
    more <caminho>\<nome_arquivo>
  ```

- Copiar um arquivo:

  ```BAT
    copy <caminho>\<nome_arquivo> .<destino>\<novo_nome_arquivo>
  ```

- Renomear um arquivo:

  ```BAT
    rename <caminho>\<nome_atual> <novo_nome>
  ```

- Remover um arquivo:

  ```BAT
    del <caminho>\<nome_arquivo>
  ```

- Em comando como `move`, `copy` e `del`, é possível utilizar caractéres coringa para realizar a manipulação de mais de um arquivo de uma única vez.
  - Exemplo: Possuímos dois arquivos `softwares.bat` e `drivers.bat` que desejamos copiar para a pasta `backup-scripts`.

    - Alternativa 1:

      ```BAT
        copy softwares.bat backup-scripts
      ```

      ```BAT
        copy drivers.bat backup-scripts
      ```

    - Alternativa 2 (Utilizando caractéres coringa):

      ```BAT
        copy *.bat backup-scripts
      ```

- Comando para comparar dois arquivos e imprime as linhas diferentes:

  ```BAT
    fc <caminho>\<arquivo1> <caminho>\<arquivo2>
  ```

  - Exemplo:

    ![Comando fc](Imagens/Windows%20Prompt%20-%20Comando%20fc.png)

- Remover uma pasta:

  ```BAT
    rmdir <caminho>\<nome_pasta>
  ```

- Procura por uma sequência de caractéres em um arquivo:

  ```BAT
    find <string_procurada> <caminho>\<nome_arquivo>
  ```

  - Exemplo:

    ![Comando find](Imagens/Windows%20Prompt%20-%20Comando%20find.png)

## :five: Outros Comandos

- Trazer informações sobre a máquina, como SO instalado, número de processadores, tamanho da Memória RAM, etc.:

  ```BAT
    systeminfo
  ```

- Desligar a máquina:

  ```BAT
    shutdown
  ```

- Exibir a data/hora atual (permite alterá-las):

  ```BAT
    date
  ```

  ```BAT
    time
  ```

## :six: Criação de Scripts

- É muito comum no nosso dia-a-dia precisarmos executar, via Prompt, uma série de comandos pré-definidos para executar uma determinada tarefa. Para facilitar, podemos inserir esses comandos em um script e chamá-lo uma única vez que ele irá executá-los, um a um, na ordem que definirmos.

- Esses arquivos são conhecidos como **BAT** ou **.bat**, da palavra em inglês *Batch*, que significa **Lote**. Portanto, esses scripts BAT permitem a **execução de comandos em lote**.

- Para criarmos um arquivo BAT, podemos abrir nosso editor de arquivos de texto de preferência e ao final do processo, salvar o arquivo com a extensão `.bat`.
  - Dica: Se escrevermos `notepad` diretamente pelo Prompt, ele irá abrir um novo arquivo no Notepad do Windows. Se passarmos um arquivo já existente como parâmetro, o mesmo será aberto.

- Os códigos dos exemplos a seguir encontra-se na pasta [Windows Prompt](./Windows%20Prompt/).

### :arrow-right: Programa 1: Ola, Mundo

- Script:

  ```BAT
    echo Ola, Mundo!
  ```

- Execução:

  ![Executando arquivo BAT](Imagens/Executando%20arquivo%20BAT.png)

### :arrow-right: Programa 2: Mover arquivos de log para pasta de backup

- Script:

  ```BAT
    cls
    echo Executando o script...
    move *.log .\Backup
    pause
  ```

- Execução:

  ![Executando arquivo BAT 2](Imagens/Executando%20arquivo%20BAT%202.png)

- O comando `pause` trava a execução do script enquanto o usuário não interagir.

### :arrow-right: Programa 3: Compactação de arquivos

- Para compactarmos arquivos, utilizar o comando `tar`, que combinado com algumas *flags* nos permite definir qual tipo de tarefa desejamos executar:
  - Listar arquivos de uma pasta compactada:

    ```BAT
      tar -tf <nome_pasta_compactada>
    ```

  - Descompactar arquivos:

    ```BAT
      tar -xf <nome_pasta_compactada>
    ```

  - Compactar arquivos:

    ```BAT
      tar -cf <nome_pasta_compactada> [arquivos_para_compactar...]
    ```

- Script:

  ```BAT
    @echo off
    echo Compactando arquivos...
    tar -cf notas.zip *.xml
  ```

- Execução:

  ![Executando arquivo BAT 3](Imagens/Executando%20arquivo%20BAT%203.png)

### :arrow-right: Programa 4: Tratando erros

- É comum ocorrerem erros no script, como por exemplo, tentar compactar arquivos ou mover para uma pasta que não existem. Uma alternativa é tratar esses erros para que os seus scripts não parem de forma inesperada e o usuário fique sem entender nada.

- Para executar esse caso, foi utilizado o script do exemplo anterior, mas executando ele sem a existência de arquivos com a extensão `.xml` para compactar:

  ![Mensagem de erro no Windows Prompt](Imagens/Windows%20Prompt%20-%20Erros.png)

- Script:

  ```BAT
    @echo off
    echo Compactando arquivos...
    tar -cf notas.zip *.xml 2> erros.txt
    IF %ERRORLEVEL% NEQ 0 (echo "Erro na execucao do script") ELSE (echo "Arquivos compactados!")
  ```

- No exemplo acima, há a tentativa de se compactar os arquivos de extensão `.xml` e caso algum erro ocorra, a mensagem de erro é redirecionada para o arquivo `errros.txt` e a mensagem `Erro na execucao do script` é printada no Prompt de Comando. Caso a compactação seja realizada com sucesso, a mensagem `Arquivos compactados!` é impressa.

- `%ERRORLEVEL%` é uma variável interna do BAT que armazena códigos de erro na execução do programa. Caso seu valor seja diferente (`NEQ`, ou *Not Equal To*)de 0, significa que um erro foi detectado.

- O comando `@echo off` desabilita a impressão do comando que está sendo executado no terminal, tornando a saída mais limpa.
  - Sem `@echo off`:

    ![Comando sem @echo off](Imagens/Windows%20Prompt%20-%20Sem%20@echo%20off.png)

  - Com `@echo off`:

    ![Comando com @echo off](Imagens/Windows%20Prompt%20-%20Com%20@echo%20off.png)

## :seven: Variáveis

- As variáveis permite o armazenamento de informações que podem ser utilizadas ao longo da execução do script e auxiliar no seu funcionamento.

- Para criar uma variável:

  ```BAT
    set <nome_variavel>=<valor>
  ```

- Imprimir o valor de uma variável:

  ```BAT
    echo %<nome_variavel>%
  ```

- Nomes de variáveis são **case insensitive**.

- A variável existe apenas dentro daquele Prompt, caso um novo seja aberto, a mesma não existirá.

### :arrow-right: Programa 5: Inserindo nome e -mail

- Script utilizando variáveis:

  ```BAT
    @echo off
    rem Limpando a tela
    cls
    set /p nome=Digite seu nome=
    set /p email=Digite seu e-mail=
    pause
    echo Seu nome eh %nome% e seu e-mail %email%
  ```

  - O comando `rem` permite inserirmos comentários no script.
  - O parâmetro `/p` permite que o usuário interaja com o script e informe o valor que deve ser armazenado na variável.

- Execução do script:

  ![Windows Prompt - BAT com Variáveis](Imagens/Windows%20Prompt%20-%20Vari%C3%A1veis.png)

### :arrow-right: Variáveis de Ambiente

- Todos os comandos que executamos via Prompt, como `cd`, `dir`, etc., na verdade são scripts. A diferença entre eles e nossos scripts é que no caso deles nós não precisamos passar o caminho desses arquivos para executá-los.

- Essa característica se deve ao fato deles estarem salvos no *Path*. Valores salvos no *path* são conhecidos como **variáveis de ambiente**.
  - As variáveis de ambiente armazenam informações extremante relevantes para a máquina, de forma persistente, isto é, se fecharmos o Prompt, a mesma permanecerá existindo.

- Exemplo de variável de ambiente: Quando desejamos executar um script `.js` via Prompt, utilizamos o comando `node`. Esse comando nada mais é uma variável de ambiente que armazena o caminho para o executável do interpretador do Node.Js, armazenado em `C:\Program Files\nodejs`.

- Podemos visualizá-las e editá-las via interface gráfica (digitar "variaveis de ambiente" no buscador):

  ![Variáveis de Ambiente - GUI](Imagens/Vari%C3%A1veis%20de%20Ambiente%20-%20GUI.png)

  - As **variáveis de usuário** são visíveis apenas para o usuário em questão;
  - As **variáveis do sistema** são visíveis para qualquer usuário daquela máquina.

- Uma boa prática é armazenar nossos executáveis, que serão colocados como variáveis de ambiente, em uma pasta `bin`.

- Para inserir uma variável em *Path*:

  ```BAT
    setx path "%path%;<caminho>" /M
  ```

  - Para executar esse comando, o usuário deve estar logado no **modo administrativo**;
  - O parâmetro `/M` indica que queremos inserir aquela variável no Path das variáveis do sistema.
  - **Tomar cuidado** quando for inserir uma noma variável de ambiente para não sobrescrever as já existentes, por isso devemos passar `%path%;` antes de `<caminho>`;
  - A nova variável de ambiente valerá para os próximos Prompts, mas não será possível visualizá-la no atual.

- Para visualizarmos todas as variáveis de ambiente:

  ```BAT
    set
  ```

## :eight: Gerenciadores de Pacotes

- Gerenciadores de Pacotes são uma ferramenta muito utilizada também em outros Sistemas Operacionais, como Linux e Mac, que permitem o usuário realizar a instalação, atualização e remoção de aplicações diretamente da linha de comando.

### :arrow-right: Winget

- No caso do Windows, a ferramenta padrão é o **Winget**.

- Para verificar se o computador possui o Winget e qual sua versão:

  ```BAT
    winget -v
  ```

- Para buscar um determinado pacote:

  ```BAT
    winget search <nome_pacote>
  ```

- Para instalar um pacote:

  ```BAT
    winget install -e --id <id_pacote>
  ```

  - A flag `-e` indica que desejamos instalar a correspondência exata ao `--id` que iremos passar.

- É possível exportar e importar ambientes de desenvolvimento utilizando os comandos `import` e `export`. No caso do primeiro, ele recebe um arquivo JSON especificando as ferramentas que devem ser instaladas no ambiente, enquanto o segundo cria esse JSON para ser utilizado em outra máquina.

- Para desinstalar um pacote:

  ```BAT
    winget uninstall <nome_pacote>
  ```

- Pedir ajuda:

  ```BAT
    winget --help
  ```

### :arrow-right: Chocolatey

- Um problema é que o Winget está disponível apenas a partir da versão do Windows 10. Para versões anteriores, será necessário utilizar outras ferramentas, e uma das opções é o **Chocolatey**.
  - Por padrão, o Chocolatey não vendo instalado, sendo necessário acessar [chocolatey.org](chocolatey.org) e seguir todos os passos para fazer sua instalação.

- Para instalar um pacote:

  ```BAT
    choco install <nome_pacote>
  ```

  ou

  ```BAT
    chocolatey install <nome_pacote>
  ```

- Para buscar por um pacote no repositório do Chocolatey:

  ```BAT
    choco list <nome_pacote>
  ```

  ou

  ```BAT
    choco search <nome_pacote>
  ```

- Para listar os pacotes instalados localmente:

  ```BAT
    choco list -l
  ```

- Para desinstalar um pacote:

  ```BAT
    choco uninstall <nome_pacote>
  ```

- Pedir ajuda:

  ```BAT
    choco --help
  ```

## :nine: Outras ferramentas de terminal

- Caso desejemos utilizar outra ferramenta para realizar operações via linha de comando, podemos utilizar as seguintes:
  - **Windows PowerShell:** ferramente mais avançada do que o CMD;
  - **cmder:** Ferramenta de uma empresa terceira mas que possui ótima compatibilidade com sistemas Windows (instalação via Winget: `winget install cmder`);
  - **Windows Terminal:** Ferramenta que permite a emulação de diversos terminais, como CMD, PowerShell, Ubuntu, etc., como podemos ver na imagem abaixo (instalação via Microsoft Store ou Winget: `winget install -e --id Microsoft.WindowsTerminal`).

    ![Windows Terminal](Imagens/Windows%20Terminal.png)
