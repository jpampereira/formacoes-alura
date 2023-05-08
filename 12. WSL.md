# Windows Subsystem for Linux

- É muito importante que desenvolvedores também saibam manipular terminais de outros Sistemas Operacionais que não apenas o Windows, mais especificamente, o Linux.

- Pensando em viabilizar isso, a Microsoft criou o Windows Subsystem for Linux, uma plataforma que permite a instalação de distribuições Linux e utilização de seus comandos e ferramentas, via Terminal, em cima do próprio Windows.

- Por padrão, o WSL já vem instalado na máquina a partir do Windows 10.

- Para instalar uma distribuição a partir do WSL:

  ```BAT
    wsl --install -d <nome_distribuicao>
  ```

  - O parâmetro `-d` indica que desejamos indicar o pacote que deve ser instalado a partir do seu nome.

- Alguns comandos das distribuições Linux se diferem dos comandos dos terminais Windows, como por exemplo, para listar o conteúdo de um diretório, utilizamos o `ls`.
  - Assim como o Windows tem o `winget` e o `chocolatey` para fazer o gerenciamento de pacotes, na distribuição Ubuntu, utilizamos o `apt-get`:

    ```Bash
      sudo apt-get install <nome_pacote>
    ```

    - O comando `sudo` (*Super User Do*, em português, Faça como super usuário) permite a execução de comandos no **Modo Administrador**. Será solicitada sua senha antes de prosseguir com a instalação.

- Podemos acessar, através do Terminal Linux, a pasta `C:` do Windows e com isso ter acesso a todos os seus conteúdos. Para isso devemos acessa o caminho `/mnt/c`.
