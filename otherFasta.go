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

	f, err := os.Open("cluster_198.fasta")
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

	fmt.Printf("Candidate sequence: \n %v \n", AllSeqs["CM001014.2_44580072-44585076_+"])

	for h := range AllSeqs { //___________________ h ends up being the header
		fmt.Printf("Header: %v \n", h)
		sequence := AllSeqs[h]

		fmt.Printf("sequence: %v \n", sequence)

	}
}
