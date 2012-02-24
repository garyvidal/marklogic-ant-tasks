xquery version "1.0-ml";

declare variable $PIPELINE-DIRECTORY external;
declare variable $TRIGGERS-DATABASE  external;
declare variable $MODULES-DATABASE   external;
declare variable $DOMAIN-NAME        external;
declare variable $PIPELINE-NAMES     external;
declare variable $DIRECTORY-SCOPE    external;

xdmp:add-response-header("Content-Type", "text/html"),

try {
	let $cleanup :=
		xdmp:invoke("cpf-cleanup.xqy", (),
		  <options xmlns="xdmp:eval">
			<database>{xdmp:database($TRIGGERS-DATABASE)}</database>
		  </options> 
		)

	let $pipes :=
		xdmp:invoke("cpf-insert-pipelines.xqy", (
		  xs:QName("PIPELINE-DIRECTORY"), $PIPELINE-DIRECTORY,
		  xs:QName("MODULES-DATABASE"), $MODULES-DATABASE),
		  
		  <options xmlns="xdmp:eval">
			<database>{xdmp:database($TRIGGERS-DATABASE)}</database>
		  </options> 
		)

	let $domain :=
		xdmp:invoke("cpf-create-domain.xqy", (
		  xs:QName("domain-name"), $DOMAIN-NAME,
		  xs:QName("pipeline-names"), $PIPELINE-NAMES,
		  xs:QName("scope"), $DIRECTORY-SCOPE,
		  xs:QName("MODULES-DATABASE"), $MODULES-DATABASE),
		  <options xmlns="xdmp:eval">
			<database>{xdmp:database($TRIGGERS-DATABASE)}</database>
		  </options> 
		)

	let $config :=
		xdmp:invoke("cpf-create-configuration.xqy", (
		  xs:QName("domain-name"), $DOMAIN-NAME,
		  xs:QName("domain-id"), $domain[2],
		  xs:QName("MODULES-DATABASE"),$MODULES-DATABASE),
		  <options xmlns="xdmp:eval">
			<database>{xdmp:database($TRIGGERS-DATABASE)}</database>
		  </options> 
		)
	return
		("", $cleanup, $pipes, $domain[1], $config)
} catch ($e) {
	"CPF config failed: ",
	fn:string($e//*:format-string),
	xdmp:log($e)
}