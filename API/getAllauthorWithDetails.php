<?php
include "DBconnect.php";

$sql = SQLQuery("SELECT DISTINCT
    `Author`.`Fname`,
    `Author`.`Lname`,
    GROUP_CONCAT(`Book`.`Title`) AS 'Title',
    `Author`.`gender`,
    `Author`.`country`
FROM
    `Book`
JOIN `Author` ON `Book`.`ID_author` = `Author`.`ID_author`
GROUP BY
    `Author`.`Fname` ASC");

$AuthorDetails = [];

foreach($sql as $q){
    $AuthorDetails[] = [
        'Fname' => $q['Fname'],
        'Lname' => $q['Lname'],
        'gender' => $q['gender'],
        'country' => $q['country'],
        'Title' => $q['Title']
    ];
}

echo json_encode($AuthorDetails);

?>