#!/usr/bin/env node
// Generated by LiveScript 1.3.1
(function(){
  var docopt, fs, shelljs, doc, getOption, o, filename, cat;
  docopt = require('docopt').docopt;
  fs = require('fs');
  shelljs = require('shelljs');
  doc = shelljs.cat(__dirname + "/docs/usage.md");
  getOption = function(a, b, def, o){
    if (!o[a] && !o[b]) {
      return def;
    } else {
      return o[b];
    }
  };
  o = docopt(doc);
  filename = getOption('-f', '--file', '/dev/stdin', o);
  filename == null && (filename = '/dev/stdin');
  cat = shelljs.cat;
  fs.readFile(filename, 'utf-8', function(err, content){
    var v, interpolate;
    v = require('verbal-expressions');
    interpolate = function(fileContent){
      var e, interp;
      e = /"([^"\\]|\\.)*"/g;
      interp = false;
      return fileContent.replace(e, function(s){
        var e2, rep;
        e2 = v().beginCapture().find('#{').anythingBut("}").then("}").endCapture();
        rep = s.replace(e2, function(x){
          var e3;
          interp = true;
          e3 = v().find('#{').beginCapture().anythingBut("}").endCapture().then("}");
          return x.replace(e3, function(y, m){
            return "\" + std::string(" + m + ") + \"";
          });
        });
        if (interp) {
          return "string(" + rep + ").c_str()";
        } else {
          return rep;
        }
      });
    };
    return process.stdout.write(interpolate(content));
  });
}).call(this);
