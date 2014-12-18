<?php

$config = [
    'to' => 'jayaregalinada@gmail.com',
    'subject' => 'New Applicant - ',
    'url' => 'http://i.ubl.ph/uploads/',
];

$data = json_decode(file_get_contents('php://input'), true);
$new = json_encode( $data );

$message  = "APPLICANT: ". $data['email'] ."\r\n";
$message .= "==================\r\n";
foreach ($data['records'] as $key => $value) {
    $message .= $config['url'] . $value;
    $message .= "\r\n";
}
$message .= "==================\r\n";
$mail = mail( $config['to'], $config['subject'] . $data['email'], $message);

echo $new;

?>
