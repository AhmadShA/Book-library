<?php

include 'DBconnect.php';

if(isset($_POST['username'])){
  $username = $_POST['username'];
  $password = SHA1($_POST['password']);
  $firstName = $_POST['firstName'];
  $lastName = $_POST['lastName'];
  $address = $_POST['address'];
  $email = $_POST['email'];
  $isAdmin = 0;


  $users = SQLQuery("SELECT * FROM `User` WHERE `userName` = '$username' OR `Email` = '$email' ");


  if(count($users) > 0){
      
      echo json_encode('errorExiste');
  }
  else{
    $query = "INSERT INTO `User` (`userName`, `Password`, `Fname`, `Lname`, `Address`, `Email`,`isAdmin`) VALUES (:username , :password , :firstName , :lastName, :address, :email, 0)";

    $data = [
        ":username"     =>  $username,
        ":password"       =>  $password,
        ":firstName"        => $firstName,
        ":lastName"       =>  $lastName,
        ":address"      =>   $address,
        ":email"   =>      $email
    ];

    $result = SQLWithData($query, $data);

    if ($result) {
      echo json_encode(array('success' => true, 'message' => 'Registration successful!'));
    } else {
      echo json_encode(array('success' => false, 'message' => 'Registration failed!'));
    }
  }   
}
?>