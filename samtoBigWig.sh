#! /bin/bash
#$ -S /bin/sh
#$ -cwd 

###
#date:2015.12.25
#author:ryomisawa
#description:sam to BigWig conveter
###

echo PATH=${PATH}:/home/ryomisawa/opt/UCSC_Genome_Browser/

genome_sizes="/home/ryomisawa/database/mm9_chrom.sizes"

name=$(basename $1 .sam)

if [ -e ${genome_sizes} ]; then 
    if [ ! -e $name.bam ]; then 
        samtools view -Sb $name.sam > $name.bam
    fi

    if [ ! -e $name.bed ]; then
    bedtools bamtobed -i $name.bam > $name.bed
    fi

    if [ ! -e $name.+.bedGraph ]; then
        awk '$6=="+"' $name.bed | sort > $name.+.bed
        bedtools genomecov -i $name.+.bed -g ${genome_sizes} -bg > $name.+.bedGr
aph
    fi

    if [ ! -e $name.-.bedGraph ]; then
        awk '$6=="-"' $name.bed | sort > $name.-.bed
        bedtools genomecov -i $name.-.bed -g ${genome_sizes} -bg > $name.-.bedGr
aph
    fi

    /home/ryomisawa/opt/UCSC_Genome_Browser/bedGraphToBigWig $name.+.bedGraph ${
genome_sizes} $name.+.bw
    /home/ryomisawa/opt/UCSC_Genome_Browser/bedGraphToBigWig $name.-.bedGraph ${
genome_sizes} $name.-.bw

else 
    echo "Error:${genome_sizes} is not found."
fi
