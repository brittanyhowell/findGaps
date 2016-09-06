// attempt at reading a fasta
package main

import (
	"fmt"
	"os"

	"github.com/biogo/biogo/alphabet"
	"github.com/biogo/biogo/io/seqio"
	"github.com/biogo/biogo/io/seqio/fasta"
	"github.com/biogo/biogo/seq/linear"
)

func main() {

	f, err := os.Open("cluster_425.fasta")
	//f, err := os.Open("TestSequences.fasta")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v.", err)
		os.Exit(1)
	}
	defer f.Close()

	in := fasta.NewReader(f, linear.NewSeq("", nil, alphabet.DNA))
	sc := seqio.NewScanner(in)
	AllSeqs := map[string]*linear.Seq{}

	for sc.Next() {
		s := sc.Seq().(*linear.Seq)
		AllSeqs[s.Name()] = s
	}

	for h := range AllSeqs { // h = header

		fmt.Printf("Calculating for %v \n", h)

		gaps := 0
		seq := AllSeqs[h]
		alpha := seq.Alphabet()
		gap := alpha.Gap()

		var start, end, gapLength int
		state := 0

		for c := 0; c < seq.Len(); c++ {

			l := seq.At(c).L

			if l == gap && state == 0 {
				state = 1
				start = c
			}
			if l != gap && state == 1 {
				state = 0
				end = c - 1
				gapLength = (end - start) + 1
				gaps++
				fmt.Printf("start: %v, \t end: %v, \t length of gap: %v \n", start, end, gapLength)
			}
			if l == gap && c == seq.Len()-1 {
				end = c
				gapLength = (end - start) + 1
				gaps++
				fmt.Printf("start: %v, \t end: %v, \t length of gap: %v \n", start, end, gapLength)
			}
		}
		fmt.Printf("Sequence length: %vbp, Number of gaps: %v  \n\n", seq.Len(), gaps)
	}
}
