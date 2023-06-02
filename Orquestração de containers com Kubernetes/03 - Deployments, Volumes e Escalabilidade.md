# Kubernetes - Deployments, Volumes e Escalabilidade

## :one: ReplicaSets

- Desejamos que nossos sistemas possuam alta disponibilidade, porém, pode acontecer a qualquer momento de algum Pod que compõe uma determinada solução cair, causando problemas. É desejável que ao identificar a inoperabilidade de um Pod, que o mesmo seja reiniciado para estabilizar o sistema. Para isso utilizaremos o recurso **ReplicaSets**.

- Além de fazer essa reestabilização automática, desejamos que determinados Pods possuam réplicas para suportar a alta carga de trabalho e também para que o serviço não fique indisponível a nenhum momento, por conta de sua criticidade para o funcionamento do sistema.

![ReplicaSet - Ok](Imagens/ReplicaSet%20-%20Ok.png)

![ReplicaSet - Not Ok](Imagens/ReplicaSet%20-%20Not%20Ok.png)

- Para descrever um ReplicaSet:

  ```YAML
    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
      name: portal-noticias-replicaset
    spec:
      template:
        metadata:
          name: portal-noticias
          labels:
            app: portal-noticias
        spec:
          containers:
            - name: portal-noticias-container
              image: aluracursos/portal-noticias:1
              ports:
                - containerPort: 80
              envFrom:
                - configMapRef:
                    name: portal-configmap
      replicas: 3
      selector:
        matchLabels:
          app: portal-noticias
  ```

  - A `apiVersion` nesse caso será um pouco diferente se comparado aos recursos que vimos até o momento;
  - Precisamos definir um `template` do Pod que desejamos que o ReplicaSet atue. Devemos definir todos os valores exatamente como definimos um arquivo de Pods;
  - Um mesmo ReplicaSet pode encapsular uma ou mais `replicas` de um Pod. Caso um deles fique indisponível, seja lá qual for o motivo, os demais irão suprir a sua ausência, enquanto o recurso ficará responsável por restabelecê-lo;
  - Apesar de definir um template explicitamente dentro do arquivo do ReplicaSet, é necessário utilizar um `selector` para indicar qual o Pod que desejamos que o ReplicaSet fique responsável.

- Na imagem abaixo podemos visualizar um exemplo prático de como os ReplicaSets funcionam. No terminal á esquerda é executado um comando para ficar monitorando os ReplicaSets existentes no Cluster, enquanto no terminal à direita os Pods do Cluster são listados e um daqueles que compõe o ReplicaSet é selecionado e deletado. Nesse momento, podemos visualizar no terminal à esquerda que há uma atualização sobre o estado do ReplicaSet, que fica com dois Pods por alguns segundos e rapidamente recria aquele deletado.

  ![ReplicaSets - Na prática](Imagens/ReplicaSets%20-%20Na%20Prática.png)

  - Outra coisa que podemos perceber é que os Pods de um mesmo ReplicaSet possuem o mesmo nome, diferenciando-se pela string no final. Após deletar um dos Pods e listá-los novamente após a recriação, vemos que o nome de um deles muda, o que comprova que quando um Pod cai ou é removido, o ReplicaSet cria um novo.

- Não é necessário fazer nenhuma alteração no Service que expõe esses Pods, uma vez que a associação entre eles é feita através de `labels` e todos eles possuem o mesmo. O Service ficará responsável por realizar o balanceamento de carga entre as instâncias do ReplicaSet.

- Os comandos para criar, listar, editar e remover um ReplicaSet são os mesmos utilizados pelos recursos anteriores.

## :two: Deployments

- Um Deployment nada mais é do que uma camada que envelopa um ReplicaSet e adiciona funcionalidade de versionamento àquele recurso. Como boa prática costuma-se utilizar Deployments ao invés de criar direto os ReplicaSets.

![Deployment](Imagens/Deployment.png)

- O arquivo de Deployment é similar ao do ReplicaSet:

  ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      template:
        metadata:
          name: nginx-pod
          labels:
            app: nginx-pod
        spec:
          containers:
            - name: nginx-container
              image: nginx:stable
              ports:
                - containerPort: 80
      selector:
        matchLabels:
          app: nginx-pod
  ```

- Para visualizar o histórico de versões de um Deployment (Similar ao `git log`):

  ```Windows
    kubectl rollout history deployment <nome-deployment>
  ```

- Caso atualizemos um Deployment e desejamos aplicar a nova versão (Similar ao `git commit`):

  ```Windows
    kubectl apply -f <caminho-arquivo> --record
  ```

- Para adicionar uma mensagem àquela versão (Similar a escrever uma mensagem para descrever as alterações realizadas naquele commit):

  ```Windows
    kubectl annotate deployment <nome-deployment> kubernetes.io/change-cause="<mensagem>"
  ```

- Para voltar para uma versão anterior (Similar ao `git restore`):

  ```Windows
    kubectl rollout undo deployment <nome-deployment> --to-revision=<numero-revision>
  ```

  - O número da revision pode ser obtido no comando de visualizar o histórico de versões.

- Esse é o resultado de se utilizar Deployments no projeto:

  ![Deployment - Projeto](Imagens/Deployment%20-%20Projeto.png)

- Os comandos para criar, listar, editar e remover um Deployment são os mesmos utilizados pelos recursos anteriores.

## :three: Persistência de Dados

- Estamos tendo um problema com o projeto que ao reiniciar um Pod, todo seu conteúdo, no caso, as notícias criadas através do Sistema de Notícias, são perdidas. Para não perder esses dados, precisamos persistí-los de alguma forma, e o Kubernetes já possui recursos para nos ajudar nessa questão.

### :arrow_right: Volumes

- Os **Volumes** são similares aos existentes em Docker, onde mapeamos um ponto entre o sistema de arquivos do container e da máquina host para realizar o compartilhamento de dados.

![Volumes - Exemplo](Imagens/Volumes%20-%20Exemplo.png)

- Os Volumes são independentes do ciclo de vida dos containers, isto é, caso um container caia, o Volume permanecerá existindo. Porém, se o Pod, seja por la qual motivo, cair, os Volumes relacionados serão removidos, pois nesse caso há uma relação de dependência.

- Existem diferentes tipos de Volumes, mas vamos tratar aqui do Volume já conhecido por quem já estudou Docker que são os Volumes baseados em caminhos no Sistema de Arquivos, chamado de `hostPath`. Nesse tipo de Volume, especificamos um caminho dentro da máquina host e outro dentro do container e tudo o que for criado em um, será replicado no outro.

- No exemplo do `hostPath`, após a remoção dos volumes, os arquivos criado nesse ponto mapeado permanecerão existindo na máquina host. Caso o volume seja criado novamente, os arquivos ainda existirão.

- Para criar um Volume:

  ```YAML
    apiVersion: v1
    kind: Pod
    metadata:
      name: pod-volume
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          volumeMounts:
            - mountPath: /volume-dentro-do-container
              name: primeiro-volume
        - name: jenkins-container
          image: jenkins/jenkins
          volumeMounts:
            - mountPath: /volume-dentro-do-container
              name: primeiro-volume
      volumes:
        - name: primeiro-volume
          hostPath:
            path: /run/desktop/mnt/host/c/Users/jpamp/OneDrive/Área de Trabalho/primeiro-volume
            type: Directory
  ```

  - O Volume é criado diretamente dentro do arquivo de configuração do Pod, mas o procedimento seria o mesmo se criado em um ReplicaSet ou Deployment;
  - Como explicado anteriormente, o Volume está relacionado ao ciclo de via do Pod, isto é, se ele cai, o Volume é removido. Portanto, quando vamos declarar o Volume, devemos colocá-lo nas especificações do Pod e não do container, por isso `volumes` e `containers` ficam no mesmo nível hierarquico do arquivo;
  - O tipo `hostPath` é utilizado para mapear um ponto do sistema de arquivo da máquina host, especificado em `path`, enquanto `type` indica o que está sendo mapeado: um arquivo, um diretório, etc;
  - Nas especificações do container, é necessário determinar, em `mountPath`, em qual ponto do seu sistema de arquivos será realizado o mapeamento do volume. Em `name` deve-se indicar qual o volume que será mapeado;
  - Como podemos perceber, o Pod da configuração acima possui dois containers, um para o Nginx e outro para o Jenkins. Para delimitar o fim das configurações de um container e início do outro, é utilizado o hífen, seguido do atributo `name`.

- Caso o `type` for um diretório, porém, o mesmo não existir no sistema de arquivos, um problema ocorrerá e o Pod não será criado. Porém, podemos utilizar o tipo `DirectoryOrCreate` para dizer ao Kubernetes para ele criar o diretório caso ele não o encontre no caminho passado.

- É necessário entender que para os Pods, a máquina host no caso é o Cluster, onde de fato eles são armazenados. Portanto, os caminhos absolutos passados em `path` não podem iniciar do diretório raiz do Sistema de Arquivos da máquina usuária. No caso do Windows, o Cluster virtualizado é criado automaticamente quando o Kubernetes é habilitado através do Docker Desktop. No Linux, o Cluster virtualizado é criado utilizando o Minikube.
  - No Windows, o caminho em `path` deve sempre começar com `/run/desktop/mnt/host/c`, sendo `c` a pasta `C:`. Esse é o caminho a partir do diretório raiz do sistema de arquivos do Cluster virtualizado até o diretório raiz do sistema de arquivos da máquina host.
  - No caso do Linux, é necessário acessar o Minikube utilizando o comando `minikube ssh` e criar dentro da máquina virtual os arquivos e diretórios que devem ser mapeados.

### :arrow_right: PersistentVolumes

- Os **PersistentVolumes** são uma alternativa onde o Volume não possui dependencia do ciclo de vida de um Pod, isto é, caso o Pod seja removido, seja por lá qual motivo, o volume seguirá existindo.

![PersistentVolumes](Imagens/PersistentVolume.png)

- O PersistentVolume funciona como uma API que irá abstrair a forma como os dados são armazenados e acessados.

- Para um Pod acessar um PersistentVolume (PV), ele utiliza uma camada intermediária chamada PersistenVolumeClaim (PVC).

- Para criar um PersistentVolume:

  ```YAML
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: pv-1
    spec:
      capacity:
        storage: 10Gi
      accessModes:
        - ReadWriteOnce
        # - ReadWriteMany
        # - ReadOnlyMany
      gcePersistentDisk:
        pdName: pv-disk
      storageClassName: standard
  ```

  - É necessário informar a capacidade de armazenamento do volume em `capacity`, sendo no exemplo acima 10 Gigabytes;
  - É preciso também definir o formato de acesso em `accessModes`, se é apenas leitura, leitura e escrita e se os dados podem ser manipulados um usuário por vez ou vários ao mesmo tempo.

- Para criar um PersistentVolumeClaim:

  ```YAML
  apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    name: pvc-1
  spec:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 10Gi
    storageClassName: standard
  ```

  - O Kubernetes irá associar o PV e o PVC através de suas configurações, ou seja, ambos os recursos devem possuir os mesmos `accessMode`, `storage`, etc.

- Como deve ser configurado o Pod:

  ```YAML
    apiVersion: v1
    kind: Pod
    metadata:
      name: pod-pv
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          volumeMounts:
            - mountPath: /volume-dentro-do-container
              name: primeiro-pv
      volumes:
        - name: primeiro-pv
          persistentVolumeClaim:
            claimName: pvc-1
  ```

  - A criação do volume dentro do container é igual a vista no tópico anterior. A diferença vai ser nas especificações do volume, onde será utilizada o tipo `persistentVolumeClaim`, ao invés de `hostPath`, e será passado em `claimName` o mesmo nome definido nos metadados do arquivo de configuração do PVC.

### :arrow_right: StorageClasses

- Para apresentar o conceito de PersistentVolume no tópico anterior, o instrutor exemplificou utilizando o Kubernetes Plataform no Google Cloud. Para isso, ele precisou criar manualmente um disco para armazenar os dados do volume, além de criar manualmente o PersistentVolume. Os **StoragesClasses** permitem automatizar esse processo de criação tanto do disco quanto do PersistentVolume, basta criar um PersistentVolumeClaim e associá-lo a um StorageClass.

![StorageClass](Imagens/Storage%20Classes.png)

- Para criar o StorageClass:

  ```YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClasses
    metadata:
      name: slow
    provisioner: kubernetes.io/gce-pd
    parameters:
      type: pd-standard
      fstype: ext4
  ```

  - É necessário informar em `provisioner`, a plataforma que irá provisionar a criação do disco para armazenar o volume (Nesse exemplo, será o Google Computing Engine), o tipo do disco em `type` (Para disco rígido será `pd-standard` - valor padrão - e SSD `pd-ssd`) e o sistema de arquivos suportado em `fstype`.

- Para criar o PersistentVolumeClaim:

  ```YAML
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: pvc-2
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
      storageClassName: slow
  ```

  - Para associar o PVC ao StorageClass, o valor de `storageClassName` deve ser o mesmo de `name` nos metadados do arquivo de configuração do StorageClass.;
  - As configurações de `accessModes` e `storage` serão replicadas para o PersistentVolume.

- Após criar esses recursos, automaticamente um disco e o PersistentVolume serão criados.

- As configurações do Pod serão identicas as vistas no tópico anterior:

  ```YAML
    apiVersion: v1
    kind: Pod
    metadata:
      name: pod-sc
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          volumeMounts:
            - mountPath: /volume-dentro-do-container
              name: primeiro-pv
      volumes:
        - name: primeiro-pv
          persistentVolumeClaim:
            claimName: pvc-2
  ```

- Caso os StorageClasses forem utilizados localmente, não há o provisionamento de memória dinamicamente, porém, pode ser utilizado para retardar a criação do PersistentVolume até que um Pod seja instanciado (isso é definido pelo `volumeBindingMode` igual a `WaitForFirstConsumer`):

  ```YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: local-storage
    provisioner: kubernetes.io/no-provisioner
    volumeBindingMode: WaitForFirstConsumer
  ```

### :arrow_right: StatefulSets

- Um **StatefulSet** funciona similar a um Deployment, porém, é utilizado em casos onde os Pods precisam de persistência de dados.

![StatefulSet](Imagens/StatefulSet.png)

- Ao definir um Pod é necessário definir também um PersistentVolumeClaim.

- Os Pods são criados junto de um identificador único. Caso por algum motivo o Pod venha a cair, o mesmo será recriado com o mesmo ID assim continuando vinculado ao mesmo PersistentVolume.

- Para configurar um StatefulSet:

  ```YAML
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: sistema-noticias-statefulset
    spec:
      replicas: 1
      template:
        metadata:
          labels:
            app: sistema-noticias
          name: sistema-noticias
        spec:
          containers:
            - name: sistema-noticias-container
              image: aluracursos/sistema-noticias:1
              ports:
                - containerPort: 80
              envFrom:
                - configMapRef:
                    name: sistema-configmap
              volumeMounts:
                - name: imagens
                  mountPath: /var/www/html/uploads
                - name: sessao
                  mountPath: /tmp
          volumes:
            - name: imagens
              persistentVolumeClaim:
                claimName: imagens-pvc
            - name: sessao
              persistentVolumeClaim:
                claimName: sessao-pvc
      selector:
        matchLabels:
          app: sistema-noticias
      serviceName: svc-sistema-noticias
  ```

  - Assim como um Deployment, é necessário definir o número de `replicas` do Pod que é configurado em `template`. A grande diferença para o Deployment é que é necessário criar os `volumes` nas especificações do Pod;
  - É necessário também informar o `serviceName` que liberará o acesso aos containers desse Pod;
  - Para criar o StatefulSet, o PersistentVolumeClaim já deve estar criado.

- No arquivo de PersistentVolumeClaim responsável pelo acesso aos Volumes de `imagens` e `sessao`, nenhum StorageClass é definido, assim, o StorageClass padrão do Cluster é utilizado e o PersistentVolume criado automaticamente.
