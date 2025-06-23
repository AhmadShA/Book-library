<?php
include "DBconnect.php";

$sql = SQLQuery("SELECT `ID_author`, `Fname`, `Lname` FROM `Author` ORDER BY `Fname` ASC");

$authors = [];

foreach($sql as $q){
    $artists[] = [
        'ID_author' => $q['ID_author'],
        'Fname' => $q['Fname'],
        'Lname' => $q['Lname']
    ];
}

header('Content-Type: application/json');
echo json_encode($authors);

?>