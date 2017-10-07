const blobs = (state = [], action) => {
    switch (action.type) {

        case 'RECEIVE':
            let tr = [...state,{text: action.text, id: action.id}]
            console.log(tr)
            console.log(action.text, action.id, );
            return tr
        default:
            console.log("THERE");
            return state;
    }
}
export default blobs;