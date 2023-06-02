# Utilizando Jobs com Kubernetes

- Podemos utilizar os **Jobs** quando desejamos executar um Pod por um determinado período, como por exemplo, executar um script e depois finalizar.

- Caso optemos por utilizar um Pod convencional, ao finalizar a execução do comando ele irá falhar, pois ele sempre espera que algum processo irá mantê-lo de pé.

- Como exemplo, vamos criar um Pod que deve esperar 15 segundos e imprimir `Olá, Mundo!` utilizando o comando `echo`, e depois finalizar.

  - Fazendo isso configurando um Pod:

    ```YAML
      apiVersion: v1
      kind: Pod
      metadata:
        name: olamundo-pod
      spec:
        containers:
          - name: container-olamundo
            image: ubuntu:22.04
            command: ["/bin/sh", "-c"]
            args: ["sleep 15 ; /bin/echo Olá, Mundo!"]
    ```

  - Se acompanharmos o status do Pod, vamos perceber que ele fica em um ciclo executando indefinidamente e dando erro por entrar em loop:

    ![Jobs - Exemplo utilizando Pods](Imagens/Job%20-%20Exemplo%20utilizando%20Pods.png)

  - Configurando o Pod para ser executado através de um Job:

    ```YAML
      apiVersion: batch/v1
      kind: Job
      metadata: 
        name: olamundo-job
      spec:
        template:
          spec:
            containers:
              - name: container-olamundo
                image: ubuntu:22.04
                command: ["/bin/sh", "-c"]
                args: ["sleep 15 ; /bin/echo Olá, Mundo!"]
            restartPolicy: Never
        backoffLimit: 3
    ```

    - Dentro das especificações do Job, configuramos um template que é o Pod que será executado;
    - É necessário configurar a política de restart do container, que por padrão é `Always`, para `Never`;
    - O Job pode falhar durante sua execução, portanto, podemos indicar em `backoffLimit` uma quantidade de reententativas que podem ser realizadas.

  - Se acompanharmos a execução do Pod, vamos perceber que ele executa e passa para o estado de completo:

    ![Monitorando o Pod de um Job](Imagens/Job%20-%20Monitorando%20Pod%20de%20um%20Job.png)

  - Se listarmos o Job, veremos que ele aparece com o status de completo:

    ![Job Completo](Imagens/Job%20Completo.png)
