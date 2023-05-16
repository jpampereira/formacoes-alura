# Feature Flags ou Feature Toggles

## :one: Deploy e Release

- É importante entendermos a diferença entre as palavras **Deploy** e **Release**. A primeira é a tarefa de inserir o código desenvolvido em ambiente produtivo, enquanto a segunda é a publicação, isto é, disponibilizar esse deploy para o usuário.
  - É possível que sejam inseridos diversos deploys ao longo de uma semana e ao final dela é realizado o release de todas as modificações realizadas;
  - Ou seja, é possível inserir código/funcionalidades em ambiente produtivo e ainda sim não disponibilizá-los para os clientes em um primeiro momento.

## :two: Feature Flags ou Feature Toggles

- **Feature Flags** ou **Feature Toggles** (em português, alternância de recursos) é uma técnica para minimizar possíveis impactos técnicos e de negócio da sua aplicação.

- Se disponilizarmos em ambiente produtivo uma funcionalidade (isto é, realizar o deploy) localizada em um ponto crítico da nossa aplicação ou que mexeu com várias partes do código, uma das alternativas para minimizar seu impacto no sistema como todo é utlizar Feature Flags.

- A ideia consiste na inserção de uma condicional que determine se a funcionalidade deva estar disponível para o usuário final ou não.

- No dia a dia podemos perceber casos onde Feature Flags são utilizadas:
  - Beta testers geralmente possuem Feature Flags habilitadas;
  - Você já se encontrou em uma situação onde você e seu amigo possuem o mesmo aplicativo no celular, porém, ele possui uma determinada funcionalidade e você não? Provavelmente a Feature Flag para ele está habilitada.

- Essa condicional pode variar, desde um botão de liga/desliga até a funcionalidade ser disponibilizada apenas para usuários cujo ID é par ou que possuam determinado perfil (Dev, Admin, etc.).
  - Nesse momento, o deploy da funcionalidade já foi realizado, porém, a release apenas para alguns usuários.

- Essa técnica permite a inserção de uma nova funcionalidade de forma gradual no sistema, sendo mais seguro, pois caso haja algum problema, ele atingirá uma pequena gama de usuário, causando menos problemas. Caso seja identificado que a funcionalidade encontra-se em perfeito funcionamento, o número de releases é incrementado até que todos os usuários a possuam.

## :three: Parallel Change

- Também conhecido como padrão *Expand, migrate and contract*.

- Pense no caso onde você possui um método que recebe dois números inteiros como coordenadas, mas deseja melhorar essa função passando apenas um único valor, um objeto do tipo Coordenada, onde todas as validações sob esses valores é realizada, segregando as responsabilidades das entidades.
  - Porém, para evitar a quebra do código que já está funcionando, você inicialmente decide criar uma novo método e manter as duas versões ativas. A partir desse ponto, toda nova funcionalidade será desenvolvida utilizando a nova versão. Essa é a etapa de **Expand**;
  - Na etapa de **Migrate**, as funcionalidade existentes previamente vão sendo atualizadas para utilizar a nova versão do método;
  - Assim que todo o código é migrado para o novo método, a etapa de **Contract** consiste em remover a versão anterior do código.

- Vantagens:
  - Código já existente não quebra;
  - Melhor API será criada e pode ser utilizada;
  - Migração pode ser incremental.

- Podemos realizar Release utilizando esse conceito de Parallel Change, conhecido como **Blue-Green Deployment**.

  ![Blue-Green Deployment](Imagens/Blue-Green%20Deployment.png)

  - Na versão 1 do código temos a versão atual executando em produção, enquanto na versão 2 possuímos a nova funcionalidade e utilizamos um *Load Balancer* para redirecionar as requisições para a nova versão. Caso uma inconsistência seja detectada, é necessário apenas redirecionar as requisições para a versão 1;
  - Podemos unir os conceitos de Feature Flags e Parallel Changes, como por exemplo, determinando que apenas umas porcentagem de requisições deve ir para a versão 2 enquanto as demais vão para a versão corrente e ir aumentando essa proporção gradativamente, até que a release esteja disponível para todos os usuários.
