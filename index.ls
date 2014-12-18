
{docopt} = require('docopt')
require! 'fs'

shelljs = require('shelljs')

doc = shelljs.cat(__dirname+"/docs/usage.md")


get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]

o = docopt(doc)


filename      = get-option('-f' , '--file'     , '/dev/stdin'  , o)

filename ?= '/dev/stdin'

{cat} = shelljs

process.stdin.setEncoding('utf8')
process.stdin.on 'readable', ->
    content = process.stdin.read()
    if content != "" and content?
        v = require('verbal-expressions')

        interpolate = (file-content) ->
            e = /"([^"\\]|\\.)*"/g
            var interp
            interp := false
            file-content.replace e, (s) ->
                e2 = v().beginCapture().find('#{').anythingBut("}").then("}").endCapture()
                rep = s.replace e2, (x) ->
                    interp := true
                    e3 = v().find('#{').beginCapture().anythingBut("}").endCapture().then("}")
                    x.replace e3, (y,m) ->
                        return "\" + std::string(#m) + \""
                if interp 
                    return "std::string(#rep).c_str()"
                else 
                    return rep 
        process.stdout.write interpolate(content)







