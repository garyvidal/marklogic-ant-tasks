xquery version "1.0-ml";
import module namespace admin = "http://marklogic.com/xdmp/admin" 
      at "/MarkLogic/admin.xqy";
declare namespace g = "http://marklogic.com/xdmp/group";

declare variable $TASK-NAME as xs:string external;
declare variable $DATABASE  as xs:string external;
declare variable $MODULES-DATABASE as xs:string external;
declare variable $MODULES-ROOT as xs:string external;
declare variable $TASK-USER as xs:string external;

let $config := admin:get-configuration()
let $group  := admin:group-get-id($config, "Default")
let $configured :=  
    admin:group-get-scheduled-tasks($config,$group)[g:task-path eq $TASK-NAME]
return
if($configured) 
then ()
else 
    let $new-task := admin:group-minutely-scheduled-task(
      $TASK-NAME,
      "/",
      5,
      xdmp:database($DATABASE),
      xdmp:database($MODULES-DATABASE),
      xdmp:user($TASK-USEDR), 
      ())
    let $addTask := admin:group-add-scheduled-task($config,$group, $new-task)
    return 
      admin:save-configuration($addTask)