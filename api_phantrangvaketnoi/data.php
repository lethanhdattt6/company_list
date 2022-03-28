<?php
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");
header("Content-type: text/html; charset=utf-8");
include 'config.php';

if (isset($_GET['pageno'])) {
    $pageno = $_GET['pageno'];
} else {
    $pageno = 1;
}
$no_of_records_per_page = 100;
$offset = ($pageno-1) * $no_of_records_per_page; 

$result = $connect->query("SELECT * FROM information_ma_so_thue LIMIT $offset, $no_of_records_per_page");
$list = array();

if($result->num_rows > 0) {
    while($row = mysqli_fetch_assoc($result)){
        $list[] = $row;
    } 
    echo json_encode($list);
}

$connect->close();
return;

?>