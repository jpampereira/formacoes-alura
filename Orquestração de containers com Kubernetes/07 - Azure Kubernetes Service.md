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
