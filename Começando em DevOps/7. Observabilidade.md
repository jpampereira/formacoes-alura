# Observabilidade

- **Problema:** Monitorar servidores e aplicações em sistemas distribuídos.

- Mas por quê sistemas distribuídos? Antigamente era muito comum sistemas com arquiteturas monolíticas, isto é, sistemas onde todos os componentes, como banco de dados, sistemas de controle de fila, front-end, back-end se encontravam no mesmo ambiente. Com o advento e popularização da arquitetura de microsserviços, onde esse componentes são "quebrados" em pequenas caixinhas com funções específicas, nasce o desafio de se atingir a observabilidade em todos esses componentes ao mesmo tempo.

- **Desafio:** Agir proativamente ou reativamente em métricas e logs distribuídos.

- Pilares da Observabilidade:
  - **Métricas (*Metrics*):** Número de acessos a sua aplicação, Quantidade de requisições bem sucedidas e com erro, etc.;
  - **Traços Distribuídos (*Distributed Tracing)*:** Todas as requisições são provenientes de um mesmo front-end, assim, o objetivo é essa requisição possuir um identificador único que permita verificar todo o caminho realizado por ela em todas as etapas/componentes da nossa solução;
  - **Logs:** A partir desse identificador, é possível verificar tudo o que foi processado por determinado componente no momento em que aquela requisição chegou até ele.

## :one: Métricas

- Uma ferramenta para a coleta de métricas é o **Prometheus**, onde é possível definir métricas customizadas, para conseguir contabilizar o número de requisições, por exemplo, além de métricas padrão, como o uso de CPU e Memória, a quantidade de leitura e escrita em disco, etc.

  ```JavaScript
    // Métrica Customizada

    const client = require('prom-client');
    const contador = new client.Counter({
      name: 'acessos',
      help: 'contador_acessos',
    });
    contador.inc();
  ```

  ```JavaScript
    // Métricas Padrão

    const client = require('prom-client');

    const collectDefaultMetrics = client.collectDefaultMetrics;

    const prefix = 'alura_+';

    collectDefaultMetrics({ prefix });
  ```

- O Prometheus até pode *plotar* essas informações obtidas para visualizá-las, porém, ele não é a ferramenta mais adequada. Para isso podemos utilizar o **Grafana**.

## :two: Traços Distribuídos

- Uma alternativa de ferramenta para possuir esses traços distribuídos é o **Jagger**, implementado em Go.

```Python
from tornado import ioloop
from jaeger_client import Config

config = Config(config={}, service_name='alura_+', validate=True)
config.initialize_tracer(io_loop=ioloop.IOLoop.current())
```

- No código acima, sempre que uma requisição for realizada para a aplicação **alura_+**, o Jaeger irá interceptá-la e começará a gerar os traços distribuídos.

- Podemos subir isso em diferentes containers, onde um será a aplicação e o outro será o Jaeger.

- Toda a tarefa de gerar esses traços será delegada ao Jaeger e a aplicação não precisará se preocupar com isso.
  - Tarefa resolvida a nível de infraestrutura.

- Outras opções:
  - Service Mesh (Istio);
  - Proxy (Envoy, Traefik, Kong).

- Através do próprio Jaeger, é possível visualizar a linha do tempo e entender por onde a requisição passou e o tempo que ela demorou em cada etapa.

## :three: Logs

- Todas as linguagens de programação oferecem um suporte para impressão e armazenamento de mensagens em arquivos (*STDOUT*).

```Java
  package br.com.alura;
  import org.apache.logging.log4j.Logger;
  import org.apache.logging.log4j.LogManager;

  public class AluraLogger {
    static final Logger logger = LogManager.getLogger(AluraLogger.class.getName());

    public void log(String logMessage) {
      logger.info(logMessage);
    }
  }
```

- No código, acima podemos visualizar um código em Java que utiliza a biblioteca **Log4j** para a padronização e impressão de logs nas saídas padrão da solução, como terminal e arquivos.

```XML
  <?xml version="1.0" encoding="UTF-8"?>
  <Configuration status="WARN">
    <Appenders>
      <Console name="Console" target="SYSTEM_OUT">
        <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
      </Console>
    </Appenders>
    <Loggers>
      <Root level="error">
        <AppenderRef ref="Console"/>
      </Root>
    </Loggers>
  </Configuration>
```

- No código acima, podemos visualizar a configuração, em XML, do Log4j utilizada para loggar as informações referentes a aplicação. É possível definir que tipo de mensagem deve ser registrada (Informações, Debugs, Warnings, Errors), onde elas devem ser printadas, qual o formato, etc.

- Para podermos visualizar os logs da aplicação, é necessária a exportação dos mesmos para o servidor de logs, que pode ser feita através de:
  - Sidecar;
  - Logging agent instalado no Host;
  - Shell script (não recomendado, pois necessita que diversas tratativas sejam realizadas, que já são tratadas pelas ferramentas anteriores).

- Essas abordagens coletam os logs de tempos em tempos e, eventualmente, enviam para o Servidor de Logs para posterior visualização e armazenamento (temporário ou definitivo).

- Ferramentas como **Graylog** conseguem interpretar esses logs e indexá-los de acordo com as mensagens coletadas.

## :four: Conclusão

- Em sistemas distribuídos, observabilidade é crucial.

- Muitas ferramentas no mercado (OSS e Proprietárias):
  - ELK;
  - New Relic;
  - Dynatrace;
  - Prometheus;
  - Grafana;
  - Jaeger;
  - Graylog.
