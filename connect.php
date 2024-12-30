<?php
    $connect=new
    mysqli("localhost", "root", "", "db_latihan");
    if($connect) {
    } else { 
        echo "koneksi gagal"; //opsional hanya untuk debugging.
        exit();
    }
?>