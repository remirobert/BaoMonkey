<?php
require '_header.php';
?>
<!DOCTYPE html>
<head>
	<title>CSS Free Templates with jQuery Slider</title>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
	<link rel="shortcut icon" href="css/images/favicon.ico" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<!--[if IE 6]>
		<link rel="stylesheet" href="css/ie6.css" type="text/css" media="media" />
		<script src="js/png-fix.js" type="text/javascript" charset="utf-8"></script>
	<![endif]-->
	<script src="js/jquery-1.6.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/jquery.jcarousel.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/jquery-func.js" type="text/javascript" charset="utf-8"></script>	
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<div id="top">
			<!-- Shell -->
			<div class="shell">
				<div class="top-nav">
					<ul>
					    <li class="first nobg"><a href="#" title="Default welcome msg!">Default welcome msg!</a></li>
					    <li><a href="#" title="Login">Login</a></li>
					    <li><a href="#" title="My Account">My Account</a></li>
					    <li><a href="#" title="My Wishlist">My Wishlist</a></li>
					    <li class="nobg"><a href="panier.php" class="bag" title="My Bag" id="count">My Bag <?php echo $panier->count() ?> items</a></li>
					</ul>
				</div>
				<div id="search">
					<form action="" method="post">
						<input type="text" class="field" value="Quick search..." title="Quick search..." />
					</form>
				</div>
				<div class="cl">&nbsp;</div>
			</div>
			<!-- End Shell -->
		</div>
		<!-- End Top -->
		<!-- Main -->
		<div id="main">
			<!-- Shell -->
			<div class="shell">
				<!-- Header -->
				<div id="header">
					<h1 id="logo"><a href="#" class="notext" title="Shopper Friend">Shopper Friend</a></h1>
					<div id="navigation">
						<ul>
						    <li><a href="#" class="active" title="For Boys"><span>For Boys</span></a></li>
						    <li><a href="#" title="For Girls"><span>For Girls</span></a></li>
						    <li><a href="#" title="Common"><span>Common</span></a></li>
						</ul>
					</div>
					<div class="cl">&nbsp;</div>
				</div>
				<!-- End Header -->