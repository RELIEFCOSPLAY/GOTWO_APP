<?php
header('Content-Type: application/json; charset=utf-8');
include("config.php");
// Fetch data based on status
$status = $_GET['status'];
$sql = "SELECT * FROM requests WHERE status = '$status'";
$result = $conn->query($sql);

$data = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
} else {
    $data = ["message" => "No data found"];
}

// Close the connection
$conn->close();

// Return data as JSON
header('Content-Type: application/json');
echo json_encode($data);
?>
