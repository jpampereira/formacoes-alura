# Shell Scripting

- Um script é um algoritmo projetado para realizar uma determinada tarefa, utilizando os comandos específicos do bash e os executáveis do sistema operacional.

- Utilizades:
  - Mesclar instruções de terminal com linguagem de programação;
  - Facilidade para executar os scripts;
  - Execução de comandos em lote.

- Shell Scripts possuem a extensão `.sh`;

- Ideia proposta: todos os projetos que desenvolvemos ao longo dos anos eram armazenados em um HD externo que infelizmente parou de funcionar, comprometendo todos seus arquivos. Por sorte possuímos todos os nosso projetos salvos no nosso GitHub, e desejamos baixá-los em nossa máquina pessoal. Porém, são muitos repositórios, e realizar a tarefa de cloná-los manualmente, um-a-um, pode ser trabalhosa, além de repetitiva. Afim de facilitar nosso trabalho, decidimos implementar um script para automatizar essa tarefa.

- O GitHub possui uma API (`https://api.github.com/users/<username>/repos`), que nos permite obter informações sobre nosso perfil, assim como de nossos repositórios. A partir desse endpoint, por exemplo, podemos coletar as URL SSH para clonarmos esses repositórios em nossa máquina.

- Podemos montar o seguinte script para clonar todos os nossos repositórios para nossa máquina pessoal:

    ```Shell Script
        #!/bin/bash

        mkdir meus-repositorios-git
        cd meus-repositorios-git

        $repositorios=$(curl -s https://api.github.com/users/jpampereira/repos | awk '/ssh_url/{print $2}' | sed 's/^"'//g | sed 's/",$//g')

        for $repositorio in $repositorios
        do
            git clone $repositorio
        done
    ```

  - Todo Shell Script inicia com a linha `#!/bin/bash` para chamar o interpretador do bash;
  - O comando `curl` (*Client Url*) permite executar requisições HTTP via linha de comando;
  - O comando `awk` permite executar um comando em cima de um determinado padrão de texto encontrado;
  - O comando `sed` permite realizar o replace de algum padrão identificado em um texto;
  - Quando desejamos guardar a resposta de um comando em uma variável, devemos colocar esse comando entre `$()`;
  - Variáveis podem ser identificadas pelo símbolo `$` que as precede.

- Para executar um script:

    ```Bash
        bash <nome_script>.sh
    ```
