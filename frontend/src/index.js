import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import messageApp from './reducers'
import App from './components/App'
import { receiveAction } from './actions/base'
let store = createStore(messageApp)

render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('root')
)
console.log(receiveAction("A"));
store.dispatch(receiveAction("B"));
store.dispatch(receiveAction("B"));
store.dispatch(receiveAction("B"));
store.dispatch(receiveAction("B"));

var connection = new WebSocket('ws://localhost:8080/echo');
connection.onopen = function () {
    Send("go north")
};
// Log errors
connection.onerror = function (error) {
    console.log('WebSocket Error ' + error);
};
function Send(msg){
    connection.send(msg)
}
// Log messages from the server
connection.onmessage = function (e) {
    console.log(e)
    store.dispatch(receiveAction(e.data));
    setTimeout(()=>{
    Send("go north")},100);
};