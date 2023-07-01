# Kubernetes na Digital Ocean: gerenciando aplicações conteinerizadas

- A DigitalOcean é uma *Cloud Provider*, assim como a Google Cloud Platform, AWS, Azure, etc.

## :one: Criação do Cluster

- Para criação de nosso primeiro Cluster, devemos acessar a sessão destinada a aplicações baseadas em Kubernetes, através da barra de opções azul no canto esquerdo da página, clicando em **Kubernetes**:

  ![Criação do Cluster - Parte 1](Imagens/Digital%20Ocean%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%201.png)

- Em seguida, clicar em **Create Kubernetes Cluster**:

  ![Criação do Cluster - Parte 2](Imagens/Digital%20Ocean%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%202.png)

- Na página seguinte é necessário determinar as configurações do Cluster, como a região da máquina onde o mesmo ficará alocado (é interessante realizar um estudo de qual região é mais benéfica a alocação do Cluster através do teste de latência), a versão do Kubernetes que será utilizada, a quantidade de recurso computacional que será alocado, o número de Nodes, etc.:

  ![Criação do Cluster - Parte 3](Imagens/Digital%20Ocean%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%203.png)

- Ao clicar em **Create** no final da página anterior, o Cluster começará a ser criado e podemos acompanhar o status através da barra de progresso destacada na imagem abaixo:

  ![Criação do Cluster - Parte 4](Imagens/Digital%20Ocean%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%204.png)

- Assim que o Cluster estiver criado, é possível visualizar em **Overview** relacionadas a ele como suas configurações atuais, o total do custo mensal, o status dos Nodes, etc.:

  ![Visão do Cluster - Parte 1](Imagens/Digital%20Ocean%20-%20Vis%C3%A3o%20Cluster%20-%20Parte%201.png)

- Em **Resources** podemos verificar o status dos recursos criados dentro do Cluster, como os Nodes:

  ![Visão do Cluster - Parte 2](Imagens/Digital%20Ocean%20-%20Vis%C3%A3o%20Cluster%20-%20Parte%202.png)

## :two: Configurando o Client

- Devemos instalar as ferramentas `kubectl` e `doctl`, para manipular o Kubernetes e a plataforma da Digital Ocean através da linha de comando, respectivamente.

- Após a instalação das ferramentas, é necessário conectar o `doctl` com a nossa conta da Digital Ocean. Para isso, acessar **API** disponível na barra de opções azul à esquerda e clicar em **Generate New Token** para criar um novo token de acesso:

  ![API](Imagens/Digital%20Ocean%20-%20Configurando%20doctl.png)

- No terminal, executar o seguinte comando e quando solicitado inserir o Token criado. A partir de então o client estará vinculado a conta da Digital Ocean:

  ```PowerShell
    doctl auth init
  ```

- Para vincular o `kubectl` ao Cluster alocado na plataforma da Digital Ocean, é necessário baixar suas configurações na máquina do Client:

  ```PowerShell
    doctl kubernetes cluster kubeconfig save <nome-cluster>
  ```

  - Nesse momento as informações relacionadas ao Cluster em questão serão salvas em um arquivo de configurações no diretório `.kube`.

- A partir de então é possível executar os comandos já conhecidos do Kuberenetes, através dp `kubectl` e eles estarão refletindo o Cluster alocado na Digital Ocean e não mais o Cluster local.

- Para listar os Clusters:

  ```PowerShell
    doctl kubernetes cluster list
  ```

- Para listar o pool de Nodes do Cluster:

  ```PowerShell
    doctl kubernetes cluster node-pool list <nome-cluster>
  ```

## :three: 1-Click Apps

- A Digital Ocean oferece aplicações prontas que podem ser instaladas com apenas um único clique. Para utilizá-las é necessário acessar o **Marketplace** através da barra de opções azul à esquerda:

  ![1-Click Apps - Parte 1](Imagens/Digital%20Ocean%20-%201-Click%20Apps%20-%20Parte%201.png)

- Uma vez acessado o Marketplace, selecionar a categoria **Kubernetes**, à esquerda:

  ![1-Click Apps - Parte 2](Imagens/Digital%20Ocean%20-%201-Click%20Apps%20-%20Parte%202.png)

- No nosso exemplo, vamos selecionar uma aplicação de blog/fórum utilizando WordPress. Ela instála um HELM Chart que contém o front-end do WordPress e também um banco de dados MariaDB onde as postagens serão salvas. Basta clicar em **Install App**:

  ![1-Click Apps - Parte 3](Imagens/Digital%20Ocean%20-%201-Click%20Apps%20-%20Parte%203.png)

  - Clicando em **See details** podemos visualizar informações sobre a aplicação em questão. No exemplo do WordPress ele possui uma sessão **Getting started after deploying WordPress Kubernetes** que entre outra coisas, te ensina como obter o usuário e senha admin;
  - O HELM Chart já possui também as configurações de Services e Volumes que também são instalados na criação da aplicação.

- Selecionar o Cluster onde a aplicação será instalada:

  ![1-Click Apps - Parte 4](Imagens/Digital%20Ocean%20-%201-Click%20Apps%20-%20Parte%204.png)

- Na página do Cluster é possível visualizar as aplicações instaladas na aba **Marketplace**:

  ![1-Click Apps - Parte 5](Imagens/Digital%20Ocean%20-%201-Click%20Apps%20-%20Parte%205.png)

- No caso da aplicação em WordPress utilizada com exemplo, ela é instalada no namespace `wordpress`.

## :four: Monitoração do Cluster

- Na página do Cluster, podemos verificar métricas de usabilidade dos seus recursos (CPU, Memória, Disco, etc.), através da aba **Insights**:

  ![Monitoração do Cluster](Imagens/Digital%20Ocean%20-%20Monitora%C3%A7%C3%A3o%20do%20Cluster.png)

- Para visualizar essas métricas através da linha de comando, é necessário a instalação de um servidor de métricas, já disponível no Marketplace da Digital Ocean e que pode ser instalado com apenas um clique:

  ![Servidor de Métricas](Imagens/Digital%20Ocean%20-%20Servidor%20de%20M%C3%A9tricas.png)

- É possível visualizar, via linha de comando, métricas de Nodes e Pods:

  ```PowerShell
    kubectl top nodes
  ```

  ```PowerShell
    kubectl top pods
  ```

- Enquanto pela linha de comando é possível visualizar apenas os valores atuais, através da interface da Digital Ocean é possível visualizar o histórico de até os últimos 14 dias.
