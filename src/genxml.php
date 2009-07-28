<?php
require("config.php");

function parseToXML($htmlStr) 
{ 
$xmlStr=str_replace('<','&lt;',$htmlStr); 
$xmlStr=str_replace('>','&gt;',$xmlStr); 
$xmlStr=str_replace('"','&quot;',$xmlStr); 
$xmlStr=str_replace("'",'&#39;',$xmlStr); 
$xmlStr=str_replace("&",'&amp;',$xmlStr); 
return $xmlStr; 
} 

// Opens a connection to a MySQL server
$connection=mysql_connect (localhost, $username, $password);
if (!$connection) {
  die('Not connected : ' . mysql_error());
}

// Set the active MySQL database
$db_selected = mysql_select_db($database, $connection);
if (!$db_selected) {
  die ('Can\'t use db : ' . mysql_error());
}

// Select all the rows in the markers table
$query = "SELECT * FROM markers WHERE 1";
$result = mysql_query($query);
if (!$result) {
  die('Invalid query: ' . mysql_error());
}


//header("Content-type: text/xml");

// Start XML file, echo parent node
echo "<?xml version=\"1.0\" ?><markers>";

// Iterate through the rows, printing XML nodes for each
while ($row = @mysql_fetch_assoc($result)){
  // ADD TO XML DOCUMENT NODE
	echo "<loc><name>" . $row['name'] . "</name>";
	echo "<address>" . $row['address'] . "</address>";
	echo "<lat>" . $row['lat'] . "</lat>";
	echo "<lng>" . $row['lng'] . "</lng>";
	echo "<type>" . $row['type'] . "</type></loc>";
}
  /*echo '<marker ';
  echo 'name="' . parseToXML($row['name']) . '" ';
  echo 'address="' . parseToXML($row['address']) . '" ';
  echo 'lat="' . $row['lat'] . '" ';
  echo 'lng="' . $row['lng'] . '" ';
  echo 'type="' . $row['type'] . '" ';
  echo '/>';
}*/

// End XML file
echo '</markers>';

?>