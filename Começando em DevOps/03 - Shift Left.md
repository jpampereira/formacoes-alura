# Shift Left em DevOps

- A prática comum é que o processos de desenvolvimento em empresas sejam realizados em equipes, onde seus membros possuem uma ou mais funções durante o ciclo de desenvolvimento do software. Na imagem abaixo podemos ver o esquema de funcionamento básico de um ciclo, baseado no modelo em cascata:

  ![Modelo em Cascata](Imagens/Modelo%20em%20Cascata.png)

- Mesmo em Modelo Ágeis, comumente utilizados nas equipes de desenvolvimento nos dias de hoje, como o Scrum, essas diferentes etapas podem ser encontradas dentro de uma Sprint, sofrendo algumas variações, dependendo da necessidade do produto manipulado. Exemplo: o software analisado pode precisar de uma etapa a mais para questões de segurança, por conta da sensibilidade dos dados que trafégam pelo mesmo.

- O fluxo de trabalho é: O planejamento e a análise é realizado, após o fim dessa parte, com o escopo da demanda definido, ela é passada para o time de desenvolvimento, que por fim passa o produto desenvolvido para as etapas de testes e deploy, onde serão analisados os testes que devem ser realizados para avaliar a confiabilidade do produto e definir como ele será disponibilizado em ambiente produtivo.

- Porém, seguir esse modelo traz alguns problemas, principalmente para os membros que encontram-se nas etapas mais a direita, como os times de teste e deploy:
  - Espera;
  - Gargalo;
  - Sobrecarga de trabalho;
  - Atrito entre as pessoas/times.

  ![Shift Left - Meme](Imagens/Shift%20Left%20-%20Meme.png)

- Para evitar esses problemas, uma alternativa é deslocar essas últimas etapas para o início do projeto, também chamado de *Shift Left*, isto é, um deslocamento para a esquerda. Com esse movimento, as equipes de testes e deploy passam a participar das etapas de planejamento e análise, colocando em discussão todos os pontos pertinentes a essas etapas, podendo identificar antecipadamente possíveis problemas e necessidades que seriam anteriormente identificadas somente quando o produto final, praticamente pronto, chegasse em suas mãos, faltando apenas alguns dias para o final da Sprint.

- Vantagens do *Shift Left*:
  - Colaboração entre as pessoas/times;
  - Planejamento prévio das etapas de testes, segurança e entrega;
  - Evita gargalo no processo de desenvolvimento;
  - Agiliza a entrega de software.
