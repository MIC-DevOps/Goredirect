package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("port")

	http.HandleFunc("/config", configHandler)
	http.HandleFunc("/", redirectHandler)

	if err := http.ListenAndServe(":" + port, nil); err != nil {
		log.Fatal(err)
	}
}

func redirectHandler(writer http.ResponseWriter, request *http.Request) {
	key := request.URL.Path[1:]
	log.Println(key)

	http.Redirect(writer, request,"http://google.com", 301)
}

func configHandler(writer http.ResponseWriter, request *http.Request) {

}