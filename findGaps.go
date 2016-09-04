// attempt at reading a fasta
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/biogo/biogo/alphabet"
	"github.com/biogo/biogo/io/seqio"
	"github.com/biogo/biogo/io/seqio/fasta"
	"github.com/biogo/biogo/seq"
	"github.com/biogo/biogo/seq/linear"
)

func main() {

	//Opening files
	f, err := os.Open("cluster_198.fasta")
	if err != nil {
		log.Printf("error: could not open %s to read %v", f, err)
	}
	defer f.Close()

	// Reading in sequences
	var v []seq.Sequence
	r := fasta.NewReader(f, linear.NewSeq("", nil, alphabet.DNA))

	sc := seqio.NewScanner(r)

	for sc.Next() {
		v = append(v, sc.Seq())
	}

	if sc.Error() != nil {
		log.Fatalf("failed to read sequences: %v", sc.Error())
	}

	length := len(v)

	fmt.Printf("number of sequences: %v \n", length)
}
