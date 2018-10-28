//
//  InterfaceController.swift
//  Fire TV Remote WatchKit Extension
//
//  Created by Jason Stallings on 10/28/18.
//  Copyright © 2018 Jason Stallings. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session : WCSession!
    let defaults = UserDefaults.standard
    @IBOutlet var PlayButton: WKInterfaceButton!
    @IBOutlet var UpButton: WKInterfaceButton!
    @IBOutlet var LeftButton: WKInterfaceButton!
    @IBOutlet var RightButton: WKInterfaceButton!
    @IBOutlet var DownButton: WKInterfaceButton!
    @IBOutlet var BackButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    @IBAction func Play() {
        sendKeycode(key: "85")
    }
    
    @IBAction func Up() {
        sendKeycode(key: "19")
    }
    
    @IBAction func Left() {
        sendKeycode(key: "21")
    }
    
    @IBAction func Right() {
        sendKeycode(key: "22")
    }
    
    @IBAction func Down() {
        sendKeycode(key: "20")
    }
    
    @IBAction func Back() {
        sendKeycode(key: "4")
    }
    
    func sendKeycode(key: String)  {
        if let ip = defaults.string(forKey: "ip") {
            let url = URL(string: "http://\(ip):8811/input/\(key)")!
            print(url)
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
            }
            
            task.resume()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any]) {
        print(userInfo["ip"] ?? "No IP")
        defaults.set(userInfo["ip"] ?? "", forKey: "ip")
    }

}
