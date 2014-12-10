<?php

/*
 * PHP XMLRPC - How to create a XMLRPC Server
 */

//The easiest way to read an XMLRPC request is through the input stream
$request_xml = file_get_contents("php://input");

//create a basic demo method for the server to use
function say_hello($method_name, $args) {
    return "Hello ".$args[0].$args[1][0];
}

//create the XMLRPC server
$xmlrpc_server = xmlrpc_server_create();

//register the demo method to the XMLRPC server
xmlrpc_server_register_method($xmlrpc_server, "say_hello", "say_hello");

//start the server listener
header('Content-Type: text/xml');
print xmlrpc_server_call_method($xmlrpc_server, $request_xml, array());

?>
