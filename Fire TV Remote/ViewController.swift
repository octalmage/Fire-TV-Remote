//
//  ViewController.swift
//  Fire TV Remote
//
//  Created by Jason Stallings on 10/28/18.
//  Copyright © 2018 Jason Stallings. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    var session : WCSession!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var IPAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if let ip = defaults.string(forKey: "ip") {
            IPAddress.text = ip
        }
        
        if WCSession.isSupported() {
            
            session = WCSession.default
            session.delegate = self
            session.activate() 
        }
    }
    
    @IBAction func Click(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(IPAddress.text ?? "", forKey: "ip")
        print(IPAddress.text ?? "No Ip")
        session.transferUserInfo(["ip" : IPAddress.text ?? ""])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }


}

