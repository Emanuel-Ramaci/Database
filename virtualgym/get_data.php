<?php
// Connessione al database
$conn = new mysqli("localhost", "username", "password", "database");

// Verifica connessione
if ($conn->connect_error) {
    die("Connessione al database fallita: " . $conn->connect_error);
}

// Esegui una query per recuperare i dati necessari
$sql = "SELECT * FROM tabella";
$result = $conn->query($sql);

// Converti i risultati della query in un array associativo
$rows = array();
while($row = $result->fetch_assoc()) {
    $rows[] = $row;
}

// Ritorna i dati come JSON
echo json_encode($rows);

// Chiudi la connessione al database
$conn->close();
?>
