<?php

if (!isset($_POST["f4"]) || $_POST["f4"] != "email@email.com") {
    header("Location: index.html");
    exit;
}

if ("POST" != getenv("REQUEST_METHOD")) {
    header("Location: index.html");
    exit;
}

if ("" == getenv("HTTP_USER_AGENT") || "" == getenv("HTTP_REFERER")) {
    header("Location: index.html");
    exit;
}

$name = $_POST['f1'];
$email_address = $_POST['f2'];
$message = $_POST['f3'];

//Validate first
if (empty ($name))
    $error = "You must enter your name.";
elseif (empty ($email_address))
    $error = "You must enter your email address.";
elseif (!preg_match("/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/", $email_address))
    $error = "You must enter a valid email address.";
elseif (empty ($message))
    $error = "You must enter a message.";
elseif (preg_match("/http/i", $message) )
    $error = "No URLs in the message allowed for SPAM prevention!";
elseif (preg_match("/http/i", $name) )
    $error = "No URLs as Name allowed for SPAM prevention!";
if (isset($error)) {
    header("Location: /index.html?e=".urlencode($error)); exit;
}


$email_content = "Name: $name \n";
$email_content .= "Email Address: $email_address\n";
$email_content .= "Message:\n\n$message";

$email_from = 'alex@adbakke.com';//<== update the email address
$email_subject = "ADBakke.com Form - " . substr($message, 0, 30);
$email_success = 'Thank You for Contacting Me';
$to = "alex@adbakke.com";//<== update the email address
$headers = "From: $email_from \r\n";
$headers .= "Reply-To: $visitor_email \r\n";

//Send the email!
mail($to,$email_subject,$email_content,$headers);
//done. redirect to thank-you page.
header("Location: index.html?e=".urlencode($email_success)); exit;


?>
