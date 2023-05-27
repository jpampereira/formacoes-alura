# Kubernetes - Pods, Services, ConfigMaps

## :one: Contextualização

![Kubernetes](Imagens/Kubernetes.png)

- Seja a situação onde temos uma aplicação conteinerizada, disponibilizada através de um servidor, esteja ele em seu domínio ou de uma provedora de serviço de nuvem, como AWS, Google Cloud ou Azure. Caso essa aplicação comece a consumir mais recursos computacionais do que a máquina dispõe, precisamos aumentá-los. Esse conceito chama-se **escalabilidade**.

- Podemos escalar uma aplicação de duas formas: **verticalmente**, onde aumentamos os recursos computacionais da máquina no qual a aplicação está alocada, como memória, processamento, armazenamento, etc.; ou **horizontalmente**, onde adicionamos mais máquinas que irão executar a aplicação em paralelo, balanceando a carga de trabalho.

- Nossa solução foi escalar horizontalmente a aplicação. Porém, outro problemas podem surgir:
  - Pode ser que em um determinado momento, mesmo com duas máquinas executando a nossa aplicação, seja necessário adicionar uma terceira ou até mesmo quarta máquina e alocarmos novas instâncias dos containeres neles, pois a demanda está aumentando;
  - Outro problema é a necessidade de ser realizar balanceamento de carga entre as máquinas;
  - Caso o container de uma das máquinas pare de funcionar (o termo mais comum de ser utilizado é o container cair), a outra irá suprir a ausência, porém, em algum momento aquele que caiu deve ser restabelecido.

- O Kubernetes permite que tratemos todas essas questões de forma fácil e automatizada.

- É possível criar um **Cluster**, que agrupa todos as máquinas disponibilizadas para a aplicação, para gerenciá-las. Esse agrupamento permite que o Kubernetes realize automaticamente o balanceamento de carga entre as máquinas, as escale conforme a necessidade, reinicie containeres que por algum motivo pararam de funcionar, etc.

## :two: Arquitetura

![Recursos do Kubernetes](Imagens/Recursos%20do%20Kubernetes.png)

- O Kubernetes não é um simples orquestrador de containeres. Ele possui recursos (*resources*) prontos que nos permitem realizar determinadas tarefas, sem a necessidade de implementarmos tudo do zero. Exemplo:
  - Caso desejemos lidar com persistência de dados, podemos utilizar o recurso de *Persistent Volume* (PV);
  - Caso precisemos utilizar um container, devemos utilizar o recurso de *Pods*, que permite encapsulá-los e manipulá-los pelo Kubernetes.

- *Spoiler:* O Kubernetes não mexe diretamente com containeres. Ele os encapsula em estruturas chamadas *Pods* que permite manipulá-los e ter mais "poderes" sobre eles.

- Utilizando esses recursos, conseguimos criar aplicações bem elaboradas: o *Service* (SVC) recebe um tráfego de dados e realiza o balanceamento de carga entre os *Pods*, que podem estar sendo gerenciados por um ReplicaSet (RS), que pode estar sendo gerenciado por um Deployment (DEPLOY), e esses *Pods* podem ser escalados horizontalmente utilizando o *Horizontal Pod AutoScaler* (HPA). Tudo vai depender de utilizarmos os recursos corretos.

- Todos esses recursos serão vistos com mais detalhes.

![Master e Node](Imagens/Cluster%20-%20Master%20e%20Nodes.png)

- As máquinas que compõe um Cluster podem ser divididas em dois grupos: **Master** e **Node**.

- As máquinas Master são responsáveis por gerenciar o cluster, manter e atualizar o estado desejado e receber e executar novos comandos.
  - Se um Pod cair sem que tenha sido enviado qualquer comando para derrubá-lo, ele é responsável por identificar essa inconsistência e reestabelecê-lo;
  - Caso o usuário deseje executar um comando, por exemplo, criar uma nova funcionalidade dentro do Cluster, o Master será responsável por receber esse comando, interpretá-lo e executá-lo.

- As máquinas Nodes são responsáveis por executar as aplicações, isto é, os Pods que encapsulam os containeres que compõe a aplicação.

![Master e Node - Componentes](Imagens/Cluster%20-%20Master%20e%20Nodes%20-%20Componentes.png)

- Podemos entrar um pouco mais a fundo e perceber que essas máquinas Master e Node possuem recursos responsáveis por diferentes tarefas.

- No caso dos nós Master (esses quatro recursos formam o *Control Plane*):
  - **API**: Responsável pela comunicação entre os componentes e por receber as requisições externas;
  - **Control Manager:** Responsável por manter e atualizar o estado desejado;
  - **Scheduler:** Responsável por determinar em que máquina do Cluster será alocado o Pod;
  - **ETCD:** Responsável por armazenar os dados vitais referentes ao cluster em um banco do tipo chave-valor.

- No caso dos nós Node:
  - **Kubelet:** Responsável pela execução dos Pods dentro dos Nodes;
  - **K-Proxy:** Responsável pela comunicação entre os Nodes do Cluster.

![Kubectl](Imagens/Kubectl.png)

- Para nos comunicarmos com a API e realizarmos comandos, utilizamos o `kubectl`, onde enviamos *requests*, isto é, comandos de criação, leitura, atualização ou remoção, para manipular os recursos existentes no Cluster.

- Essas *requests* podem ser enviadas de forma declarativa, através de arquivos onde especificamos o que queremos que aconteça; ou de forma imperativa, enviando comandos.

## :three: Criando o Cluster

### :arrow_right: Windows

- Basta instalar o Docker Desktop e ir em suas configurações e habilitar o Kubernetes. A partir de então o kubectl estará disponível através da linha de comando e automaticamente um cluster será criado e seus Nodes podem ser visualizados a partir do seguinte comando:

  ```Windows
    kubectl get nodes
  ```

### :arrow_right: Linux

- Nesse caso é necessário instalar o kubectl manualmente.

- Para a criação do Cluster é necessário instalar o **Minikube**, uma ferramenta que permite a criação de um Cluster local de forma virtualizada.

- Para iniciar o Minikube, deve-se apontar um driver de virtualização. Nesse caso, uma alternativa é baixar o VirtualBox na sua máquina (ou qualquer outra ferramenta de virtualização a sua escolha) e executar o seguinte comando:

  ```Bash
    minikube start --vm-driver=virtualbox
  ```

- A partir de então o Cluster estará criado e seus Nodes podem ser visualizados utilizando o mesmo comando do Windows.

## :four: Pods

- A palavra Pod vem do inglês e significa **Casulo**.

- Container e Pod não são sinônimos, sendo o primeiro a unidade básica do Docker enquanto o segundo é a unidade básica do Kubernetes.

- Como a tradução da palavra diz, o Pod funciona como uma espécie de casulo para os containers e possui algumas vantagens:
  - Um único Pod pode conter um ou mais containers;
  - Esses containers, por estarem no mesmo Pod, compartilharão o mesmo IP, sendo diferenciados pela porta em que são acessados;
  - O fato de estarem no mesmo Pod facilita a comunicação entre eles, pois agora eles podem se comunicar via *localhost*

- Para um Pod reiniciar, é necessário que todos os seus containers estejam inoperantes.

### :arrow_right: Comandos Imperativos

- Para criarmos um Pod utilizamos o seguinte comando:

  ```Windows
    kubectl run <nome-pod> --image=<nome-imagem>:<versao>
  ```

- Para listar os Pods do Cluster:

  ```Windows
    kubectl get pods
  ```

  - Podemos utilizar o parâmetro `--watch` para que o terminal fique alocado apenas para ficar mostrando o estado dos Pods contidos no Cluster e caso alguma alteração de estado ocorra, como por exemplo, o Pod parou de funcionar, ele irá informar.

- Para ver um descritivo sobre o Pod:

  ```Windows
    kubectl describe pod <nome-pod>
  ```

  - A resposta traz diversas informações, como os eventos que ocorreram no Pod, seu endereço IP, nome, etc.
  - Na imagem abaixo podemos ver as informações de quais eventos ocorreram no Pod;

    ![Criação do Pod](Imagens/Criação%20do%20Pod.png)

    - Essa imagem permite enxergarmos na prática o funcionamento dos componentes que compõe o control panel dos nodes Master, vistos na seção sobre arquitetura:

      1. No primeiro passo, o **scheduler** atribuiu o Pod `nginx-pod` à máquina `docker-desktop`, que faz parte do Cluster local criado na minha máquina;
      2. Em seguida, uma série de operações realizadas pelo **kubelet**, responsável pela operação dos containers: baixou a imagem do nginx na versão latest, criou o container dentro do Pod nginx-pod e o iniciou.

- Para editar um Pod:

  ```Windows
    kubectl edit pod <nome>-pod
  ```

  - Nesse momento um editor de texto será aberto e assim que as alterações forem salvas e o editor fechado, as mesmas serão persistidas no Pod.

  - Na imagem abaixo podemos ver novamente a seção de eventos descritos no Pod e vemos que ao editar o Pod para buscar uma nova versão da imagem do nginx, ocorreu um erro pois a versão especificada não foi encontrada:

    ![Erro na edição do Pod](Imagens/Erro%20na%20edição%20do%20Pod.png)

    - Nesse momento o Pod ficou inoperante.

- As imagens são baixadas direto do Docker Hub e armazenadas dentro do Node que o Pod foi alocado, não sendo compartilhado com os demais Nodes que compõe o Cluster.

- Para deletar um Pod:

  ```Windows
    kubectl delete pod <nome-pod>
  ```

### :arrow_right: Comandos Declarativos

- Até o momento a criação dos Pods se deu de forma imperativa, ou seja, através de comandos realizados de forma manual diretamente na CLI. Esse método possui certas desvantagens, como a maior complexidade para a realização dos comandos, além de não deixar um histórico do que foi executado.

- Em cenários reais, é comum utilizarmos arquivos onde especificamos todas as configurações do Pod, facilitando sua manutenção.
  - Esses arquivos descritivos geralmente são criados utilizando a extensão `.yaml`.

- Exemplo:

  ```YAML
    apiVersion: v1
    kind: Pod
    metadata:
      name: primeiro-pod-declarativo
    spec:
      containers:
        - name: nginx-container
        image: nginx:latest
  ```

  - **apiVersion:** Informa qual a versão da API que desejamos nos comunicar;
  - **kind:** O que está sendo criado no arquivo;
  - **metadata:** Define informações sobre o Pod, como por exemplo, o seu `name`;
  - **spec:** Especificações do Pod;
  - **containers:** Permite definir os containers que compõe o Pod.

- Para criar um Pod a partir desse arquivo:

  ```Windows
    kubectl apply -f <caminho-arquivo>
  ```

  - O parâmetro `-f` indica que desejamos passar o caminho do arquivo descritivo.

- Para editarmos um Pod criado de forma declarativa, basta editar o arquivo `.yaml` e executar novamente o comando de criação. O Kubernetes irá entender que já existe um Pod criado a partir daquele arquivo, então ao invés de criar um novo, irá substituí-lo pela nova versão.

- É possível deletar um Pod criado de maneira declarativa utilizando o comando apresentado na seção anterior. Mas há outra alternativa:

  ```Windows
    kubectl delete -f <caminho-arquivo>
  ```
