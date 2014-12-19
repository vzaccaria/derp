
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

v = require('verbal-expressions')

interp = (prefix, decorator, string) -->
    let decorator
        placeholder = v().beginCapture().find(prefix).anythingBut("}").then("}").endCapture()
        var found
        found := false
        final-string = string.replace placeholder, (complete-placeholder) ->
            found := true

            inner-placeholder = v().find(prefix).beginCapture().anythingBut("}").endCapture().then("}")

            complete-placeholder.replace inner-placeholder, (complete, inner-content) ->
                return "\" + std::string(#{decorator inner-content}) + \""

        return final-string


process.stdin.setEncoding('utf8')
process.stdin.on 'readable', ->
    content = process.stdin.read()
    if content != "" and content?
        
        interpolate = (file-content) ->
            is-string = /"([^"\\]|\\.)*"/g

            file-content.replace is-string, (s) ->

                final-string = s |> interp('##{', (-> "std::to_string(#it)")) |> interp('#{', (-> it))

                if final-string != s 
                    return "std::string(#final-string).c_str()"
                else 
                    return final-string 
        process.stdout.write interpolate(content)







