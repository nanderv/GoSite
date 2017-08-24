package main

import (
	"github.com/gorilla/websocket"
	"net/http"
	"log"

	"textadventure/lua"
	"fmt"
)

const (
	addr = "0.0.0.0:8080"
)


func fun(r *http.Request) bool{
	return true
}
var upgrader = websocket.Upgrader{} // use default options
func echo(w http.ResponseWriter, r *http.Request) {
	upgrader.CheckOrigin=fun
	c, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Print("upgrade:", err)
		return
	}
	filter := lua.NewGameState()
	error := filter.LoadScript("lua/test.lua")
	if error != nil{
		log.Fatal("Script not loaded")
	}
	err = filter.ValidateScript()
	if err != nil {
		panic(err.Error())
	}

	for {
		mt, message, err := c.ReadMessage()
		if err != nil {
			log.Println("read:", err)
			break
		}
		log.Printf("recv: %s", message)
		isValid, err := filter.RunCommand(string(message))
		fmt.Println(isValid)
		c.WriteMessage(mt, []byte(isValid))

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