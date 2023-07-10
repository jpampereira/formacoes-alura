# Azure Kubernetes Service (AKS)

## :one: Criação do Cluster

- Para criar um Cluster Kubernetes devemos acessar **Serviços do Kubernetes**:

    ![Criação do Cluster - Parte 1](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%201.PNG)

- Clicar em **Criar** e em seguida **Criar um Cluster Kubernetes**:

    ![Criação do Cluster - Parte 2](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%202.PNG)

- Nas configurações do Cluster devemos determinar seu grupo de recursos, nome, o tipo de máquina onde serão criados os Nodes, sua quantidade, além de outras configurações mais específicas:

    ![Criação do Cluster - Parte 3](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%203.PNG)

- Ainda na criação do Cluster, podemos já habilitar o escalonamento vertical do Cluster em **Dimensionamento automático**, que aumenta ou diminui o número de nós de acordo com a carga de trabalho na aplicação. O número de Nodes desconsidera o Node Master, logo, se selecionarmos 3 Nodes, serão criados 3 Slaves e 1 Master:

    ![Criação do Cluster - Parte 4](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%204.PNG)

- Após clicar em **Revisar + criar** será realizada uma validação das configurações estabelecidas e caso elas sejam aprovadas, basta clicar em **Criar** para iniciar a criação do Cluster:

    ![Criação do Cluster - Parte 5](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%205.PNG)

- Na página inicial do Cluster, é possível visualizar todas as informações referentes ao mesmo, como seus recursos disponíveis, métricas de desempenho, configurações correntes, etc.:

    ![Cluster](Imagens/AKS%20-%20Cluster.PNG)

## :two: Azure Client

- Para manipularmos o AKS através da linha de comando da nossa máquina devemos utilizar o Azure Client, sendo necessário baixá-lo.

- Após a instalação, para realizar a conexão com a sua conta do Azure:

    ```PowerShell
        az login
    ```

- Após a execução do comando, será aberta uma página no browser solicitando a entrada das informações de usuário e senha para realizar a autenticação;

- A partir de então é possível manipular sua conta da Azure Cloud através da linha de comando do seu computador.

- Para baixar as configurações do Cluster Kubernetes que desejamos manipular:

    ```PowerShell
        az aks get-credentials --name=<nome-cluster> --resource-group=<nome-grupo-recursos>
    ```

- A partir desse momento, todos os comandos utilizando o `kubectl` refletirão o Cluster do Azure.

## :three: Volumes

- Quando um Cluster é criado, o AKS fica responsável por criar as máquinas virtuais que alocam cada um dos Nodes que o compõe, além de criar seus discos que armazenam seus sistemas operacionais e a rede entre eles:

    ![Diagrama do Cluster](Imagens/AKS%20-%20Diagrama%20do%20Cluster.png)

- Quando criamos um volume que armazenará os dados do Pod da nossa aplicação que necessitam de persistência, inicialmente podemos pensar que volume fica alocado no mesmo disco onde está instalado nosso sistema operacional. Porém, pense no cenário onde temos um Cluster com escalonamento dinâmico de Nodes ou que desejamos manualmente diminuir o número de Nodes por questões de gasto e um dos Pods contém um Volume que armazena 100 Gigabytes de dados que não pode ser descartados. Assim que um Node é removido, todos os recursos do Kubernetes existentes nele são migrados para os Nodes restantes. Pensando na configuração onde o volume é criado no mesmo disco da máquina virtual do SO do Node, sempre que um Node fosse removido, seria necessário transporte essa massa de dados de uma máquina para outra, o que acaba sendo inviável pela grande quantidade de dados e o custo computacional que isso necessitaria. Por esse motivo, sempre que um novo volume é criado, é criado um novo disco para armazená-lo, assim, quando um Node for removido, é necessário apenas alterar apenas o apontamento do disco, sendo muito mais vantajoso computacionalmente.

    ![Provisionamento de Disco para Volumes](Imagens/AKS%20-%20Provisionamento%20de%20Disco%20para%20Volumes.png)

## :four: Azure Container Registry (ACR)

- Quando estamos lidando com uma aplicação a nível comercial, não é interessante que deixemos nossas imagens disponíveis em um repositório público como o Docker Hub e nem que seja armazenado em um registry local. Nesse caso, devemos utilizar o Registry que a própria plataforma do Azure oferece, o **Azure Container Registry**, também citado na literatura como **ACR**.

- Para criar um registry, devemos acessar a página do serviço e clicar em **Criar**:

    ![ACR - Criação do Registry - Parte 1](Imagens/ACR%20-%20Criação%20do%20Registry%20-%20Parte%201.png)

- É necessário selecionar o **Grupo de recursos** ao qual ele deve ser vinculado, o **nome** do registry (ao final dele será acrescentado `azurecr.io`), sua **localização** (opte por criar-lo na mesma zona do Cluster), entre outras configurações:

    ![ACR - Criação do Registry - Parte 2](Imagens/ACR%20-%20Criação%20do%20Registry%20-%20Parte%202.png)

- Para enviar a imagem para o registry criado, primeiramente é necessário se autenticar:

    ```PowerShell
        az acr login --name <nome-registry>
    ```

- É necessário que a tag da imagem contenha o endereço do registry para o qual ela deve ser enviada:

    ```PowerShell
        docker imagem tag <nome-imagem>:<versao> <nome-registry>.azurecr.io/<caminho>/<nome-imagem>:<versao>
    ```

- É possível organizar as imagens em estruturas de diretórios dentro do registry, sendo isso definido em `<caminho>`.

- Para inserir a imagem no Registry:

    ```PowerShell
        docker imagem push <nome-registry>.azurecr.io/<caminho>/<nome-imagem>:<versao>
    ```

- Agora que estamos utilizando a imagem armazenada no Container Registry da nossa cloud, devemos nos preocupar com as credenciais de acesso dos nossos arquivos YAML. Poderiamos descrevê-los diretamente no arquivo de configuração nas especificações do recurso Kubernetes:

    ```YAML
        imagePullCredentials:
            username: usuario
            password: senha
    ```

- Porém, pense no caso da senha ter sido vazada e nós temos 50 ou mais recursos que utilizam essas credenciais para carregar imagens do CR. No que nós trocassemos a senha seria necessário alterar um por um desses arquivos e realizar novamente o `apply`. O que podemos fazer é criar um **Secret** que armazenará essas credenciais e todos os YAMLs acessarem ele. Em caso de necessidade de troca, basta alterar uma única vez que a mudaça já estará sendo refletida em todos os recursos que a utilizam.

- Para criar o Secret:

    ```PowerShell
        kubectl create secret docker-registry <nome-secret> --docker-server <nome-cr>.azurecr.io --docker-username <usuario-cr> --docker-password <senha-cr> --docker-email <email-azure>
    ```

  - O atributo `docker-registry` indica que estamos criando um Secret para armazenar informações de autenticação em um CR.

  - Para descobrir o usuário e senha do Registry, basta acessar a página do ACR em questão e ir na sessão **Chaves de acesso**:

    ![ACR - Credenciais](Imagens/AKS%20-%20Credenciais%20Registry.png)

- Agora devemos atualizar o YAML:

    ```YAML
        imagePullCredentials:
            - name: <nome-secret>
    ```

## :five: Atualização do Cluster

- Podemos visualizar a versão do Cluster tanto pela linha de comando quanto pela interface gráfica do AKS;

  - Linha de comando:

    ```PowerShell
        kubectl version
    ```

  - Interface Gráfica: acessar a página do Cluster e ir em **Configurações do cluster**

    ![Versão do Cluster](Imagens/AKS%20-%20Versão%20do%20Cluster.png)

- Pode ser que em algum momento seja necessário atualizar a versão do Cluster e isso pode ser feito tanto pela interface gráfica do AKS quanto pela linha de comando:

  - Linha de Comando:

    ```PowerShell
    ```

  - Interface Gráfica: na página de **Configurações do cluster**, clicar em **Versão da atualização**.

    ![Atualizar Cluster](Imagens/AKS%20-%20Atualizar%20Cluster.png)

- Não é possível pular mais de uma versão Major de cada vez, isto é, se eu estou na versão 9 e a mais atual e meu objetivo é atualizar para a 11, eu preciso primeiro atualizar para a 10 e só então a versão 11 estará disponível para atualização.

## :six: Linha de Comando do Azure

- Para ajudar com qualquer um dos comandos podemos utilizar o parâmetro de help `-h`.

### :arrow_right: Grupo de Recursos

- Para criar o grupo de recursos:

  ```PowerShell
   az group create --name <nome-grupo-recursos> --location <regiao>
  ```

  - Quando criamos o grupo de recursos pela interface gráfica, não precisamos especificar a localização pois ele pegava a mesma do Cluster.

- Para listar todos os grupos de recursos da nossa conta:

  ```PowerShell
    az group list --output table
  ```
  
  - O parâmetro `--output` traz a resposta do comando no formato de tabela. Por padrão o comando traz a resposta no formato JSON.

- Para remover um grupo de recursos:

  ```PowerShell
    az group delete --name <nome-grupo>
  ```

### :arrow_right: Cluster

- Para criar o Cluster:

  ```PowerShell
    az aks create --name <nome-cluster> --kubernetes-version <versao-k8s> --node-count <quantidade-nodes> --resource-group <nome-grupo> --location <zona> --generate-ssh-keys
  ```

  - O parâmetro `--generate-ssh-keys` é utilizado para criar uma chave SSH que será utilizada pelas máquinas que armazenam os Nodes do nosso Cluster para elas se comunicarem entre elas.

- Para saber quais as versões do Kubernetes disponíveis:

  ```PowerShell
    az aks get-versions --location <zona>
  ```

- Para listar os Clusters:

  ```PowerShell
    az aks list --output table
  ```

- Para listar as versões de upgrade do Kubernetes disponíveis para o Cluster:

  ```PowerShell
    az aks get-upgrades --name <nome-cluster> --resource-group <nome-grupo>
  ```

- Para atualizar a versão do Kubernetes do Cluster (essa mesma lógica funciona também para atualizar outras configurações do Cluster):

  ```PowerShell
    az aks upgrade --name <nome-cluster> --resource-group <nome-grupo> --kubernetes-version <versao-k8s>
  ```

- Para remover um Cluster:

  ```PowerShell
    az aks delete --name <nome-cluster> --resource-group <nome-grupo>
  ```

### :arrow_right: Container Registry

- Para criar um Container Registry:

  ```PowerShell
    az acr create --name <nome-cr> --resource-group <nome-grupo> --sku <sku> --location <zona>
  ```

- Para listar os CR:

  ```PowerShell
    az acr list --output table
  ```

- Por padrão, o usuário admin do registry vem desabilitado, sendo necessário especificar na criação do CR, através de `--admin-enabled true` quando queremos que ele seja habilitado. Porém, não é necessário recriar o recurso, basta apenas atualizarmos (essa mesma lógica funciona também para atualizar outras configurações do CR):

  ```PowerShell
    az acr update --name <nome-cr> --admin-enabled true
  ```

- Para obter as credenciais do ACR:

  ```PowerShell
    az acr credential show --name <nome-cr>
  ```

  - Se trocarmos `show` por `renew`, ele irá atualizar as senhas.

- Para remover um Container Registry:

  ```PowerShell
    az acr delete --name <nome-cr>
  ```

## :seven: Custos

- Podemos utilizar a [calculadora](https://azure.microsoft.com/pt-br/pricing/calculator/) do Azure para gerar uma estimativa de gastos de recursos como AKS, ACR, discos, além de outros serviços fornecidos pelo provedor, antes mesmos de criá-los.
