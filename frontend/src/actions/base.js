let nextTodoId = 0
export const receiveAction = text => {
    return {
        type: 'RECEIVE',
        id: nextTodoId++,
        text
    }
}

export const sendAction = (command, text) => {
    return {
        type: 'SEND',
        command, text
    }
}

