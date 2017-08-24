package lua

import (

"errors"
"github.com/yuin/gopher-lua"

)

type GameState struct {
	state                    *lua.LState
	exceptionHandlerFunction *lua.LFunction
}

func NewGameState() *GameState {
	state := lua.NewState()

	filter := &GameState{
		state: state,
	}
	filter.exceptionHandlerFunction = state.NewFunction(
		filter.exceptionHandler)
	return filter
}

func (f *GameState) exceptionHandler(L *lua.LState) int {
	panic("exception in lua code")
	return 0
}
func (f *GameState) LoadScript(filename string) error {
	return f.state.DoFile(filename)
}
func (f *GameState) ValidateScript() error {
	fn := f.state.GetGlobal("run")
	if fn.Type() != lua.LTFunction {
		return errors.New("Function 'filter' not found")
	}
	return nil
}

func (f *GameState) RunCommand(event string) (string, error) {
	fn := f.state.GetGlobal("run")

	f.state.Push(fn.(*lua.LFunction))
	f.state.Push(lua.LString(event))

	// one argument and one return value
	err := f.state.PCall(1, 1, f.exceptionHandlerFunction)
	if err != nil {
		return "", err
	}

	top := f.state.GetTop()
	returnValue := f.state.Get(top)
	if returnValue.Type() != lua.LTString {
		return "", errors.New("Invalid return value")
	}

	return lua.LVAsString(returnValue), err
}

