# Azure Kubernetes Service (AKS)

## :one: Criação do Cluster

- Para criar um Cluster Kubernetes devemos acessar **Serviços do Kubernetes**:

    ![Criação do Cluster - Parte 1](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%201.PNG)

- Clicar em **Criar** e em seguida **Criar um Cluster Kubernetes**:

    ![Criação do Cluster - Parte 2](Imagens/AKS%20-%20Cria%C3%A7%C3%A3o%20do%20Cluster%20-%20Parte%202.PNG)

- Nas configurações do Cluster devemos determinar seu nome, o tipo de máquina onde serão criados os Nodes, sua quantidade, além de outras configurações mais específicas:

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
