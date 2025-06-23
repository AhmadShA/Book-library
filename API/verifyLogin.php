<?php

include 'DBconnect.php';

if(isset($_POST['username'])){
    
    $username = $_POST['username'];
    $password = SHA1($_POST['password']); 

    
    $users = SQLQuery("SELECT * FROM `User`  WHERE (`userName` = '$username' OR `Email` = '$username')
                                AND `Password` = '$password'");
    
    
    if(count($users) > 0){
        $ID = $users[0]['ID_uer'];
        $admin = $users[0]['isAdmin'];
        if(($username == 'Admin' || $username == 'admin') && $admin == 1){
            $response = array('status' => 'successAdminLogin', 'ID' => $ID);
        }else{
        $response = array('status' => 'successLogin', 'ID' => $ID);
        }
        echo json_encode($response);
    }else{
        echo json_encode(array('status' => 'errorLogin'));
    }
}

?>