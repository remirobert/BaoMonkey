<?php
require '_header.php';
?>
<p>Product-------Name-------Price------Quantity------Subtotal------Actions</p>


<form method="POST" action="panier.php">
<?php

$ids = array_keys($_SESSION['panier']);
if(empty($ids)){
	$products = array();
	echo 'Empty panier';
}
else{
	$products = $DB->query('SELECT * FROM products WHERE id IN ('.implode(',', $ids).')');
}
foreach ($products as $product):
?>
	<img src="css/images/<?php echo $product->id;?>.jpg" alt="Product Image 1" />
	<span class="order model"><?php echo $product->name; ?></span>
	<?php echo $product->price; ?>$<span class="sub-text"></span>
	<span> Quantity : <input type="number" name="panier[quantity][<?php echo $product->id; ?>]" value="<?php echo $_SESSION['panier'][$product->id]; ?> " width="30">
	<a href="panier.php?delPanier=<?php echo $product->id; ?>" class="del"><img src="css/images/delete.png"></a>
</br>
<?php endforeach; ?>
<input type="submit" value="Recalculer"
	</br><span><?php echo $panier->total(); ?> euros</span>
</form>
<a href="index.php"></br>Acceuil</a>