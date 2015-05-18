//
//  TabBarController.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 14/5/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var benefitsController = viewControllers?[2] as! UIViewController
        let benefitsImage = UIImage(named: "beneficios")
        let benefitsNew = UITabBarItem(title: "BENEFICIOS", image: benefitsImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: benefitsImage)
        benefitsController.tabBarItem = benefitsNew
        
        var smsController = viewControllers?[0] as! UIViewController
        let smsImage = UIImage(named: "mensajes")
        let smsNew = UITabBarItem(title: "MENSAJES", image: smsImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: smsImage)
        smsController.tabBarItem = smsNew
        
        var lugaresController = viewControllers?[3] as! UIViewController
        let lugaresImage = UIImage(named: "lugares")
        let lugaresNew = UITabBarItem(title: "LUGARES", image: lugaresImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: lugaresImage)
        lugaresController.tabBarItem = lugaresNew
        
        var helpController = viewControllers?[1] as! UIViewController
        let helpImage = UIImage(named: "ayudando")
        let helpNew = UITabBarItem(title: "AYUDANDO", image: helpImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: helpImage)
        helpController.tabBarItem = helpNew
        
        
        
        
        if (NSProcessInfo().operatingSystemVersion.majorVersion >= 7) {
            
            var topBar = UIView(frame: CGRectMake(0,0,self.view.frame.size.width,20))
           
            
            topBar.backgroundColor = AppDelegate.colorDark
            
            self.view.addSubview(topBar)
            
//
            
//            benefitsItem = benefitsNew
            
            
//            var firstViewController:UIViewController = UIViewController()
            // The following statement is what you need
//            var customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(named: "YOUR_IMAGE_NAME")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "YOUR_IMAGE_NAME"))
//            firstViewController.tabBarItem = customTabBarItem
            
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
