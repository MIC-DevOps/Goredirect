package main

import (
	"log"
	"net/http"
	"os"
)

var port string

func main() {
	if envPort := os.Getenv("port"); envPort != "" {
		port = envPort
	}

	log.Println(port)

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