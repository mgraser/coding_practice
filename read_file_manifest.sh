#! /bin/bash

find $1 -name *fastq.gz > file

for line in file
do
grep 'ATAC' $line >> atacfile.txt
grep 'RNA' $line | grep -v 'HG002' >> rnaseqfile.txt
grep -e 'HiC' -e 'WGBS' $line >> wgbsfile.txt
grep -e 'ONT' -e 'HG002' $line >> norep.txt
done

paste <(sort -n atacfile.txt | grep "_R1" | awk -F "/" '{ print $8"\t"$7 }') <(sort -n atacfile.txt | grep "R1" | tr [_] ["/t"] | sed  's/-/\t/g' | grep -o -we 'A' -we 'B' -we '.......A' -we '.......B') <(sort -n atacfile.txt | grep "_R1") <( sort -n atacfile.txt | grep "_R2")

paste <(sort -n rnaseqfile.txt | grep "_R1" | awk -F "/" '{ print $8"\t"$7 }') <(sort -n rnaseqfile.txt | grep "R1" | tr [/] ["/t"] | grep -o -we 'Dataset_1' -we 'Dataset_2') <(sort -n rnaseqfile.txt | grep "_R1") <( sort -n rnaseqfile.txt | grep "_R2")

paste <(sort -n wgbsfile.txt | grep "_R1" | awk -F "/" '{ print $8"\t"$7 }') <(sort -n wgbsfile.txt| grep "R1" | tr [_] ["/t"] | grep -o -we 'L00[0-9]') <(sort -n wgbsfile.txt | grep "_R1") <(sort -n wgbsfile.txt | grep "_R2")

paste <(sort -n norep.txt | grep "_R1" | awk -F "/" '{ print $8"\t"$7"\t""-" }') <(sort -n norep.txt | grep "_R1") <(sort -n norep.txt | grep "_R2")

rm file atacfile.txt rnaseqfile.txt wgbsfile.txt norep.txt
