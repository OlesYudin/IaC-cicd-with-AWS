<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous"/>
		<link rel="stylesheet" href="css/style.css" />
		<title>PRNG for password</title>
	</head>
	<body>
		<header>
			<div class="title">
				<h1>Generation of pseudo-random passwords!</h1>
				<p>
				Generation of pseudo-random passwords based on entropy operating system based on the Linux kernel
				</p>
			</div>
		</header>
		<!-- Request new password -->
		<div class="form-output">
			<form action="" method="POST">
				<input type="submit" class="btn btn-success" value="Get administrator password" name="get_passwd" 	id="getPasswd"/>
			</form>
		</div>
		<!-- Show new password -->
		<div class="password-block">
			<p>New password:</p>		
			<?php include "get_password.php";?>
		</div>
		<!-- Get private IP of Instance -->
		<div class="ip-block">
			<p>Private IP-addres:</p>		
			<?php echo shell_exec('hostname -i'); ?>
		</div>
		<!-- Get public IP of Instance -->
		<div class="ip-block">
			<p>Public IP-addres:</p>		
			<?php echo shell_exec('curl https://ipinfo.io/ip'); ?>
		</div>
	</body>
</html>