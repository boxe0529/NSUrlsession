//
//  ViewController.swift
//  NSUrlsession
//
//  Created by Apple on 15/12/23.
//  Copyright © 2015年 Apple. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url:String="https://www.baidu.com"
        func AnnotationImageURLRequest() -> String{
            
            let request = NSMutableURLRequest(URL: NSURL(string: url)!)
            //        let request = NSURLRequest(URL: NSURL(string: url)!)
            request.timeoutInterval = 10
            let session = NSURLSession.sharedSession()
            session.dataTaskWithRequest(request) { (data:NSData?, respose:NSURLResponse?, error:NSError?) -> Void in
                if error == nil {
                    print("no error")
                    self.urldata = NSString(data: data!, encoding:NSUTF8StringEncoding)
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                            
                            let innerdefaults = NSUserDefaults.standardUserDefaults()
                            innerdefaults.setObject(self.urldata, forKey: "innerdefaults")
                            innerdefaults.synchronize()
                    })
                    
                }else {
                    print("error")
                    let innerdefaults = NSUserDefaults.standardUserDefaults()
                    innerdefaults.setObject("my innerdefaults", forKey: "innerdefaults")
                    innerdefaults.synchronize()
                    let alertcontroller = UIAlertController(title: "错误", message: "未连接上服务器", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: nil)
                    alertcontroller.addAction(okAction)
                    self.presentViewController(alertcontroller, animated: true, completion: nil)
                }
                
            }
            let outerdefaults = NSUserDefaults.standardUserDefaults()
            let outerurldata = outerdefaults.objectForKey("innerdefaults")  as! String
            return outerurldata
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

