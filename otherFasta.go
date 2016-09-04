// attempt at reading a fasta
package main

import (
	"fmt"
	"os"

	"github.com/biogo/biogo/alphabet"
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

	//	fmt.Printf("Printing for the sake of printing: \n %v, \n %v \n", in, f)

	s, err := in.Read()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	t := s.Name()
	fmt.Printf("More printing: \n  %s", t)
}
