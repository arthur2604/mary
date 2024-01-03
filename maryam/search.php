<?php
include 'connection.php';

// Check if the 'name' parameter is set in the request
if(isset($_GET['name'])) {
    // Sanitize and get the search term
    $searchTerm = mysqli_real_escape_string($con, $_GET['name']);

    // SQL query to search for the animal by name
    $sql = "SELECT * FROM animals WHERE name LIKE '%$searchTerm%'";

    // Perform the query
    $result = mysqli_query($con, $sql);

    if ($result) {
        // Fetch result rows as an associative array
        $animalsArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $animalsArray[] = $row;
        }

        // Output the JSON-encoded result
        echo json_encode($animalsArray);
    } else {
        // Handle query error
        echo json_encode(array('error' => 'Error executing the query'));
    }

    // Free result set
    mysqli_free_result($result);
} else {
    // Handle missing 'name' parameter
    echo json_encode(array('error' => 'Name parameter is missing'));
}

// Close the database connection
mysqli_close($con);
?>
