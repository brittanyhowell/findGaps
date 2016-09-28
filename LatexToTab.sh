#!/bin/bash
# Script to take gapSummary table and convert it into tab delimited table.


# Messes up because of amphisands and whatnot
cat gapSummary.txt | sed s/\\\\//g |  awk '{print $1 "\t" $3 "\t" $5 "\t" $7 "\t" $9 "\t" $11 "\t" $13  }' > gapsLongTable.txt


# cat gapSummary.txt | sed s/\\\\//g |  awk '{print $1 "\t" $3 "\t" $5 "\t" $7  }' > gapsTable.txt