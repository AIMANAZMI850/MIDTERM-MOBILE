<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$sqlloadsubjects = "SELECT * FROM tbl_subjects";
$result = $conn->query($sqlloadsubjects);
if ($result->num_rows > 0) {
    $subjects["subjects"] = array();
while ($row = $result->fetch_assoc()) {
        $subjectlist = array();
        $subjectlist['subject_id'] = $row['subject_id'];
        $subjectlist['subject_name'] = $row['subject_name'];
        $subjectlist['subject_description'] = $row['subject_description'];
        $subjectlist['subject_price'] = $row['subject_price'];
        $subjectlist['tutor_id'] = $row['tutor_id'];
        $subjectlist['subject_sessions'] = $row['subject_sessions'];
        $subjectlist['subject_rating'] = $row['subject_rating'];
        array_push($subjects["subjects"],$subjectlist);
    }
    $response = array('status' => 'success', 'data' => $subjects);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
