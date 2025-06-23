<?php

include 'DBconnect.php';

if(isset($_POST['Title']) && isset($_POST['ID_artist'])){

  $Title = $_POST['Title'];
  $Type = $_POST['Type'];
  $Price = $_POST['Price'];
  $ID_author = $_POST['ID_author'];

    $query = "INSERT INTO `book` (`Title`, `Type`, `Price`, `ID_author`) VALUES (:Title , :Type, :Price, :ID_author)";

    $data = [
        ":Title"        => $Title,
        ":Type"       =>  $Type,
        ":Price"      =>   $Price,
        ":ID_artist"   =>      $ID_author
    ];

    $result = SQLWithData($query, $data);

    if ($result) {
      echo json_encode('successAddBook');
    } else {
      echo json_encode('faildAddBook');
    }
  }   
?>