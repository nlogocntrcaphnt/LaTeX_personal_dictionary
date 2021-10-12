#!/bin/bash

#translation="$(sdcv -u "My English - Greek" -n -e $1 | sed '1d' | sed '/-->/d')"
export STARDICT_DATA_DIR=~/Documents/repositories/LaTeX_personal_dictionary/
definition="$(sdcv -u "dictd_www.dict.org_gcide" $1 | sed '1d' | sed '/-->/d' | sed '/^$/d')"

wordlist="$(grep 'emph' ~/Documents/repositories/LaTeX_personal_dictionary/Words.tex | sed 's/.*{//' | sed 's/.$//' | xargs)"

if [[ "$wordlist" == *"$1"* ]]; then
	printf "Word already exists. \n"
else
	head -n -2 ~/Documents/repositories/LaTeX_personal_dictionary/Words.tex > /tmp/Words.tex
	echo "\item[$\square$] \emph{ $1 }
\begin{enumerate}
\item{
\begin{lstlisting}
$definition
\end{lstlisting}}
\end{enumerate}" >> /tmp/Words.tex
	echo "\end{itemize}
\end{document}" >> /tmp/Words.tex

	mv /tmp/Words.tex ~/Documents/repositories/LaTeX_personal_dictionary/
	pdflatex -output-directory ~/Documents/repositories/LaTeX_personal_dictionary ~/Documents/repositories/LaTeX_personal_dictionary/Words.tex

fi

remaining="$(grep -o '\\emph' ~/Documents/repositories/LaTeX_personal_dictionary/Words.tex | wc -l)"
printf "\n The number of words contained within the document are: $remaining"

printf "\n \n$definition"
