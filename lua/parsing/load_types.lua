--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 24-8-17
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--
WORD_TYPES={}

function load_types()
    files = { "lua/parsing/dictionary/types.txt" }
    for _,f in ipairs(files) do
        local file = io.open(f, "rb")
        lines = mysplit(file:read("*a"), "\n")
        for _, line in ipairs(lines) do
            word = mysplit(line, ":")
            if word then
                WORD_TYPES[word[1]] = WORD_TYPES[word[1]] or {}
                WORD_TYPES[word[1]][#WORD_TYPES[word[1]] + 1] = {type=word[1],is=word[2]}
            end
        end
    end
end