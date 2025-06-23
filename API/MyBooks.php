<?php
include "DBconnect.php";

if(isset($_POST['ID_user'])){

  $ID_user = $_POST['ID_user'];

$sql = SQLQuery("
                    SELECT `Book`.`Title`, `Book`.`Type`, `Author`.`Fname`, `Author`.`Lname`, `Invoice`.`Date`, `Invoice`.`Total`
                    FROM `Book`
                    JOIN `Author` ON `Book`.`ID_author` = `Author`.`ID_author`
                    JOIN `Order` ON `Book`.`ID_book` = `Order`.`ID_book`
                    JOIN `Invoice` ON `Invoice`.`ID_invoice` = `Order`.`ID_invoice`
                    WHERE `Invoice`.`ID_user` = '$ID_user'
                    GROUP BY `Book`.`Title` 
                    ORDER BY `Invoice`.`Date` DESC
                    ");

$MyBooks = [];

foreach($sql as $q){
    $MyBooks[] = [
        'Title' => $q['Title'],
        'Type' => $q['Type'],
        'Fname' => $q['Fname'],
        'Lname' => $q['Lname'],
        'Date' => $q['Date'],
        'Total' => $q['Total'],

    ];
}

header('Content-Type: application/json');
echo json_encode($MyBooks);
}

?>