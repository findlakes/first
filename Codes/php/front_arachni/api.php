<?php

// Method: POST, PUT, GET etc
// Data: array("param" => "value") ==> index.php?param=value

function CallAPI($method, $url, $data = false)
{
    $curl = curl_init();

    switch ($method)
    {
        case "POST":
            curl_setopt($curl, CURLOPT_POST, 1);

            if ($data)
                curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
            break;
        case "PUT":
            curl_setopt($curl, CURLOPT_PUT, 1);
            break;
        default:
            if ($data)
                $url = sprintf("%s?%s", $url, http_build_query($data));
    }

    // Optional Authentication:
    curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
    curl_setopt($curl, CURLOPT_USERPWD, "username:password");

    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

	//set cookie
	$cookie_file = "_ga=GA1.1.1865970223.1400818850; csrftoken=APPjUQVNtI5Sh56L1T2t5eNLIdGKkS94; _arachni_webui_session=VGora1pkelkzWnZNN1ZBandSQ2xURlQ0UlRpb015VGpJQnpydlpUaVBGNzhEUUw1Q1BVV1c5cnFUaHpuQkhReXhhamtDRXdJU3J4MHAzRWVxL2xwSDY5UG1WV29QQ1pVYW9JTklORGJ3VzJ3Z3VVbEFJS0dhUzVDZDJVYk81NmdRV1BBWVhvRDgra2J4NjI0YmQrWXRVa3Y2RHN1MElsS00yUElsWjRsZ3pkbkUwaHFZSzNrejhoUUsyRWNidUM3VHVYN3dhWTJXcHVURFlyRnlWWGlMQnh0ekUraGZSSE5EYUlCdEd6TTJtaGtqK2VLbFlJUTkwM0VpMTZ5MFdNZ01XV3FGNDZmYTVJQ1kyK3EweFk4ZEE9PS0talY0KzBmb2tnRkw2cXVtUWJjM1g2UT09--23901cc1714c99f952842f6630dda6fa2869cccb";
	curl_setopt($curl, CURLOPT_COOKIE, $cookie_file);

    $result = curl_exec($curl);

    curl_close($curl);

    return $result;
}

?>
