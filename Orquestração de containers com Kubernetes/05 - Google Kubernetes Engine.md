# Google Kubernetes Engine (GKE)

- O Google Kubernetes Engine é um serviço fornecido pela Google Cloud Plataform, que permite implantar e operar aplicativos baseados em containers em escala, utilizando a infraestrutura da provedora e gerenciá-los através do Kubernetes.

- Para a realização do curso é necessária a criação de uma conta na Google Cloud Plataform. Caso seja um novo cadastro, a plataforma oferece por tempo limitado uma quantidade de créditos para uso.
  - A plataforma também oferece uma série de serviços de forma gratuíta com limites de consumo. Caso esses sejam ultrapassados, cobranças no cartão de crédito cadastrado na criação da conta podem ser realizadas.

- É necessária a criação de um projeto e ativação das APIs que serão utilizadas no mesmo.

- A plataforma permite manipulação via linha de comando, como os terminais em sistemas operacionais, através do **Cloud Shell**, além de um editor de arquivos, similar ao Visual Studio Code.

## :one: Google Container Registry API

![Google Container Registry API](Imagens/Google%20Container%20Registry%20API.png)

- Um dos serviços oferecidos pela plataforma é a criação de um Container Registry para armazenar as imagens que serão utilizadas para criar nossos containers, similar ao Docker Hub.

- Após criar a imagem, é necessário inserir a seguinte Tag:

  ```Docker
      docker image tag <nome-imagem> gcr.io/<id-projeto>/<nome imagem>
  ```

  - É necessário inserir o id do projeto na tag das imagens, caso contrário, o Registry não será capaz de associá-las ao mesmo e não será possível acessá-las quando necessário.

  - Para descobrir o identificador do projeto:

    ```Google Cloud
        gcloud projects list
    ```

- Para enviar a imagem criada para o Registry:

    ```Docker
        docker image push gcr.io/<nome-projeto>/<nome-imagem>
    ```

- Na página do Registry, é possível visualizar todas as imagens armazenadas e até mesmo instanciá-las se desejado.

- O Container Registry será descontinuado e substituído pelo **Artifact Registry**.

## :two: Kubernetes Engine API

![Kubernetes Engine API](Imagens/Kubernetes%20Engine%20API.png)

- Esse serviço permite o gerenciamento de containers utilizando uma implementação do orquestrador Kubernetes na Google Cloud Plataform.

### :arrow_right: Tipos de Cluster

![Cluster](Imagens/Cluster.png)

- Relembrando: Um **Cluster** é formado por **Nodes**, que podem ser de dois tipos: os **Master**, responsáveis por coordenar os denominados **Slaves**, que armazenam os **Pods** das nossas aplicações. Esses Nodes podem ser tanto máquinas físicas quanto virtuais ou até mesmo poder computacional (é possível reservar uma ou mais CPUs para um único Node).

- Os recursos da Google Cloud Plataform são distribuídos entre regiões e zonas, permitindo a redundância das aplicações hospedadas no serviço. As regiões representam localizações geográficas, como por exemplo, Costa Oeste dos Estados Unidos e dentro dessas existem as zonas.
  - É importante saber que existem dois tipos de Cluster: regionais e zonais.
  - Os **Clusters Regionais** disponibilizam o plano de controle (ou nó Master) e os nós que contém nossas aplicações em diferentes zonas da mesma região, gerando uma redundância. Caso uma das zonas pare de funcionar, as demais suprirão a ausência até que a mesma seja reestabelecida, sendo transparente para o usuário.
  - Os **Clusters Zonais** podem ser formados por uma ou mais zonas de uma mesma região. A diferença nesse caso é que o plano de controle estará disponível em apenas uma delas. Caso a mesma sofra algum problema, nossa aplicação ficará indisponível;
  - É recomendado o uso de Clusters Regionais para aplicações em ambiente produtivo.

### :arrow_right: Criando um Cluster

- Para criar um Cluster, é necessário definir se ele será criado no modo **Standard** (Padrão) ou **Autopilot** (Piloto Automático). Em ambos os casos é necessário definir a região e zona das máquinas virtuais que armazenarão os Nodes serão alocadas, além de configurações de rede.

- No modo Padrão, é necessário definir uma série de configurações do Cluster, como o número de Nodes (é possível limitar o número máximo de Pods por Node), o tipo das máquinas virtuais e a quantidade de recurso computacional que será alocado para elas. No modo Piloto Automático, o próprio serviço trata de alocar os recursos para a aplicação conforme necessidade.

- No modo Padrão o custo é calculado por Node, enquanto no Automático é por Pod.
  - Quando criamos um novo recurso em um AutoPilot, uma mensagem de *warning* aparece informando que os recursos computacionais do Cluster foram incrementados para atender as necessidades da aplicação criada.

- No exemplo apresentado abaixo, foi criado um Cluster com três Nodes (valor padrão) e podemos visualizar em **Nós** que de fato são alocadas três máquinas virtuais:

  ![Cluster - Google Kubernetes Engine](Imagens/Cluster%20-%20Google%20Kubernetes%20Engine.png)

  - Se acessarmos o serviço **Compute Engine**, onde são listadas todas as máquinas virtuais do projeto, é possível visualizá-las também. Porém, se o Cluster for criado no Piloto Automático, essas máquinas virtuais não ficam visíveis para o usuário.

- O próprio Google Cloud Plataform fornece uma calculadora que possibilita o usuário simular os diferentes cenários de configuração do Cluster, e visualizar as estimativas de gasto que o mesmo teria.

- Podemos criar o Cluster pela linha de comando:

  ```Google Cloud
    gcloud container clusters create-auto <nome-cluster> --region <regiao>
  ```

  - Nesse caso, o atributo `create` significa que o Cluster será criado no AutoPilot.
  - Exemplo:

    ![GKE - Criando Cluster pela linha de comando](Imagens/GKE%20-%20Criando%20Cluster%20pela%20Linha%20de%20Comando.png)

### :arrow_right: Criando Pods

#### :arrow_right::arrow_right: Interface Gráfica

- Para criar um Pod via interface gráfica, é necessário acessar a página da Google Container Registry API, selecionar a imagem e a versão que desejamos instanciar, clicar em **Implantar** e na opção **Implantar no GKE**:

  ![GKE - Criando Pod via Interface Gráfica - Parte 1](Imagens/GKE%20-%20Criando%20Pod%20-%20Parte%201.png)

- Selecionar a partir imagem que deseja instanciar (Nesse caso, como a opção de implantar foi executada já de dentro da imagem, por padrão ela será selecionada) e variáveis de ambiente, caso necessário:

  ![GKE - Criando Pod via Interface Gráfica - Parte 2](Imagens/GKE%20-%20Criando%20Pod%20-%20Parte%202.png)

- Definir o nome do Pod, seu namespace e em que Cluster ele será criado:

  ![GKE - Criando Pod via Interface Gráfica - Parte 3](Imagens/GKE%20-%20Criando%20Pod%20-%20Parte%203.png)

- Criar o Service que irá expor o Pod, definindo a porta exposta, a de destino, o protocolo utilizado e o tipo do Service:

  ![GKE - Criando Pod via Interface Gráfica - Parte 4](Imagens/GKE%20-%20Criando%20Pod%20-%20Parte%204.png)

- Por fim, clicar em **Implantar** e esperar que o GKE crie o Pod conforme configurado.

#### :arrow_right::arrow_right: Linha de Comando

- O processo para criação de Pods via linha de comando é o mesmo já visto nos cursos introdutórios de Kubernetes. A única diferença é que eles serão criados no Cluster alocado na nuvem e não localmente.

- É possível fazer isso diretamente pelo terminal da máquina local ou pelo Cloud Shell, vai depender de onde os arquivos de configuração estiverem alocados.

- Caso o processo seja realizado via máquina host, é necessário primeiramente instalar o *client* do Google Cloud Plataform e em seguida realizar a autenticação:

  - Solicitar login:

    ```Google Cloud
      gcloud auth login
    ```

  - Nesse momento o browser será aberto e a janela direcionada para a página de autenticação do Google Cloud Platform. Após a autenticação, um código será disponibilizado e o mesmo deve ser inserido no terminal quando solicitado. A partir desse momento, você estará conectado ao provedor através do client do seu terminal.

  - Alterar o projeto corrente:

    ```Google Cloud
      gcloud config set project <id-projeto>
    ```

- Independente de onde o processo esteja sendo realizado, é necessário baixar as credenciais do cluster onde o Pod será criado, permitindo manipulá-lo via linha de comando. É possível obter o exato comando que deve ser realizado acessando a página do Google Kubernetes Engine, selecionando o Cluster onde deseja alocar o Pod e clicando em **Conectar**.

  ![GKE - Conexão ao Cluster](Imagens/GKE%20-%20Conex%C3%A3o%20ao%20Cluster.png)

- Após inserir o comando obtido no terminal e executá-lo, será possível manipular o Cluster a partir do terminal utilizando os comandos do `kubectl` já conhecidos.

### :arrow_right: Alocação de Pods em Nodes

![Scheduler](Imagens/Scheduler.png)

- Relembrando: O **Node Master** é responsável por alocar os **Pods** nos Nodes do **Cluster** através do **Scheduler**.

- Na imagem abaixo vemos um Deployment com 3 réplicas, onde cada um dos Pods é armazenada em um Node diferente, garantindo a redundância da aplicação:

  ![Alocação de Pods em Nodes](Imagens/GKE%20-%20Aloca%C3%A7%C3%A3o%20de%20Pods%20nos%20Nodes.png)

### :arrow_right: Manipulando Deployments

- Na imagem abaixo podemos visualizar o comando `kubectl get nodes` sendo executado diretamente no terminal da máquina local e exibindo os três Nodes do Cluster criado na nuvem.

  ![GKE - Listar Nodes do Cluster](Imagens/GKE%20-%20Listar%20Nodes%20do%20Cluster.png)

- Na seção "Cargas de Trabalho", dentro do GKE, podemos visualizar nossos Pods existentes no Cluster:

  ![GKE - Cargas de Trabalho](Imagens/GKE%20-%20Cargas%20de%20Trabalho.png)

- Se entrarmos na página destinada ao nosso Deployment, podemos visualizar diversas informações sobre ele, como os Pods que o compõe:

  ![GKE - Informações do Deployment](Imagens/GKE%20-%20Informa%C3%A7%C3%B5es%20do%20Deployment.png)

### :arrow_right: Criando Service

- No exemplo apresentado, o Pod foi criado sem expô-lo através de um serviço. É possível fazer isso através da interface do GKE:

  ![GKE - Criando Serviço - Parte 1](Imagens/GKE%20-%20Criando%20Servi%C3%A7o%20-%20Parte%201.png)

- Na sequência é necessário indicar a porta exposta e a porta de destino, além do tipo do Service (**ClusterIP**, **NodePort** ou **Load Balancer**) e clicar em **Expor**:

  ![GKE - Criando Serviço - Parte 2](Imagens/GKE%20-%20Criando%20Servi%C3%A7o%20-%20Parte%202.png)

- Outra opção é clicar em **Ver YAML** e selecionar o conteúdo, inserí-lo em um arquivo `.yaml` e criar o Service do modo convencional através da linha de comando utilizando o comando `kubectl apply -f <nome-arquivo>.yaml`:

  ![GKE - Criando Serviço - Parte 3](Imagens/GKE%20-%20Criando%20Servi%C3%A7o%20-%20Parte%203.png)

- Na seção **Serviços e entradas** podemos visualizar todos os Services criados no nosso Cluster e em **Pontos de extremidade** o endpoint para acessarmos nossa aplicação:

  ![GKE - Services](Imagens/GKE%20-%20Services.png)

### :arrow_right: Visualizando Eventos

- Para visualizar eventos que ocorreram dentro de um Pod executamos o seguinte comando:

  ```Google Cloud
    kubectl describe pod <nome-pod>
  ```

- Porém, podemos visualizar essas mesmas informações acessando o Pod, via interface Gráfica do GKE, e indo na aba **Eventos**:

  ![GKE - Pod Events](Imagens/GKE%20-%20Pod%20Events.png)

- O mesmo serve para outras funcionalidades, como Deployments e Services.

- É possível visualizar todos os eventos do Cluster de uma só vez:

  ```Google Cloud
    kubectl get events
  ```

### :arrow_right: Visualizando Logs

- Para visualizar os logs de um Pod, executamos o seguinte comando:

  ```Google Cloud
    kubectl logs pod/<nome-pod>
  ```

- Porém, podemos visualizar essas mesmas informações acessando o Pod, via interface Gráfica do GKE, e indo na aba **Registros**:

  ![GKE - Pod Logs](Imagens/GKE%20-%20Pod%20Logs.png)

## :three: Projeto Livro de Visitas

![Diagrama Projeto Livro de Visitas](Imagens/GKE%20-%20Projeto%20Livro%20de%20Visitas.png)

- [Clique aqui](https://github.com/GoogleCloudPlatform/kubernetes-engine-samples) para acessar o GitHub da Google Cloud Platform e obter acesso a diversos projetos Kubernetes de exemplo. O projeto de livro de visitas encontra-se no diretório `guestbook`.

- O projeto também encontra-se nesse repositório [aqui](./Arquivos/Projeto%20-%20Livro%20de%20Visitas/).

## :four: Estratégias de Deploy

### :arrow_right: Rolling Update

- A estratégia é realizar a alteração gradual do ambiente de produção. Na imagem abaixo o sistema possui três instancias, que encontram-se inicialmente em uma versão representada pela cor azul (*State 0*). Em um segundo momento (*State 1*), desejamos inserir a nova versão desse sistema, representada pela cor verde, sendo apenas uma das instâncias alterada e as demais mantidas na versão anterior. Em um segundo momento (*State 2*), mais uma instância é alterada e por fim (*State 3*) o último nó é atualizado.

- A ideia dessa estratégia é não derrubar possíveis usuários que estejam conectados no sistema, ainda na versão antiga, para realizar o deploy da nova versão. O nó é atualizado apenas quando não houverem mais usuários conectados a ele, sendo a mudança transparente para o usuário.

![Estratégias de Deploy - Rolling Update](Imagens/Estrat%C3%A9gias%20de%20Deploy%20-%20Rolling%20Update.png)

- Essa estratégia, por padrão, é utilizada pelo Kubernetes quando realizamos o deploy de uma nova versão de um Pod:

![Estratégias de Deploy - Rolling Update - Exemplo](Imagens/Estrat%C3%A9gias%20de%20Deploy%20-%20Rolling%20Update%20-%20Exemplo.png)

- Na imagem acima podemos verificar que um Pod da versão antiga é removido apenas quando um novo da nova versão é criado.

### :arrow_right: Blue/Green

- A estratégia é manter duas versões do sistema em ambiente produtivo e realizar o chaveamento entre elas utilizando o balanceador de carga que recebe as requisições. Isso permite que caso sejam verificadas inconsistências na nova versão, rapidamente seja possível voltar para o estado anterior.

![Estratégias de Deploy - Blue/Green](Imagens/Estrat%C3%A9gias%20de%20Deploy%20-%20Blue%20Green.png)

- Essa estratégia pode ser exemplificada da seguinte forma:

1. Ambiente produtivo corrente, que utiliza a versão 1 da imagem da aplicação, recebe o label `version: blue`:

  ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: webapp-deployment-blue
      labels:
        app: webapp
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: webapp
          version: blue
      template:
        metadata:
          labels:
            app: webapp
            version: blue
        spec:
          containers:
          - name: webapp
            image: gcr.io/gke-lab-390702/webapp:v1
            ports:
            - containerPort: 5000
  ```

2. A nova versão, que utiliza a versão 2 da imagem, recebe o label `version: green`:

  ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: webapp-deployment-green
      labels:
        app: webapp
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: webapp
          version: green
      template:
        metadata:
          labels:
            app: webapp
            version: green
        spec:
          containers:
          - name: webapp
            image: gcr.io/gke-lab-390702/webapp:v2
            ports:
            - containerPort: 5000
  ```

3. As duas versões convivem paralelamente no mesmo ambiente;

  ![Estratégias de Deploy - Blue/Green - Exemplo](Imagens/Estrat%C3%A9gias%20de%20Deploy%20-%20Blue%20Green%20-%20Exemplo.png)

4. Para determinar qual dos dois Deployments deverá ser acessado pelos usuários, será utilizado o Service, que disponibiliza a aplicação através do LoadBalancer da Cloud. Em `selector` é informado se é para olhar para o Deployment com `version` igual a `blue` ou `green`:

  ```YAML
    apiVersion: "v1"
    kind: "Service"
    metadata:
      name: "webapp-lb"
      namespace: "default"
      labels:
        app: "webapp"
    spec:
      ports:
      - protocol: "TCP"
        port: 80
        targetPort: 5000
      selector:
        app: "webapp"
        version: green
      type: "LoadBalancer"
      loadBalancerIP: ""
  ```

5. Caso seja necessário chavear para a versão anterior, basta mudar o valor de `version` no arquivo de configuração do Service e executá-lo novamente.

6. Assim que a versão `green` for validada, a versão `blue` pode ser removida, caso contrário, consumirá recursos desnecessariamente.

### :arrow_right: Canary

- Nesse modelo de deploy, as duas versões da aplicação são mantidas ao mesmo tempo, assim como no modelo Blue/Green, porém, com a diferença de que nesse caso o balanceador de carga alimenta as duas versões ao mesmo tempo. É interessante deixar a versão atual do ambiente com mais instâncias, gerando um menor impacto durante o deploy caso sejam identificadas falhas na nova versão.

![Estratégias de Deploy - Canary](Imagens/Estrat%C3%A9gias%20de%20Deploy%20-%20Canary.png)

- Seja o caso onde possuimos uma aplicação em ambiente de produção funcionando com dez instâncias. Desejamos inserir uma nova versão da mesma e para realizar a validação, vamos substituir apenas uma dessas instâncias por uma nova e manter as demais na versão antiga:

  ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: webapp-deployment-prod
      labels:
        app: webapp
    spec:
      replicas: 9
      selector:
        matchLabels:
          app: webapp
      template:
        metadata:
          labels:
            app: webapp
        spec:
          containers:
          - name: webapp
            image: gcr.io/gke-lab-390702/webapp:v1
            ports:
            - containerPort: 5000
  ```

  ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: webapp-deployment-canary
      labels:
        app: webapp
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: webapp
      template:
        metadata:
          labels:
            app: webapp
        spec:
          containers:
          - name: webapp
            image: gcr.io/gke-lab-390702/webapp:v3
            ports:
            - containerPort: 5000
  ```

- O Service é configurado de tal forma que aponta para ambas as versões:

  ```YAML
    apiVersion: "v1"
    kind: "Service"
    metadata:
      name: "webapp-lb"
      namespace: "default"
      labels:
        app: "webapp"
    spec:
      ports:
      - protocol: "TCP"
        port: 80
        targetPort: 5000
      selector:
        app: "webapp"
      type: "LoadBalancer"
      loadBalancerIP: ""
  ```

- Obviamente pelo fato da versão corrente possuir mais instâncias do que a nova, na maioria das vezes o usuário será redirecionado para ela, gerando um mínimo impacto no ambiente caso a nova versão apresente instabilidade.

- Assim que a versão `canary` for validada, ela pode substituir a versão `prod`.
