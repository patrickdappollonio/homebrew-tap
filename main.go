package main

import (
	"fmt"
	"os"

	"github.com/patrickdappollonio/homebrew-tap/tapgen"
)

func main() {
	if err := tapgen.Run(); err != nil {
		fmt.Fprintln(os.Stderr, "error:", err.Error())
		os.Exit(1)
	}
}
