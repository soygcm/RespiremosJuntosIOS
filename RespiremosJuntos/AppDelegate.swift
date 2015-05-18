//
//  AppDelegate.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
     //#0E8A82
    static let colorDark = UIColor(red: 0x0E/255.0, green: 0x8A/255.0, blue: 0x82/255.0, alpha: 1.0 )


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        window?.tintColor = UIColor(red: 0x4f/255, green: 0xe8/255, blue: 0xab/255, alpha: 1.0)
    Parse.setApplicationId("TgMyg4eDIlxjLIDsdjKqbFMnXA0dpF4URTvVgfz6", clientKey: "GKWTEGDGISG9mfKd96f2mCaDQtXiLQSAdl4QQMj3")
        
        PFFacebookUtils.initializeFacebook()
        
        if (NSProcessInfo().operatingSystemVersion.majorVersion >= 7) {
            
            application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
            
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.7)], forState: UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: UIControlState.Selected)
        
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: UIControlState.Normal)
        
//        UITabBar.appearance().ti = UIColor(white: 1.0, alpha: 0.7)
        
//        UIView.appearance().cont
        
//        UITabBar.appearance().selectionIndicatorImage = UIImage().im
//        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor yellowColor] }
//        forState:UIControlStateNormal];
//        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
//        forState:UIControlStateSelected];
        
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }


    func applicationWillTerminate(application: UIApplication) {
        PFFacebookUtils.session().close()
    }


}

