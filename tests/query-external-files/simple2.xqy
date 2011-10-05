xquery version "1.0-ml";
let $map := map:map()
let $puts := (
   map:put($map,"1","1"),
   map:put($map,"2","2"),
   map:put($map,"3","3")
   )
return
  <map>{$map}</map>