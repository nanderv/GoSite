--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 24-8-17
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--
WORDS = {}
function WORD(arr)
    local a = {}
    a.name = arr[1]
    if a.name == "" then
        return false
    end
    a.type = arr[2]
    a.as = arr[3]
    if a.as and a.type == "" and #WORDS[a.as] == 1 then
        if WORDS[a.as] then
            a.type = WORDS[a.as][1].type
        end
    end
    return a
end

function load_words()
    files = { "lua/parsing/dictionary/verbs.txt", "lua/parsing/dictionary/nouns.txt", "lua/parsing/dictionary/directions.txt" }
    for _, f in ipairs(files) do
        local file = io.open(f, "rb")
        print(f)
        lines = mysplit(file:read("*a"), "\n")
        for _, line in ipairs(lines) do
            word = WORD(mysplit(line, ":"))
            if word then
                WORDS[word.name] = WORDS[word.name] or {}
                WORDS[word.name][#WORDS[word.name] + 1] = word
            end
        end
    end
end