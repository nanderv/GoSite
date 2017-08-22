package main

import (
	"github.com/gorilla/websocket"
	"net/http"
	"log"
	"encoding/json"
)

const (
	addr = "0.0.0.0:8080"
)

type Object struct{
	Name string
	Location string
}

type Location struct{
	Objects[] Object
}
type World struct{
	Rooms[] Location
}
type State struct {
	Cmd   string
	Response string
	Count int
	World World
	Position string
}

var upgrader = websocket.Upgrader{} // use default options
func echo(w http.ResponseWriter, r *http.Request) {
	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade:", err)
		return
	}
	defer c.Close()
	for {
		mt, message, err := c.ReadMessage()
		if err != nil {
			log.Println("read:", err)
			break
		}
		log.Printf("recv: %s", message)

		s := State{}
		json.Unmarshal(message, &s)
		s.Response="HOI"
		s.Count = s.Count + 1
		message, err = json.Marshal(s)
		err = c.WriteMessage(mt, message)

		if err != nil {
			log.Println("write:", err)
			break
		}
	}
}
// receive JSON type T
func main() {
	fs := http.FileServer(http.Dir("html"))
	http.HandleFunc("/echo", echo)
	http.Handle("/", fs)
	log.Fatal(http.ListenAndServe(addr, nil))
}