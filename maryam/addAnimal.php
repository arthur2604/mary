<?php
include 'connection.php';

$jsonData = file_get_contents('php://input');
$data = json_decode($jsonData, true);

if ($data !== null) {
    $name = mysqli_real_escape_string($con, $data['name']);
    $category_id = mysqli_real_escape_string($con, $data['category_id']);
    $imageURL = mysqli_real_escape_string($con, $data['image_url']);

    // Assuming you have a 'categories' table with 'id' and 'name' columns
    // You may need to adjust the query based on your actual table structure
    $categoryQuery = "SELECT id FROM categories WHERE name = '$category_id'";
    $categoryResult = mysqli_query($con, $categoryQuery);
    $categoryRow = mysqli_fetch_assoc($categoryResult);
    $category_id = $categoryRow['id'];

    $sql = "INSERT INTO animals (name, category_id, image_url) VALUES ('$name', '$category_id', '$imageURL')";
    mysqli_query($con, $sql) or die("can't add record");

    echo "Animal Added";
} else {
    http_response_code(400); // Bad Request
    echo "Invalid JSON data";
}

mysqli_close($con);
?>
