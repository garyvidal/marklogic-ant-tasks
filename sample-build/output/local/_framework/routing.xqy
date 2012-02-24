xquery version "1.0-ml";

module namespace routing ="http://www.xquerrail-framework.com/routing";

import module namespace config = "http://www.xquerrail-framework.com/config"
at "config.xqy";

declare variable $routes := config:get-routes();

declare function route-valid($route as element(routing:route))
{
  fn:true()
};
declare function map-to-params($map as map:map)
{
  fn:string-join(
   for $k in map:keys($map)
   order by $k
   return
   for $v in map:get($map,$k)
   return 
      fn:concat($k,"=",fn:string($v))
  ,"&amp;")
};

(:~
 : returns the default route for a given url
~:)
declare function get-route($url as xs:string)
{
  let $params-map := map:map()
  let $params := if(fn:contains($url,"?")) then fn:substring-after($url,"?") else ()
  let $path   := if(fn:contains($url,"?")) then fn:substring-before($url,"?") else $url
  let $request-method := fn:lower-case(xdmp:get-request-method())
  let $matching-routes := $routes//routing:route[fn:matches($path,./@pattern,"sx")]
  let $matching-route := 
    (for $route in $matching-routes
     where 
        if($route/@method) 
        then if($route/@method/fn:lower-case(.) eq $request-method) 
             then $route
             else ()
        else if($route[fn:not(@method)]) 
             then $route
             else ()
     return 
       $route)[1]
  let $is-resource := $matching-route/@is-resource
  let $route := 
      if($is-resource eq "true") then
        if($matching-route/routing:to)
        then fn:concat($matching-route/(@to,routing:to)[1],"?",$params)
        else if($matching-route/routing:replace) then
             fn:concat(fn:replace($path,$matching-route/@path,$matching-route/routing:replace),"?",$params)
        else if($matching-route/routing:prepend) then
             fn:concat($matching-route/routing:prepend,$path,"?",$params)
        else fn:error($config:ERROR-RESOURCE-CONFIGURATION,"Route @is-resource requires (to,replace,prepend)",$matching-route)
      else if($matching-route) then
        let $controller := $matching-route/routing:default[@key eq "_controller"]
        let $parts      := fn:tokenize(fn:normalize-space($controller),":")
        let $add-params := 
          ( map:put($params-map,"_route",fn:data($matching-route/@id)),
            for $p in $matching-route/routing:param
            return
              if(fn:matches($p,"\$\d")) 
              then map:put($params-map,$p/@key, fn:replace($path,$matching-route/@pattern,$p))
              else map:put($params-map,$p/@key,$p/text())
          )
        let $defaults   := 
            for $i in (1 to 4) 
            let $value := fn:string(fn:subsequence($parts,$i,1))
            return (:Need to support regex parameters:)
              if ($i eq 1) then map:put($params-map,"_application",$value)
              else if($i eq 2) then 
                  if(fn:matches($value,"^\$\d+")) 
                  then map:put($params-map,"_controller",fn:replace($path,$matching-route/@pattern,$value))
                  else map:put($params-map,"_controller",($value,config:default-controller())[1])
              else if($i eq 3) then
                   if(fn:matches($value,"^\$\d+")) 
                  then map:put($params-map,"_action",fn:replace($path,$matching-route/@pattern,$value))
                  else map:put($params-map,"_action",($value,config:default-action())[1])
              else if($i eq 4) then                   
                  if(fn:matches($value,"^\$\d+")) 
                  then map:put($params-map,"_format",fn:replace($path,$matching-route/@pattern,$value)) 
                  else map:put($params-map,"_format",($value,config:default-format())[1])
              else ()
       return
          fn:concat(config:get-front-controller(),"?",map-to-params($params-map),if($params ne "") then fn:concat("&amp;",$params) else ())
     else fn:error(xs:QName("NO-MATCHING-ROUTE"),"No matching route",$path)
  return (xdmp:log(("route:",$route),"debug"),$route)
};