xquery version "1.0-ml";

module namespace controller = "http://www.condenast.com/dam/2.0/controller/default";

import module namespace request = "http://www.xquerrail-framework.com/request"
    at "/_framework/request.xqy";
    
import module namespace response = "http://www.xquerrail-framework.com/response"
    at "/_framework/response.xqy";
 
declare function controller:initialize($request)
{(
   request:initialize($request),
   response:set-format(request:format()),
   response:set-template("main"),
   response:set-view("info")
)};

declare function controller:main()
{
  controller:index()
};

declare function controller:index()
{
 (
    response:set-controller("default"),
    response:set-template("main"),
    response:set-view("home"),
    response:set-title("Welcome"),
    response:add-httpmeta("cache-control","public"),
    response:response()
  )
};
declare function controller:admin()
{
 (
    response:set-controller("default"),
    response:set-template("main"),
    response:set-view("admin"),
    response:set-title("DAM Administration"),
    response:add-httpmeta("cache-control","public"),
    response:response()
  )
};


declare function controller:staging()
{
 (
    response:set-controller("default"),
    response:set-template("main"),
    response:set-view("staging"),
    response:set-title("Staging"),
    response:add-httpmeta("cache-control","public"),
    response:response()
  )
};