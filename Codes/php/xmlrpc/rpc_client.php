<?php

/*
 * PHP XMLRPC - How to create a XMLRPC Server
 */
 
//call the "say_hello" method of the XMLRPC Server
//and pass "John" as the first parameter
$request = xmlrpc_encode_request("say_hello", array('John', array(1,2)));
//create the stream context for the request
$context = stream_context_create(array('http' => array(
    'method' => "POST",
    'header' => "Content-Type: text/xml\r\nUser-Agent: PHPRPC/1.0\r\n",
    'content' => $request
)));

//URL of the XMLRPC Server
$server = 'http://localhost/xmlrpc/rpc_server.php';
$file = file_get_contents($server, false, $context);
//decode the XMLRPC response
$response = xmlrpc_decode($file);
//display the response
echo $response;
?>
