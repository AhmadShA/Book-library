<?php

include 'DBconnect.php';

if(isset($_POST['firstName'])){

  $firstName = $_POST['firstName'];
  $lastName = $_POST['lastName'];
  $gender = $_POST['gender'];
  $country = $_POST['country'];

    $query = "INSERT INTO `Author` (`Fname`, `Lname`, `gender`, `country`) VALUES (:firstName , :lastName, :gender, :country)";

    $data = [
        ":firstName"        => $firstName,
        ":lastName"       =>  $lastName,
        ":gender"      =>   $gender,
        ":country"   =>      $country
    ];

    $result = SQLWithData($query, $data);

    if ($result) {
      echo json_encode('successAddArtist');
    } else {
      echo json_encode('faildAddArtist');
    }
  }   
?>