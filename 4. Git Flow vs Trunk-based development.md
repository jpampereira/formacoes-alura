# Git Flow versus Trunk-based Development

- Projetos de desenvolvimento de software geralmente são realizados em equipes, onde cada um de seus integrantes é responsável por determinada funcionalidade. Nesse caso, devemos utilizar um software para controle de versão, como por exemplo, o Git.

- Afim de padronizar o uso dessas ferramentas de versionamento de código, foram propostos diferentes fluxos de trabalho, como o **Git Flow** e o **Trunk-based Development**.

## :one: Git Flow

![Git Flow](Imagens/Git%20Flow.png)

- A ideia do Git Flow é separar o desenvolvimento por Branches (ou ramificações):
  - **Master:** Branch responsável por conter todas as versões disponíveis do software em ambiente produtivo. A cada nova versão lançada, uma tag de versão deve ser associada a mesma;
  - **Develop:** Junto da Master, são as duas branches fixas desse projeto, isto é, em nenhum momento elas são removidas quando uma nova feature ou correção é finalizada. Ela deve conter o histórico de todos os desenvolvimento que foram realizados;
  - **Feature:** Caso seja solicitado o desenvolvimento de uma nova funcionalidade ou sua melhoria, deve ser criada uma branch que registrará todo o processo de desenvolvimento da mesma. Caso sejam feitas solicitações por duas funcionalidades diferentes, uma branch deve ser criada para cada uma delas. Ao final do desenvolvimento, as alterações devem ser agregadas (*merge*) com Develop e a branch da funcionalidade apagada;
  - **Release:** Assim que o desenvolvimento de uma funcionalidade é finalizado, deve ser criado uma branch de Release, que serve como uma espécie de versão de homologação. Alterações podem ser realizadas ainda nessa branch caso inconsistências sejam encontradas e ao final essas alterações devem ser "mergeadas" com as features Master (associando uma nova tag de versão) e Develop (caso alterações tenham sido realizadas). Uma branch de Release por cada nova entrega;
  - **Hotfix:** Por fim, essa branch é utilizada para a correção de bugs encontrados em ambiente produtivo e que necessitam de ação imediata. Após a correção da falha, essa branch deve ser "mergeada" com Master e Develop e removida. Uma branch de Hotfix por bug encontrado.

| Quando utilizar | Quando não utilizar |
| --------------- | ------------------- |
| Quando você executa um projeto de código aberto | Quando você está apenas começando |
| Quando você tem muitos desenvolvedores juniores | Quando você precisa iterar rapidamente |
| Quando o tempo não é uma restrição | - |

## :two: Trunk-based Development (Desenvolvimento baseado em tronco)

![Trunk-based Development](Imagens/Trunk-based%20Development.png)

- Esse modelo costuma ser utilizado em situações onde o software deve possuir entrega contínua e seus desenvolvedores possuem maior senioridade.

- São realizados pequenos ciclos de desenvolvimento com a criação de branches de **Feature** que são diretamente commitadas na branch **Master** (ou Tronco). Quando for de entendimento da equipe, uma nova versão é disponibilizada produtivamente através da branch **Release**. Ainda podem haver branches **Hotfix** para corrigir problemas identificados em produção, que devem ser "mergeadas" tanto com Release quanto a Master ao final da correção.
