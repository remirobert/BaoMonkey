<!-- 

BAOMONKEY
Website 2014 - Version 1

 -->

<?php

    include 'includes/header.php';
 
?>


<body id="page-top" data-spy="scroll" data-target=".navbar-custom">

    <!-- NAVIGATION -->
    <!-- La barre est hidden sur iphone et meme categorie -->
    <nav class="navbar navbar-custom navbar-fixed-top hidden-xs hidden-sm hidden-md" role="navigation" style="opacity:0.9;">
        <div class="container">
            <div class="navbar-header page-scroll"></div>
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
                <ul class="nav navbar-nav">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li class="page-scroll">
                        <a href="#team">Team</a>
                    </li>
                    <li class="page-scroll">
                        <a href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- END NAVIGATION -->

    <!-- HOMESCREEN -->
    <section id="home" class="intro">
        <div class="intro-body">
            <div id="logo" class="hidden-xs hidden-sm visible-md, hidden-md">
                <img class="logo" src="img/logo.png">
            </div>
            <div id="iphone" class="hidden-xs hidden-sm visible-md, hidden-md">
                <img class="iphone" src="img/iphone.png">
                <video class="game_vid" width="312" height="661" autoplay loop>
                  <source src="vid/baomonkey.mp4" type="video/mp4" />
                  <source src="vid/baomonkey.ogg" type="video/ogg" />
                </video>
            </div>
            <div class="container content-intro">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="page-scroll">
                            <a href="#team" class="btn btn-circle">
                                <i class="fa fa-angle-down animated"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END HOMESCREEN -->

    <!-- STAFF -->
    <section id="team" class="container text-center" style="margin-top:80px;">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-lg-12">
                <div class="box">                           
                    <div class="icon">
                        <div class="image"><img class="coco" src="img/coco.png"></div>
                        <div class="info">
                            <h3 class="title">About BaoMonkey</h3>
                            <p>
                                Bao is a little monkey who live in a beautiful tree but some lamber jack, hunter, commando and many others want destroy it. Help Bao to protect his home! se the coconuts to stun your ennemies but do attentions bananas and plums. Sometimes, you can take a shield to protect you! BaoMonkey is a final project of 2nd year of French IT School, EPITECH.
                            </p>
                        </div>
                    </div>
                    <div class="space"></div>
                </div> 
            </div>
        </div>
        <div class="staff">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 member margin-bot">
                        <img class="hats" src="img/capuchon/blue.png">
                        <div>
                            <span>
                                <img src="img/team/photo_jeremy.png" alt="" />
                            </span>
                            <h4>Jeremy Peltier</h4>
                            <h5>developer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 member margin-bot">
                    <img class="hats" src="img/capuchon/green.png">
                        <div>
                            <span>
                                <img src="img/team/photo_remi.png" alt="" />
                            </span>
                            <h4>Rémi Hillairet</h4>
                            <h5>developer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 member margin-bot">
                    <img class="hats" src="img/capuchon/red.png">
                        <div>
                            <span>
                                <img src="img/team/photo_remir.png" alt="" />
                            </span>
                            <h4>Rémi Robert</h4>
                            <h5>developer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 member margin-bot">
                    <img class="hats" src="img/capuchon/yellow.png">
                        <div>
                            <span>
                                <img src="img/team/photo_brieuc.png" alt="" />
                            </span>
                            <h4>Brieuc de La Fouchardière</h4>
                            <h5>developer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 member margin-bot">
                    <img class="hats" src="img/capuchon/black.png">
                        <div>
                            <span>
                                <img src="img/team/photo_alex.png" alt="" />
                            </span>
                            <h4>Alexandre Quintin</h4>
                            <h5>Game designer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-4 member margin-bot">
                    <img class="hats" src="img/capuchon/pink.png">
                        <div>
                            <span>
                                <img src="img/team/photo_romain.gif" alt="" />
                            </span>
                            <h4>Romain Combe</h4>
                            <h5>developer</h5>
                            <ul class="list-inline social">
                                <li><a href=""><i class="fa fa-linkedin animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-github-alt animated sized"></i></a></li>
                                <li><a href=""><i class="fa fa-link animated sized"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END STAFF -->

    <!-- CONTACT -->
    <section id="contact" class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-lg-12">
                    <div class="box">                           
                        <div class="icon">
                            <div class="image"><img class="coco" src="img/coco.png"></div>
                            <div class="info">
                                <h3 class="title">Contact us</h3>
                                <p>Be free to contact us !</p>
                            </div>
                        </div>
                        <div class="space"></div>
                    </div> 
                </div>
            <div class="col-md-12">
                <form role="form" method="post" action="form.php">
                    
                    <div class="required-field-block">
                        <input name="name" type="text" placeholder="Name" class="form-control">
                    </div>
                    
                    <div class="required-field-block">
                        <input name="email" type="text" placeholder="Email" class="form-control">
                    </div>

                    <div class="required-field-block">
                        <textarea name="comment" rows="3" class="form-control" placeholder="Message"></textarea>
                    </div>
                    
                    <p style="text-align: center;"><input type="submit" value="Send"></p>
                </form>
            </div>
        </div>
    </section>
    <!-- END CONTACT -->


    <!-- FOOTER -->
    <footer>
        <div class="container text-center" style="padding-top:50px;">
            <div class="row">
                <img style="max-width: 100%;width: 300px;" src="img/logo.png">
                <p>® Copyright 2014 - BaoMonkey - <a href="">PressKit</a></p>
            </div>
        </div>
    </footer>
    <!-- END FOOTER -->

<?php

    include 'includes/footer.php';

?>