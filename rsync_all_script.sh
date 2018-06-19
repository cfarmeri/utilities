#!/bin/bash                                                                    
#$ -S /bin/sh                                                                  
#$ -cwd                                                                       



find /home/ryomisawa/insertion_site -name "*.sh" | less > list_sh.txt
find /home/ryomisawa/insertion_site -name "*.pl" | less > list_pl.txt
find /home/ryomisawa/insertion_site -name "*.py" | less > list_py.txt

while read line ; do
    rsync -arv $line ./insertion_site
done < ./list_sh.txt

while read line ; do
    rsync -arv $line ./insertion_site
done < ./list_pl.txt

while read line ; do
    rsync -arv $line ./insertion_site
done < ./list_py.txt
