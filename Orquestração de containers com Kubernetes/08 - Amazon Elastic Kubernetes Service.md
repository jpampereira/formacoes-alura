# Amazon Elastic Kubernetes Services (Amazon EKS)

- O EKS é o serviço fornecido pela AWS que provê um ambiente para deploy de aplicações baseadas em containers utilizando o Kubernetes, assim como o Google Kubernetes Engine (GKE) e o Azure Kubernetes Service (AKS).

- O EKS utiliza os serviços AWS Fargate e Amazon EC2 para fornecer os Nodes que compõe o Cluster Kubernetes:

  ![Funcionamento](Imagens/EKS%20-%20Funcionamento.png)

  - O **AWS Fargate** é o serviço que provê a publicação de aplicações Serveless, isto é, aplicações onde a infraestrutura é transparente ao usuário e o custo se da sob a demanda de uso;
  - O **Amazon EC2** é o serviço que provê máquinas virtuais no ambiente de nuvem.

- Para manipular a nuvem da AWS pela máquina host é necessário baixar o AWS CLI.

## :one: Pré-requisitos

### :arrow_right: Role

- O primeiro pré-requisito é criar uma permissão através do IAM (*Identity and Acess Management*), um serviço que gerencia os acessos aos serviços e recursos da nuvem, permitindo que o EKS seja executado na conta em questão da AWS.

- Clicar em **Criar função**:

  ![Criação da Role - Parte 1](Imagens/AWS%20-%20Criando%20Role%20-%20Parte%201.png)

- Selecionar **Serviço da AWS** em **Tipo de entidade confiável** e **EKS - Cluster** em **Caso de uso** e clicar em **Próximo**:

  ![Criação da Role - Parte 2](Imagens/AWS%20-%20Criando%20Role%20-%20Parte%202.png)

- Será criada a role **AmazonEKSClusterPolicy** e a partir de então a criação de um cluster EKS estará liberada:

  ![Criação da Role - Parte 3](Imagens/AWS%20-%20Criando%20Role%20-%20Parte%203.png)

### :arrow_right: VPC

- É necessário criar as redes que irão compor o nosso Cluster. Se criassemos um Cluster sem criar sua VPC (*Virtual Private Cloud*), seria utilizado o recurso padrão, porém, a documentação recomenda a criação de uma nova rede para ser utilizada pelo serviço.

- Podemos criá-las manualmente através do serviço de **VPC**, porém, para facilitar, vamos utilizar o **CloudFormation**, que permite a criação de recursos AWS a partir de templates.

- Clicar em **Create stack**:

  ![Criação da VPC - 1](Imagens/AWS%20-%20Criando%20VPC%20-%20Parte%201.png)

- Nesse exemplo foi utilizado um arquivo YAML disponível através de um link para gerar a rede VPC. Se clicarmos em **View in Designer** podemos visualizar o descritivo do arquivo de configuração:

  ![Criação da VPC - 2](Imagens/AWS%20-%20Criando%20VPC%20-%20Parte%202.png)

  - Link do YAML utilizado: `https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-12-10/amazon-eks-vpc-sample.yaml`.

- Devemos dar um nome para a rede em **Stack name** e os demais campos não precisamos preencher. Por final clicar em **Próximo** até o fim do processo:

  ![Criação da VPC - 3](Imagens/AWS%20-%20Criando%20VPC%20-%20Parte%203.png)

- Assim que o Status da Stack estiver em **CREATE_COMPLETE** significa que a rede está criada:

  ![Criação da VPC - 4](Imagens/AWS%20-%20Criando%20VPC%20-%20Parte%204.png)

- Se acessar a página do serviço VPC também podemos visualizar a rede:

  ![Criação da VPC - 5](Imagens/AWS%20-%20Criando%20VPC%20-%20Parte%205.png)

## :two: Autenticação AWS CLI

- Para vincular o AWS CLI a sua conta da AWS, é necessário executar o seguinte comando:

  ```PowerShell
    aws configure
  ```

- Nesse momento será solicitado quatro informações:
  - AWS Access Key ID;
  - AWS Secret Access Key;
  - Default region name;
  - Default output format.

- Para obter a **Access Key ID** e a **Secret Access Key** deve se acessar **Credenciais de segurança**:

  ![Configurando CLI - Parte 1](Imagens/AWS%20-%20Configurando%20CLI%20-%20Parte%201.png)

- E nessa página configurar um token de autenticação. No nosso caso foi criado um do tipo **Chaves de acesso**, mesmo não sendo recomendado para o usuário raiz:

  ![Configurando CLI - Parte 2](Imagens/AWS%20-%20Configurando%20CLI%20-%20Parte%202.png)

- Após a criação da chave, o **Access Key ID** e o **Secret Access Key** serão disponibilizados e podem ser até baixados em um arquivo `.csv`.

- A partir de então o usuário estará conectado a sua conta do AWS.

## :three: Cluster

- O processo será realizado via linha de comando pois o AWS do instrutor possui dupla autenticação, o que impede a criação do Cluster via interface gráfica e a manipulação dele via linha de comando na máquina local. Porém, sempre é recomendado habilitar a dupla autenticação por questões de segurança.

- Para criação do Cluster deve-se executar o seguinte comando:

  ```PowerShell
    aws eks create-cluster --name <nome-cluster> --role-arn <role-arn> --resources-vpc-config subnetIds=<subnetIds>,securityGroupIds=<securityGroupIds>
  ```

- Para obter o **role-arn**, acessar a Role criada nos pré-requisitos e copiar o valor do campo **ARN**:

  ![Criação do Cluster - Parte 1](Imagens/AWS%20-%20Criando%20Cluster%20-%20Parte%201.png)

- Para obter os **subnetIds**, acessar o **Painel da VPC**, ir em **Sub-redes** e copiar todos os **ID da sub-rede** relacionados ao EKS. Eles serão inseridos no comando separados por vírgula:

  ![Criação do Cluster - Parte 2](Imagens/AWS%20-%20Criando%20Cluster%20-%20Parte%202.png)

- Ainda no **Painel da VPC**, porém em **Grupos de segurança**, copiar os **ID do grupo de segurança** relacionados ao EKS:

  ![Criação do Cluster - Parte 3](Imagens/AWS%20-%20Criando%20Cluster%20-%20Parte%203.png)

- Com essas informações, é possível executar o comando para criar o Cluster. Ao final do processo, podemos acessar o painel do EKS e verificar que o Cluster foi de fato criado:

  ![Criação do Cluster - Parte 4](Imagens/AWS%20-%20Criando%20Cluster%20-%20Parte%204.png)

- Listar os Clusters vinculados a conta:

  ```PowerShell
    aws eks list-clusters
  ```

- Verificar as especificações de um Cluster:

  ```PowerShell
    aws eks describe-cluster --name <nome-cluster>
  ```

## :four: Autenticando o Cluster através do kubectl

- Para que o `kubectl` reflita o Cluster criado na nossa conta do AWS, é necessário baixar as configurações do mesmo para nossa máquina local.

- Primeiramente é necessário baixar o `aws-iam-authenticator`, uma ferramenta do AWS criado com o propósito de realizar a autenticação de Cluster Kubernetes utilizando as credenciais do AWS IAM.

- Executar o seguinte comando para baixar as configurações do Cluster:

  ```PowerShell
    aws eks update-kubeconfig --name <nome-cluster>
  ```

  - Nesse momento o `aws-iam-authenticator` será chamado por baixo dos panos, realizará a autenticação do `kubectl` com o AWS e as configurações do Cluster são baixadas e armazenadas em `~/.kube`.

## :five: Nodes

- Para criar os Nodes, vamos usar novamente o **CloudFormation**, evitando termos de criar um por um. Durante a criação dele deve ser especificado o nome do pool de Nodes, o nome do Cluster vinculado, qual imagem será utilizada para criação da máquina (visualizar documentação), o tipo da máquina (capacidade de processamento e memória) e sua capacidade de armazenamento, a chave SSH utilizada para comunicação entre os Nodes, quai as VPCs e sub-redes que serão utilizadas, além de já ser possível configurar questões de Auto Scaling vertical.

- Link do YAML utilizado: `https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-12-10/amazon-eks-nodegroup.yaml`.

- No final do processo, se acessarmos o painel do EC2, podemos visualizar os Nodes criados, cada um deles uma máquina virtual:

  ![Criação Nodes - Parte 1](Imagens/AWS%20-%20Criação%20Nodes%20-%20Parte%201.png)

- Acessando **Grupos do Auto Scaling**, é possível editar as configurações dos Nodes estabelecidas em sua criação:

  ![Criação Nodes - Parte 2](Imagens/AWS%20-%20Criação%20Nodes%20-%20Parte%202.png)

- Uma das possibilidade de edição é o número de nós mínimo, máximo e desejado:

  ![Criação Nodes - Parte 3](Imagens/AWS%20-%20Criação%20Nodes%20-%20Parte%203.png)

- Porém, se executarmos o comando `kubectl get nodes`, vamos receber a mensagem de que ainda não existem recursos daquele tipo vinculados ao Cluster. Isso acontece pois apenas criamos as máquinas dos Nodes, porém, não associamos elas ao Cluster.

- Para vincular os Nodes ao Cluster, é necessário baixar o mapa de configuração do autenticador da AWS, disponivel [aqui](https://amazon-eks.s3-us-west-2.amazonaws.com/cloudformation/2018-08-30/aws-auth-cm.yaml).

- É necessário alterar, no arquivo, o valor da variável `rolearn`. Para encontrar o valor que deve ser inserido, deve-se acessar o painel do **CloudFormation**, selecionar o recurso dos Nodes, ir em **Outputs** e copiar o valor de **NodeInstanceRole**:

  ![Vincular Nodes e Cluster](Imagens/AWS%20-%20Vincular%20Nodes%20e%20Cluster.png)

- Após alterar o arquivo, basta aplicá-lo utilizando o `kubectl apply -f aws-auth-cm.yaml` e logo em seguida será possível executar o comando `kubectl get nodes` e visualizar os Nodes do Cluster sendo listados.
