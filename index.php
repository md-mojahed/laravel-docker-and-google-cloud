<?php
$host = 'mysql';
$dbname = getenv('MYSQL_DATABASE');
$username = getenv('MYSQL_USER');
$password = getenv('MYSQL_PASSWORD');
$env = getenv('APP_ENV');

?>
<!DOCTYPE html>
<html>

<head>
    <title>My PHP App - <?= strtoupper($env) ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        .info {
            background: #f0f0f0;
            padding: 15px;
            margin: 10px 0;
        }
    </style>
</head>

<body>
    <h1>🚀 My PHP Application - <?= strtoupper($env) ?> Development</h1>

    <?php
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        echo "<p class='success'>✅ Database connection: <strong>Successful!</strong></p>";

        // Test query
        $stmt = $pdo->query("SELECT COUNT(*) as count FROM users");
        $result = $stmt->fetch();
        echo "<p>👥 Users in database: <strong>" . $result['count'] . "</strong></p>";

        // Show all users
        echo "<h3>Users List:</h3>";
        $stmt = $pdo->query("SELECT * FROM users ORDER BY created_at DESC");
        $users = $stmt->fetchAll();

        if ($users) {
            echo "<ul>";
            foreach ($users as $user) {
                echo "<li>" . htmlspecialchars($user['name']) . " - " . htmlspecialchars($user['email']) . "</li>";
            }
            echo "</ul>";
        }
    } catch (PDOException $e) {
        echo "<p class='error'>❌ Database Connection Failed!</p>";
        echo "<p class='error'>Error: " . $e->getMessage() . "</p>";
    }
    ?>

    <div class="info">
        <h3>📋 System Information</h3>
        <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
        <p><strong>Server Time:</strong> <?php echo date('Y-m-d H:i:s'); ?></p>
        <p><strong>Environment:</strong> <?= strtoupper($env) ?></p>
    </div>
</body>

</html>