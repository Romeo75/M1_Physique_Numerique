i = 1

#set terminal png
#set output 'fente_'.i.'.png'

set view map
set size ratio .9

set object 1 rect from graph 0, graph 0 to graph 1, graph 1 back
set object 1 rect fc rgb "black" fillstyle solid 1.0

#Fente
splot 'file'.i.'.dat' u 1:2:3 with points pointtype 5 pointsize 1 palette linewidth 30
set xlabel ' x( en USI)'
set ylabel ' y( en USI)'
set title 'Matrice de la fente'.i
replot

clear
set terminal x11