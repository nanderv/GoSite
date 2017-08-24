counter = 0
require "lua.parsing.parser"
require "lua.scripts.init"

function run(line)
    parse(line)
    ret = "{\"Response\":\"HOI"..counter.."\"}"
    counter = line
    return ret
end