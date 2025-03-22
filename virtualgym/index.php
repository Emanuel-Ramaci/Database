<?php
$servername = "localhost";
$username = "username";
$password = "password";
$dbname = "database";

// Creazione della connessione
$conn = new mysqli($servername, $username, $password, $dbname);

// Controllo connessione
if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
}

$sql = "SELECT Nome, Istruttore, Categoria, Descrizione, Prezzo, Stato FROM ClasseOnline";
$result = $conn->query($sql);

$tableContent = ""; // Inizializza la variabile per la tabella

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $tableContent .= "<tr>";
        $tableContent .= "<td>" . htmlspecialchars($row["Nome"]) . "</td>";
        $tableContent .= "<td>" . htmlspecialchars($row["Istruttore"]) . "</td>";
        $tableContent .= "<td>" . htmlspecialchars($row["Categoria"]) . "</td>";
        $tableContent .= "<td>" . htmlspecialchars($row["Descrizione"]) . "</td>";
        $tableContent .= "<td>" . htmlspecialchars($row["Prezzo"]) . "</td>";
        $tableContent .= "<td>" . htmlspecialchars($row["Stato"]) . "</td>";
        $tableContent .= "</tr>";
    }
} else {
    $tableContent = "<tr><td colspan='6'>Nessun risultato trovato</td></tr>";
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <script src="script.js"></script>
    <header>
        <h1 class="text-style animate-top">Virtual Gym</h1>
        <img src="https://media-public.canva.com/9Da-0/MAErL_9Da-0/1/s.svg" alt="Logo" class="animate-top">
        <h2>Elenco Classi Online</h2>
        <table class="table table-dark table-hover">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Istruttore</th>
                    <th>Categoria</th>
                    <th>Descrizione</th>
                    <th>Prezzo</th>
                    <th>Stato</th>
                </tr>
            </thead>
            <tbody>
                <?php echo $tableContent; ?>
            </tbody>
        </table>
        <div>
            <button class="btn btn-outline-danger" onclick="toggleLista()">Classi Online</button>
            <button class="btn btn-outline-danger" onclick="toggleLista()">Istruttori</button>
            <button class="btn btn-outline-danger" onclick="toggleLista()">Membri</button>
            <button class="btn btn-outline-danger" onclick="toggleLista()">Statistiche di allenamento</button>
        </div>
        <ul id="lista-nomi" style="display: none">
            <li>Nome 1</li>
            <li>Nome 2</li>
            <li>Nome 3</li>
        </ul>
    </header>
</body>
</html>
