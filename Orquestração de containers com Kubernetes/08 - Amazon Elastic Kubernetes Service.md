# Amazon Elastic Kubernetes Services (Amazon EKS)

- O EKS é o serviço fornecido pela AWS que provê um ambiente para deploy de aplicações baseadas em containers utilizando o Kubernetes, assim como o Google Kubernetes Engine (GKE) e o Azure Kubernetes Service (AKS).

- O EKS utiliza os serviços AWS Fargate e Amazon EC2 para fornecer os Nodes que compõe o Cluster Kubernetes:

  ![Funcionamento](Imagens/EKS%20-%20Funcionamento.png)

  - O **AWS Fargate** é o serviço que provê a publicação de aplicações Serveless, isto é, aplicações onde a infraestrutura é transparente ao usuário e o custo se da sob a demanda de uso;
  - O **Amazon EC2** é o serviço que provê máquinas virtuais no ambiente de nuvem.
