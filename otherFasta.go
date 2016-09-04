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

		n := s.Name()

		//	fmt.Printf("sequence:  %v \n", AllSeqs[n])
		//	fmt.Printf("AllSeqs:  %v \n", s)

		var match bool

		match = AllSeqs[n] == s

		fmt.Println(match)
	}

	//	fmt.Printf("refstore: \n %v \n", AllSeqs.Name())

	name := len(AllSeqs)

	fmt.Printf("length:  %v \n", name)

}
