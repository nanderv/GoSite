import { combineReducers } from 'redux'
import blobs from './reducers/blobs'


const messageApp = combineReducers({
    blobs
})

export default messageApp
