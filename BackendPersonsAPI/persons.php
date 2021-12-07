<?php
header("Access-Control-Allow-Origin: *");

echo json_encode(array((object)["name"=>"John","city"=>"Berlin","job"=>"Teacher"],(object)["name"=>"Mark","city"=>"Oslo","job"=>"Doctor"]));
?>