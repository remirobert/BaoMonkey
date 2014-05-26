
<?php require 'header.php';  ?>

<?php
$DB->query('SELECT * FROM products');
?>
				<!-- Slider -->
				<div id="main-slider">
					<div id="slider-holder">
						<ul>
						    <li>
						    	<img src="css/images/slider-image-1.jpg" alt="Slider Image 1" />
						    	<div class="cnt">
						    		<h4>Vestibulum rhoncus ultrices elementum</h4>
						    		<h2>Suspendisse non sem tellus</h2>
						    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fringilla mattis nisl, sit amet tincidunt.</p>
						    		<span class="price"><span class="dollar">$</span> 1599<span class="sub-text">.99</span></span>
						    		<a href="#" class="btn notext" title="Order Now">Order Now</a>
						    		<div class="cl">&nbsp;</div>
						    	</div>
						    </li>
						    <li>
						    	<img src="css/images/slider-image-1.jpg" alt="Slider Image 1" />
						    	<div class="cnt">
						    		<h4>Vestibulum rhoncus ultrices elementum</h4>
						    		<h2>Suspendisse non sem tellus</h2>
						    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fringilla mattis nisl, sit amet tincidunt.</p>
						    		<span class="price"><span class="dollar">$</span> 1599<span class="sub-text">.99</span></span>
						    		<a href="#" class="btn notext" title="Order Now">Order Now</a>
						    		<div class="cl">&nbsp;</div>
						    	</div>
						    </li>
						    <li>
						    	<img src="css/images/slider-image-1.jpg" alt="Slider Image 1" />
						    	<div class="cnt">
						    		<h4>Vestibulum rhoncus ultrices elementum</h4>
						    		<h2>Suspendisse non sem tellus</h2>
						    		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fringilla mattis nisl, sit amet tincidunt.</p>
						    		<span class="price"><span class="dollar">$</span> 1599<span class="sub-text">.99</span></span>
						    		<a href="#" class="btn notext" title="Order Now">Order Now</a>
						    		<div class="cl">&nbsp;</div>
						    	</div>
						    </li>
						</ul>
					</div>
					<div class="nav">
						<a href="#" title="First Slide">&nbsp;</a>
						<a href="#" title="Second Slide">&nbsp;</a>
						<a href="#" title="Third Slide">&nbsp;</a>
					</div>
				</div>
				<!-- End Slider -->
				<!-- Content -->
				<div id="content">
					<!-- Case -->
					<div class="case">
						<h3>newest</h3>
						<!-- Row -->
						<?php $products = $DB->query('SELECT * FROM products'); ?>
						<?php foreach ($products as $product): ?>
						<div class="row">
							<ul>
							    <li>
									<a  class="addPanier" title="Product 1" href="addpanier.php?id=<?php echo $product->id; ?>">
										<img src="css/images/<?php echo $product->id;?>.jpg" alt="Product Image 1" />
										<span class="order model"><?php echo $product->name; ?></span>
										<span class="order">catalog number: <span class="number">1925</span></span>
										<span class="order"><span class="buy-text">Buy Now</span><span class="price"><span class="dollar">$</span>
										<?php echo $product->price; ?><span class="sub-text"></span></span></span>
									</a>
							    </li>
							</ul>
							<div class="cl">&nbsp;</div>
						</div>
						<?php endforeach ?>
						<!-- End Row -->
						
						<!-- End Products Slider -->
					</div>
					<!-- End Case -->
				</div>
				<!-- End Content -->
			</div>
			<!-- End Shell -->
		</div>
		<!-- End Main -->
		<div id="footer-push" class="cl">&nbsp;</div>
	</div>
	<!-- End Wrapper -->
<?php require 'footer.php'; ?>