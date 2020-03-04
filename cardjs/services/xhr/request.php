<?php
    include('main.php');
    $fn = json_decode($_GET['fn'], false);
    $class = new dataProcess();
    $class->$fn($obj = json_decode($_GET['data'], false));
?>