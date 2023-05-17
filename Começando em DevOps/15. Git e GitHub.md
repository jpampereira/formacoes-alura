# Git e GitHub

- Git e GitHub são ferramentas de **versionamento de código**, que tornam-se necessárias quando estamos trabalhando em projetos de desenvolvimento de sistemas em equipe, permitindo a centralização das alterações realizadas ao longo do tempo, trazendo organização e rastreabilidade dessas tarefas, além de deixar os membros da equipe sempre atualizados de todas as mudanças ocorridas.

- Os projetos são organizados em **repositórios**, que nada mais são do que diretórios que armazenam todos os conteúdos relacionados ao projeto em questão.
  - Esses repositórios podem ser públicos ou privados. No primeiro caso, todos os usuários podem visualizar o projeto, replicá-lo e sugerir alterações. Caso ele seja configurado como privado, apenas seu *owner* terá acesso, sendo possível adicionar colaboradores, permitindo que eles também acessem e realizem commits no projeto.

- Quando desejamos salvar as alterações realizadas no projeto, realizamos um **commit**, que seria equivalente a estabelecer uma nova versão.

- Um arquivo muito comum em repositórios de projetos é o `README.md`. Esse arquivo escrito em **Markdown** funciona como primeira documentação do projeto e traz informações relevantes sobre o mesmo, como finalidade, como executá-lo, significados dos seus arquivos, etc.
  - Markdown é uma linguagem de marcação, assim como o HTML;
  - Artigo [Como escrever um README incrível no seu Github](https://www.alura.com.br/artigos/escrever-bom-readme).

## :one: GitHub

- O **GitHub** é uma ferramenta que realiza o versionamento de código em nuvem, portanto, seu acesso se dá via Browser Web.
  - Existem concorrentes, como por exenplo, o GitLab;
  - Acessar [github.com](github.com) e criar um usuário gratuitamente;
  - É possível criar repositórios, configurá-los como públicos ou privados, criar e editar seus arquivos diretamente do site e ainda adicionar colaboradores para o projeto;
  - Uma alternativa é, dentro do seu repositório, pressionar a tecla `.` (ponto), que o usuário será redirecionado para uma versão Web do Visual Studio Code, trazendo uma interface mais amigável ao programador para editar seus arquivos. Essa versão do VS Code possui algumas limitações se comparada a versão Desktop, como por exemplo, não possui acesso ao terminal para executar seus códigos.

    ![Meu repositório GitHub](Imagens/Meu%20repositório%20GitHub.png)

## :two: Git

- Para realizar o versionamento localmente, precisamos instalar o **Git**.
  - Criado por Linus Torvalds, também criador do Linux;
  - O GitHub nada mais é do que uma plataforma que permite executar uma aplicação de Git em Nuvem e com acesso a interface gráfica.

- O Git é um sistema de controle de versão distribuído, isto é, é possível acessar o mesmo projeto de diferentes máquinas e as versões serão as mesmas.

- Podemos clonar um repositório do GitHub (ou variados):

  ```Git
    git clone <url-repositorio> <diretorio-destino>
  ```

  - Para obter a URL:

    ![Clonar repositório GitHub](Imagens/GitHub%20-%20Clonar%20repositório.png)

  - Caso `<diretorio-destino>` seja omitido, o repositório será clonado para o diretório de trabalho corrente;
  - O parâmetro `-branch <nome-branch>` permite clonarmos uma determinada **branch** do repositório.

- Podemos visualizar o histórico de commits realizados:

  ```Git
    git log
  ```

  - O parâmetro `--oneline` traz uma versão resumida do histórico;
  - O parâmetro `-p` traz uma versão mais completa do histórico;
  - O parâmetro `--author="username"` permite buscar apenas pelos commits de determinado usuário;
  - Os parâmetros `--since` e `--until` permitem buscar por commits realizados em um determinado período. Exemplo buscando por commits entre um mês atrás e um dia atrás:

    ```Git
      git log --since=1.month.ago --until=1.day.ago
    ```

  - É retornado uma hash, utilizada pelo Git como identificador único daquela versão e a descrição do commit.

- Pode ser que depois de ter clonado o repositório para a sua máquina pessoal, novas alterações tenham sido realizadas no projeto. Para alinhar seu repositório local com o repositório em nuvem:

  ```Git
    git pull <url-repositorio>
  ```

- Para visualizar os arquivos e diretórios que possuem mudanças em relação ao último commit:

  ```Git
    git add [<arquivo>...]
  ```

- Para realizar um commit:

  ```Git
    git commit -m "<descricao-do-commit>"
  ```

- Porém, o commit realizado localmente ainda não é refletido no repositório armazenado em nuvem. Nesse caso, precisamos "empurrá-lo" para o GitHub:

  ```Git
    git push <url-repositorio> <branch>
  ```

  - Para enviar um commit:
    1. Ser colaborador do repositório em questão;
    2. Git local estar configurado com o GitHub.

- Para restaurar um commit anterior:

  ```Git
    git restore --source <id-commit> [<arquivo>...]
  ```

  - O `<id-commit>` é a hash retornada pelo comando `git log`.

## :three: Branches e Merge

- Em um projeto é comum termos a versão do código em produção, isto é, que está funcionando e sendo utilizado pelos usuário. E outra, utilizada pelos desenvolvedores na criação de novas funcionalidades e correção de bugs. Essas diferentes versões são chamadas de **branches**.

- Não é recomendado que um commit seja realizado diretamente na branch principal, chamada de `master` ou `main`. O ideal é que os commits sejam realizados em uma branch intermediária, por exemplo `dev` ou `hml`, e assim que uma nova funcionalidade for finalizado por completo, testada e validada, assim que definido que ela deve ser disponibilizada para os usuário finais, um **merge** (isto é, uma união) será realizado entre a branch intermediário e a principal.

- Para criar uma nova branch:

  ```Git
    git checkout -b <nome-branch>
  ```

- Para alternar entre branches:

  ```Git
    git switch <nome-branch>
  ```

- Listar todas as branches:

  ```Git
    git branch
  ```
  
  - A branch marcada com `*` é aquela que o usuário está trabalhando no momento.

- Para unir duas branches, primeiramente deve-se alternar para a branch no qual desejamos inserir as informações e em seguida inserir o seguinte comando:

  ```Git
    git merge <branch>
  ```

  - Exemplo: Realizamos alterações na branch `dev` e desejamos realizar o merge com a branch `master`.
    1. Alternar para a branch `master`:

        ```Git
          git switch master
        ```

    2. Realizar o merge da `master` com `dev`:

        ```Git
          git merge dev
        ```

    3. Não é necessário realizar o commit, apenas um `push` para enviar essa versão *mergeada* para o versionador remoto.
