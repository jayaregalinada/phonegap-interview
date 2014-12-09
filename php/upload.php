<?php
function randomString($length = 6) {
    $str = "";
    $characters = array_merge(range('A','Z'), range('a','z'), range('0','9'));
    $max = count($characters) - 1;
    for ($i = 0; $i < $length; $i++)
    {
        $rand = mt_rand(0, $max);
        $str .= $characters[$rand];
    }
    return $str;
}
//if they DID upload a file...
if( isset($_FILES['photo']['name']) )
{
    $uploadDir = 'uploads/';
    $filename = basename( $_FILES['photo']['name'] );
    $ext = pathinfo( $filename, PATHINFO_EXTENSION );
    $new = md5( randomString(10) ) . '.' . $ext;
    $uploadFile = $uploadDir . $new;
    if ( move_uploaded_file( $_FILES['photo']['tmp_name'], $uploadFile ) )
    {
        echo json_encode([
            'success' => [
                'data' => array_merge( $_FILES['photo'], ['new' => $new] )
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
