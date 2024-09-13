<?php
// Connect to the database
$servername = "localhost";
$username = "root"; // Default XAMPP username
$password = ""; // Default XAMPP password (leave blank)
$dbname = "rider_status";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

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
