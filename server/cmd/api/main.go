package main

import (
	"fmt"
	"net/http"
)

func main() {

	// 新しいServeMuxのインスタンスの作成
	mux := http.NewServeMux()

	// routingの登録
	mux.HandleFunc("/demo", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello, this is a demo endpoint !!")
	})

	// サーバーの起動してmuxを渡す
	fmt.Println("Serving on :8080...")
	if err := http.ListenAndServe(":8080", mux); err != nil {
		panic(err)
	}
}
