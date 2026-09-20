<?php
// creamos la variable server que contendra el nombre del servidor
$server = 'localhost';
// definir el nombre de nuestro usuario
$username = 'root';
$password = '';
// agregar el nombre de la base de datos
$database = 'php_login_database';

try {
  // variable conn que va a guardar la conexion
  $conn = new PDO("mysql:host=$server;dbname=$database;", $username, $password);
} catch (PDOException $e) {
  // si obtiene el error que acabe con el proceso y le diga Connection Failed y que lo concatene con el error en el metodo getMessage
  die('Connection Failed: ' . $e->getMessage());
}

?>