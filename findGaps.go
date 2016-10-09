// attempt at reading a fasta
package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/biogo/biogo/alphabet"
	"github.com/biogo/biogo/io/seqio"
	"github.com/biogo/biogo/io/seqio/fasta"
	"github.com/biogo/biogo/seq/linear"
)

var (
	outpath      string
	clusSequence string
)

func main() {
	flag.StringVar(&clusSequence, "inSequence", "", "name of input sequence")
	flag.StringVar(&outpath, "outpath", "", "path to output dir")
	flag.Parse()

	cluster := clusSequence
	f, err := os.Open(cluster)
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

	// Creating a file for the output
	file := fmt.Sprintf("%vgaps_%v", outpath, cluster)
	out, err := os.Create(file)
	if err != nil {
		log.Fatalf("failed to create %s: %v", file, err)
	}
	defer out.Close()

	for h, seq := range AllSeqs {

		gaps := 0
		longGaps := 0
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
				if gapLength > 12 {
					longGaps++
					//fmt.Printf("start: %v, \t end: %v, \t length of gap: %v \n", start, end, gapLength)
					fmt.Fprintf(out, "%s \t %v \t %v \t %v \n", h, start, end, gapLength)
				}

			}
			if l == gap && c == seq.Len()-1 {
				end = c
				gapLength = (end - start) + 1
				gaps++
				if gapLength > 12 {
					longGaps++
					//fmt.Printf("start: %v, \t end: %v, \t length of gap: %v \n", start, end, gapLength)
					fmt.Fprintf(out, "%s \t %v \t %v \t %v \n", h, start, end, gapLength)
				}

			}
		}
		fmt.Printf("Sequence: %v \t length: %vbp, \t Total gaps: %v, \t Gaps > 5bp: %v  \n", h, seq.Len(), gaps, longGaps)
	}
}
