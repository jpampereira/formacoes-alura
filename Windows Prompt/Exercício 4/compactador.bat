@echo off
echo Compactando arquivos...
tar -cf notas.zip *.xml 2> erros.txt
IF %ERRORLEVEL% NEQ 0 (echo "Erro na execucao do script") ELSE (echo "Arquivos compactados!")