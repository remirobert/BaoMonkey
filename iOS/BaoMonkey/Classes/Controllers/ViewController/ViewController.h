//
//  ViewController.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "MainMenu.h"
#import "Settings.h"

@interface ViewController : UIViewController {
    MainMenu *mainMenu;
    Settings *settingsMenu;
}

@end
