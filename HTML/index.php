<?php
DEFINE('DBUNAME','MySQlName');
DEFINE('DBPW','MySQLPassword');
DEFINE('DBHOST','MySQLHostName');

$mysqlconn = new mysqli(DBHOST,DBUNAME,DBPW);
if($mysqlconn->connect_errno){
  echo'Error:'.$mysqlconn->connect_errno;
  echo "<br/>Connection failed: " . $mysqlconn->connect_error;
}else {
  echo "Connected successfully";
}

phpinfo();
?>
