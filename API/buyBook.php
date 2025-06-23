<?php

include 'DBconnect.php';

if(isset($_POST['CreditCard'])){
  $ID_user = $_POST['IDUser'];
  $Total = $_POST['Total'];
  $CreditCard = $_POST['CreditCard'];
  $ID_book = $_POST['ID_book'];

    $query = "INSERT INTO `Invoice` (`ID_user`, `Date`, `Total`, `CreditCard`) VALUES (:ID_user , CURRENT_DATE, :Total, :CreditCard)";

    $data = [
        ":ID_user"        => $ID_user,
        ":Total"      =>   $Total,
        ":CreditCard"   =>      $CreditCard
    ];

    $resultBuy = SQLWithData($query, $data);
    
    $lastInvoiceId = SQLlastID($query);
    
     $queryOrder = "INSERT INTO `Order`( `ID_book`, `ID_invoice`) VALUES (:ID_book , :ID_invoice)";

    $dataOrder = [
        ":ID_book"        => $ID_book,
        ":ID_invoice"      =>   $lastInvoiceId
    ];

    $resultOrder = SQLWithData($queryOrder, $dataOrder);
    

    if ($resultBuy && $resultOrder) {
      echo json_encode(array('statusBuy' => 'successBuy'));
    } else {
      echo json_encode(array('statusBuy' => 'faildBuy'));
    }
  }
  else {
    echo json_encode('Please provide a credit card number.');
}
?>