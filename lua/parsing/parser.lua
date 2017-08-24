--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 24-8-17
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--
require "lua.parsing.load_words"
require "lua.parsing.load_lang"
require "lua.parsing.load_types"

function mysplit(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0 -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

eq_type = function(from, to)
    if from == to then
        return true
    end

    for k, v in ipairs(WORD_TYPES[from]) do

        if v.is and eq_type(v.is, to) then
            return { type = v.type, word = word }
        end
    end
    return false
end
function match_type(word, type)
    for k, v in ipairs(WORDS[word]) do
        if eq_type(v.type, type) then
            return { type = v.type, word = word }
        end
    end
end

function match_def(word, def)

    if not WORDS[word] then
        return false
    end
    if def.word and def.word == word then
        return { type = def.type, word = word }
    else
        for _, v in ipairs(WORDS[word]) do
            if eq_type(v.type, def.type) and v.as and match_def(v.as, def) then
                return { type = v.type, word = word }
            end
        end
    end

    return match_type(word, def.type)
end

load_words()
load_sentences()
load_types()

function parse(str)
    str = mysplit(str, " ")
    local failed = {}
    local b = {}
    local i = 1
    for _, word in ipairs(str) do
        for _, sentence in ipairs(SENTENCES) do
            b[sentence] = b[sentence] or {}
            if not (failed[sentence]) then
                local a = match_def(word, sentence[i])
                print(a)

                b[sentence][#b[sentence] + 1] = a
                print(#b[sentence])

                if not a then
                    failed[sentence] = true
                else
                end
            end
        end
        i = i + 1
    end
    for _, sentence in ipairs(SENTENCES) do
        if not failed[sentence] then
            local params = {}
            print(sentence.orig)
            for i = 2, #sentence.func do
                local iz = tonumber(sentence.func[i])
                params[#params + 1] = b[sentence][iz]


            end
            scripts[sentence.func[1]](unpack(params))
        end
    end
end