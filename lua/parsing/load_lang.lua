--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 24-8-17
-- Time: 15:40
-- To change this template use File | Settings | File Templates.
--
function get_word_def(str)
    if string.sub(str,1,1)=="#" then
        local w = string.sub(str,2)
        return {type=w}
    end
    local l = mysplit(str,":")
    return {word=l[1],type=l[2]}
end
function get_SENTENCE(str)
    local s = {}
    str = mysplit(str, ">")

    local words = mysplit(str[1], " ")
    for _,word in ipairs(words)do
        s[#s+1]=get_word_def(word)
    end
    s.func = mysplit(str[2], " ")

    return s

end
SENTENCES = {}
function load_sentences()
    files = { "lua/parsing/lang/base.txt"}
    for _,f in ipairs(files) do
        local file = io.open(f, "rb")
        lines = mysplit(file:read("*a"), "\n")
        for _, line in ipairs(lines) do
            SENTENCES[#SENTENCES+1] = get_SENTENCE(line)
            SENTENCES[#SENTENCES].orig = line
        end
    end
end