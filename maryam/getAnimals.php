<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

// Include the connection.php file
include 'connection.php';

// Check connection
if (!$con) {
    die("Connection failed: " . mysqli_connect_error());
}

// Check if a search query is provided
if (isset($_GET['name'])) {
    $name = mysqli_real_escape_string($con, $_GET['name']);
    $sql = "SELECT * FROM animals WHERE name LIKE '%$name%'";
} else {
    $sql = "SELECT * FROM animals";
}

$result = mysqli_query($con, $sql);

if ($result) {
    $animalArray = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $animalArray[] = $row;
    }

    echo json_encode($animalArray);
    mysqli_free_result($result);
} else {
    http_response_code(500); // Internal Server Error
    echo "Error: " . mysqli_error($con);
}

// Close the database connection
mysqli_close($con);
?>
