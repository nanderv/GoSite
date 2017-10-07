counter = 0
require "lua.parsing.parser"
require "lua.scripts.init"

function run(line)
    local res = parse(line)

    print(res)
    if not res then
        return "{\"mode\":\"fill\", \"div\":\"content\",\"content\":\"ERROR\"}"
    end
    ret = "{\"mode\":\""..res.mode.."\", \"div\":\""..res.div.."\",\"content\":\""..res.content.."\"}"
    counter = line
    return ret
end