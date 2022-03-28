<?php

$servername = "localhost";
$username = "root";
$password = "";
$db_name = "data_company";

$connect = mysqli_connect($servername,$username,$password,$db_name);
mysqli_set_charset($connect, 'UTF8');

if($connect->connect_error) {
    die("Connection Failed: ". $connect->connect_error);
    return;
}else {
    // echo "Connected"
    return $connect;
}

?>