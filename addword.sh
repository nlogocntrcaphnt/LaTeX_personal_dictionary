#!/bin/bash

#translation="$(sdcv -u "My English - Greek" -n -e $1 | sed '1d' | sed '/-->/d')"
definition="$(sdcv -u "dictd_www.dict.org_gcide" $1 | sed '1d' | sed '/-->/d' | sed '/^$/d')"

head -n -2 ~/Documents/repositories/dictionary/Words.tex > /tmp/Words.tex
echo "\item[$\square$] \emph{ $1 }
\begin{enumerate}
\item{
\begin{lstlisting}
$definition
\end{lstlisting}}
\end{enumerate}" >> /tmp/Words.tex
echo "\end{itemize}
\end{document}" >> /tmp/Words.tex


mv /tmp/Words.tex ~/Documents/repositories/dictionary/
pdflatex ~/Documents/repositories/dictionary/Words.tex Words.pdf
#cat ~/Documents/repositories/dictionary/Words.tex >> ~/Documents/repositories/dictionary/template.tex

#rm ~/Words.aux
#rm ~/Words.log
#rm ~/Words.out
#mv Words.pdf ~/Documents/repositories/dictionary/

remaining="$(grep -o '\\emph' ~/Documents/repositories/dictionary/Words.tex | wc -l)"
echo "The number of words contained within the document are: $remaining"

printf "\n \n \n \n$definition"
