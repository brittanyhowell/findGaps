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

	f, err := os.Open("TestSequences.fasta")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v.", err)
		os.Exit(1)
	}
	defer f.Close()

	in := fasta.NewReader(f, linear.NewSeq("", nil, alphabet.DNA))

	sc := seqio.NewScanner(in)

	// map seq method

	AllSeqs := map[string]*linear.Seq{}

	for sc.Next() {
		s := sc.Seq().(*linear.Seq)
		AllSeqs[s.Name()] = s

	}

	//fmt.Printf("Candidate sequence: \n %v \n", AllSeqs["CM001014.2_44580072-44585076_+"])
	//

	for h := range AllSeqs { // h = header

		fmt.Printf("Calculating for %v \n ", h)

		gaps := 0

		seq := AllSeqs[h]
		alpha := seq.Alphabet()
		gap := alpha.Gap()

		count := seq.Len()

		for c := 0; c < count; {

			l := seq.At(c).L
			if l == gap {
				start := c
				limit := count - c

				for g := 1; g < limit; { // FIX ME (G)

					pos := g + c
					candidate := seq.At(pos).L

					//	fmt.Printf("Position of gap: %v, sequence at gaps %v\n", pos, candidate)
					if candidate != gap {
						//						fmt.Printf("pos, not gap: %v \n", pos)
						end := pos - 1
						//					fmt.Printf("End: %v \n", end)
						c = pos
						gapLength := (end - start) + 1
						fmt.Printf("start: %v, \t end: %v, \t length of gap: %v \n", start, end, gapLength)
						break

					} else if candidate == gap {
						//						fmt.Printf("pos, gap: %v \n", pos)
						g++

					}

				}
				gaps++
			} else if l != gap {
				c++

				//fmt.Printf("Not a gap. gaps=%v \n", gaps)
			}

		}

		fmt.Printf("Sequence length: %vbp, Number of gaps: %v  \n\n", count, gaps)
	}

	//sequence := AllSeqs[h]

	//fmt.Printf("sequence: %v \n", sequence)

}
