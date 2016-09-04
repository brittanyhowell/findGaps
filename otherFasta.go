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

	// //New byte map method
	// seqMap := make(map[string][]byte)
	// var seqName string
	// for _, line := range bytes.Split(fileBytes, []byte{'\n'}) {

	// 	line = bytes.TrimSpace(line)
	// 	if len(line) == 0 {
	// 		continue
	// 	}

	// 	// Hit an identifier line
	// 	if line[0] == '>' {
	// 		seqName = string(line[1:])

	// 	} else {
	// 		// Append here since multi-line DNA strings are possible
	// 		if seqName == "" {
	// 			return fmt.Errorf("bioutils.ReadFASTAFile(): missing sequence name in FASTA file"), nil
	// 		}
	// 		for _, byt := range line {
	// 			seqMap[seqName] = append(seqMap[seqName], byt)
	// 		}
	// 	}
	// }

	// map seq method

	AllSeqs := map[string]*linear.Seq{}

	for sc.Next() {
		s := sc.Seq().(*linear.Seq)
		AllSeqs[s.Name()] = s

	}
	// making a dash letter to compare
	// var hyphen []byte
	// hyphen = make([]byte, 1)
	// hyphen[0] = '-'
	// dash := alphabet.BytesToLetters(hyphen)
	// fmt.Printf("dash: %v \t \n", dash)

	//fmt.Printf("Candidate sequence: \n %v \n", AllSeqs["CM001014.2_44580072-44585076_+"])
	var gaps int
	for h := range AllSeqs { // h = header
		gaps = 0
		//fmt.Printf("Header: %v \n", h)

		seq := AllSeqs[h]
		count := seq.Len()

		fmt.Printf("seq: %v \t count: %v \n", h, count)

		alpha := seq.Alphabet()
		//indexOf := alpha.LetterIndex()
		gap := alpha.Gap()

		//fmt.Printf("gap %v %v \n", gap, indexOf)

		for c := 0; c < count; c++ {

			l := seq.At(c).L
			if l == gap {
				gaps++
			}

		}
		fmt.Printf("gaptotal: %v \n", gaps)
	}

	//sequence := AllSeqs[h]

	//fmt.Printf("sequence: %v \n", sequence)

}
