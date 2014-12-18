<?php
header('Access-Control-Allow-Origin: *');
//if they DID upload a file...
if( isset($_FILES['record']['name']) )
{
    $uploadDir = 'uploads/';
    $filename = basename( $_FILES['record']['name'] );
    $ext = pathinfo( $filename, PATHINFO_EXTENSION );
    $new = $filename . '.' . $ext;
    $uploadFile = $uploadDir . $new;
    if ( move_uploaded_file( $_FILES['record']['tmp_name'], $uploadFile ) )
    {
        echo json_encode([
            'success' => [
                'data' => array_merge( $_FILES['record'], ['new' => $new] )
            ]
            
        ]);
    }
    else
    {
        echo json_encode([
            'error' => [
                'data' => 'ERROR in uploading'
            ]
        ]);
    }
}

?>
