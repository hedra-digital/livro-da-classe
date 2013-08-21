#!/bin/bash


echo "Escolha a opção:"
echo "1. Contextualizar palavras do dicionário especial (dic.pws)"
echo "2. Passar corretor ortográfico (aspell) em todos os arquivos .tex"

read q

case $q in

1)
cont=1
contB=1
	for dic in `cat dic.pws`
	do
	echo "$contB..........................................................."
 		cont=`expr $cont + 1`
 		contB=`expr $contB + 1`
		echo $dic
		grep --color=auto -n -e "[^a-zA-ZÁ-Úá-ú]$dic$" -e "^$dic[^a-zA-ZÁ-Úá-ú]" -e "[^a-zA-ZÁ-Úá-ú]$dic[^a-zA-ZÁ-Úá-ú]" *.tex 

		if [ $cont = 5 ]; then
		read y
		cont=1
		fi
done
;;

2) 
for i in *.tex
do 
aspell --extra-dicts=./dic.pws -t -c $i
done
;;

esac
