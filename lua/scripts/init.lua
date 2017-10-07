scripts = {}

scripts.examine = function(what)
    return {mode="fill", content=what.word.. what.type, div="content"}
end
scripts.go = function(to)
    return  {mode="add", content=to.word.. to.type, div="content"}
end