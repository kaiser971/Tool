#!/bin/bash
if [[ "$USE_MYSQL" =~ ^[Yy]$ ]]; then
  echo "📝 Création du fichier index.php de démonstration..."
  # Création de la page index.php de démonstration avec le nom du projet dynamique
  cat <<EOL > "$PROJECT_NAME/public/index.php"
<?php
declare(strict_types=1);

\$projectName = getenv('PROJECT_NAME') ?: '$PROJECT_NAME';

\$databaseConfig = [
    'host' => getenv('MYSQL_HOST') ?: 'mysql',
    'dbname' => getenv('MYSQL_DATABASE') ?: 'app_db',
    'user' => getenv('MYSQL_USER') ?: 'user',
    'password' => getenv('MYSQL_PASSWORD') ?: 'password',
];

function checkDatabaseConnection(\$config): string {
    try {
        \$dsn = "mysql:host={\$config['host']};dbname={\$config['dbname']};charset=utf8mb4";
        \$pdo = new PDO(\$dsn, \$config['user'], \$config['password'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]);
        return "<span style='color:green;'>✅ Connexion à MySQL réussie !</span>";
    } catch (PDOException \$e) {
      \$return = "<span style='color:red;'>❌ Erreur MySQL : " . \$e->getMessage() . "</span></br>";
      \$return .= "<span style='color:red;'>❌ MYSQL_HOST : " . \$config['host']. "</span></br>";
      \$return .= "<span style='color:red;'>❌ MYSQL_USER : " . \$config['user'] . "</span></br>";
      \$return .= "<span style='color:red;'>❌ MYSQL_PASSWORD : " . \$config['password'] . "</span></br>";
      \$return .= "<span style='color:red;'>❌ MYSQL_DATABASE : " . \$config['dbname']. "</span></br>";
      return \$return;
    }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenue sur <?= htmlspecialchars(\$projectName) ?></title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; background-color: #f4f4f4; }
        h1 { color: #333; }
        .container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); display: inline-block; }
        .status { font-size: 1.2em; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Bienvenue sur <?= htmlspecialchars(\$projectName) ?> !</h1>
        <p>Votre environnement PHP, MySQL et Nginx fonctionne correctement.</p>
        <div class="status">
            <?= checkDatabaseConnection(\$databaseConfig); ?>
        </div>
    </div>
</body>
</html>
EOL
  echo "✅ Page index.php de démonstration créée avec le nom du projet : $PROJECT_NAME"
fi