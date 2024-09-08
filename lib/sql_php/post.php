<?php
header('Content-Type: application/json; charset=utf-8');
include("connec.php"); 
//-------------------------------------------------------
// $action = $_POST['action'];

// if ($action == "INSERT") {
//     //insert
//     $pick_up = $_POST['pick_up'];
//     $comment_pick = $_POST['comment_pick'];
//     $at_drop = $_POST['at_drop'];
//     $comment_drop = $_POST['comment_drop'];
//     $date = $_POST['date'];
//     $time = $_POST['time'];
//     $price = $_POST['price'];
//     $status_helmet = $_POST['status_helmet'];
//     $customer_id = 1;
//     $rider_id = 1;
//     $sql = " INSERT INTO `post` (`pick_up`, `comment_pick`, `at_drop`, `comment_drop`, `date`, `time`, `price`, `status_helmet`, `customer_id`, `rider_id`) VALUES ('$pick_up', '$comment_pick', '$at_drop', '$comment_drop', '$date', '$time', '$price', '$status_helmet', '$customer_id', '$rider_id');";
//     if ($conn->query($sql)) {
//         echo "insert Sucsess";
//     } else {
//         echo "Error insert !";
//     }
// }
$sql = "SELECT * FROM post";
$result = mysqli_query($conn, $sql);

$response = array();

if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $tb_pos = array();
        $tb_pos["pick_up"] = $row['pick_up'];
        $tb_pos["commpick"] = $row['comment_pick'];
        $tb_pos["at_drop"] = $row['at_drop'];
        $tb_pos["commdrop"] = $row['comment_drop'];
        $tb_pos["date"] = $row['date'];
        $tb_pos["time"] = $row['time'];
        $tb_pos["price"] = $row['price'];
        $tb_pos["rider_id"] = $row['rider_id'];

        array_push($response, $tb_pos); 
    }
} else {
    // หากไม่มีข้อมูลในฐานข้อมูล
    $tb_pos = array();
    $tb_pos["pick_up"] = '';
    $tb_pos["commpick"] = '';
    $tb_pos["at_drop"] = '';
    $tb_pos["commdrop"] = '';
    $tb_pos["date"] = '';
    $tb_pos["time"] = '';
    $tb_pos["price"] = '';
    $tb_pos["rider_id"] = '';

    array_push($response, $tb_pos); // เพิ่ม $tb_pos ที่เป็นข้อมูลว่างเข้าใน $response
}

echo json_encode($response); // ส่งข้อมูลเป็น JSON
mysqli_close($conn);
?>
