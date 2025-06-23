<?php
include "DBconnect.php";

$sql = SQLQuery("SELECT `ID_book`, `Title`, `Type`, `Price`, `Author`.`Fname`, `Artist`.`Lname` FROM `Book`,Author WHERE `Book`.`ID_author` = `Author`.`ID_author` ORDER BY `Title` ASC");

$books = [];

foreach($sql as $q){
    $books[] = [
        'ID_book' => $q['ID_book'],
        'Title' => $q['Title'],
        'Type' => $q['Type'],
        'Price' => $q['Price'],
        'Fname' => $q['Fname'],
        'Lname' => $q['Lname']
    ];
}

header('Content-Type: application/json');
echo json_encode($songs);

?>