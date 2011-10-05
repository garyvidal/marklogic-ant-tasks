xquery version "1.0-ml";

declare variable $NAME as xs:string external;
declare variable $TIMES as xs:integer external;

for $i in (1 to $TIMES) 
return
 fn:concat("HELLO ",$NAME)
 