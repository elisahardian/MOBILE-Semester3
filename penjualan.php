<!-- sepertinya ini tidak digunakan -->
<?php
//Mengatur header agar dapat diakses oleh berbagai sumber (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Menghubungkan ke database
require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array(); // Inisialisasi array untuk respon

    //Mengambil data dari POST request
    $id_produk = $_POST['id_produk'] ?? null;
    $harga_produk = $_POST['harga_produk'] ?? null;
    $quantity = $_POST['quantity'] ?? 1; //Default quantity
    $tanggal = date ('Y-m-d') ?? null; //Tanggal hari ini

    //Cek apakah field harga_produk dan id_produk terisi
    if (!empty($harga_produk) && !empty($id_produk)) {
        // Konveresi harga menjadi float dan bagi 1oo untuk mengurangi dua digit
        $harga_produk = floatval($harga_produk) / 100;

        //menggunakan prepared statement
        $stmt = $connect->prepare("INSERT INTO jual ( tgljual, idproduct, price, quantity) VALUES (?,?,?,?)");
        $stmt->bind_param("ssdi", $tanggal, $id_produk, $harga_produk, $quantity); // 's' = string, 'd' = double

        //menjalankan query
        if ($stmt->execute()) {
            //jika penyimpanan berhasil
            $response['value'] = 1;
            $response['message'] = 'Pembelian berhasil diproses';
        }else {
            // jika terjadi kesalahan saat menyimpan
            $response['value'] = 0;
            $response [ 'message'] = 'Gagal menyimpan data:' . $stmt->error;
        }
        
        $stmt->close
    }


}
?>