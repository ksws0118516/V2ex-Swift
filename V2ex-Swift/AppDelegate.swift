//
//  AppDelegate.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/8/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

import DrawerController
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow();
        self.window?.frame=UIScreen.mainScreen().bounds;
        self.window?.makeKeyAndVisible();

        let centerNav = V2EXNavigationController(rootViewController: HomeViewController());
        let leftViewController = LeftViewController();
        let rightViewController = RightViewController();
        let drawerController = DrawerController(centerViewController: centerNav, leftDrawerViewController: leftViewController, rightDrawerViewController: rightViewController);
        
        self.window?.KVOController.observe(V2EXColor.sharedInstance, keyPath: "style", options: [.Initial,.New]) {(nav, color, change) -> Void in
            self.window?.backgroundColor = V2EXColor.colors.v2_backgroundColor;
            drawerController.view.backgroundColor = V2EXColor.colors.v2_backgroundColor
        }
        
        
        drawerController.maximumLeftDrawerWidth=230;
        drawerController.maximumRightDrawerWidth=110;
        drawerController.openDrawerGestureModeMask=OpenDrawerGestureMode.PanningCenterView
        drawerController.closeDrawerGestureModeMask=CloseDrawerGestureMode.All;
        self.window?.rootViewController = drawerController;

        V2Client.sharedInstance.drawerController = drawerController
        V2Client.sharedInstance.centerViewController = centerNav.viewControllers[0] as? HomeViewController
        V2Client.sharedInstance.centerNavigation = centerNav
        #if DEBUG
            let fpsLabel = V2FPSLabel(frame: CGRectMake(15, SCREEN_HEIGHT-40, 55, 20));
            self.window?.addSubview(fpsLabel);
        #else
        #endif
        
        SVProgressHUD.setForegroundColor(UIColor(white: 1, alpha: 1))
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.15, alpha: 0.85))
        SVProgressHUD.setDefaultMaskType(.None)
        
        /**
        DEBUG 模式下不统计任何信息，如果你需要使用Crashlytics ，请自行申请账号替换我的Key
        */
        #if DEBUG
        #else
            Fabric.with([Crashlytics.self])
        #endif
        return true
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
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

