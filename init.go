package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println()
	fmt.Println("Hello world!")
	for i := 0; i < 5; i++ {
		fmt.Printf(".")
		time.Sleep(time.Second)
	}

	fmt.Println()
}
