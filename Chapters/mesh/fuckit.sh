#!/bin/bash

for plot in plots/*.pdf
do
    gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sOutputFile=$plot.tmp -f $plot
    mv $plot.tmp $plot
done
            
