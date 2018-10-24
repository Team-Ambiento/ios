//
//  ViewController.swift
//  Ambiento
//
//  Created by Lennart Kobosil on 20.10.18.
//  Copyright © 2018 JugendHackt. All rights reserved.
//

import UIKit
import Alamofire


let Serveripv4 = "159.69.212.203:\(ServerPort)"
let Serveripv6 = "2a0c:7287:4a48:222:8c04:9bd2:3aa0:78b4"
let ServerPort = 8080
let key = "MzMxNzYzNTc1MTYwMDcxMzpkVG5UdXA2NEVDN2pFWTlSRXFHTWhUTlJwb0JCeFpOQWJobkl1SndWakRuM2NGTHREQzpUN2xmM01qUDY0NmxyeHI3cEUzQkpCNmhWTjZieU1uZHpFVXRESVdjRUVHd1ZnVzFrNjp5S25GWXdIUDd0dzdad0VxNDF1dmtlTGZ0ZGhLblY0aXBlZkRzSTNIQ3p0YzM3bTFkWDo5dlF0dDN3aTNSVWl5YXVvRWVuYkV4RW5PUTA5dkVuUnJvbW5OT01BWk5tNWJYYUszVg=="
let ServerURL = "http://\(Serveripv4)"
var authlink: Any = ""
var jsonArray: [Any] = [""]


var CONN2 = false
var HAPPY2 = ""
var COLOR2 = ""
var TRACK2 = ""
var ACC2 = ""
var STATE2 = false
var BRIGHT2:Double = 0
var ENERGY2:Double = 0

var refreshcycle: Timer!




class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var connection: UILabel!
    @IBOutlet weak var mood: UILabel!
    @IBOutlet weak var colortf: UILabel!
    @IBOutlet weak var tracktf: UILabel!
    @IBOutlet weak var acc: UILabel!
    
    @IBOutlet weak var energy: UILabel!
    
    
    
    @IBAction func login(_ sender: Any) {
        Alamofire.request("\(ServerURL)/service/spotify/login?token=\(key)").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                struct data1 {
                    public let result: String
                    public let url: String
                }
                if let JSON = json as? [String: AnyObject] {
                    if let result = JSON["result"] as? String, let url = JSON["url"] as? String {
                        let prosseced = data1(result: result, url: url)
                        authlink = prosseced.url
                        if let url2 = URL(string: authlink as! String) {
                            UIApplication.shared.open(url2, options: [:])
                        }
                }
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
}
    
    @IBAction func autorefresh(_ sender: Any) {
        refreshcycle = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(Refresh), userInfo: nil, repeats: true)
    }
    
    @IBAction func debug(_ sender: Any) {
        Refresh()
    }
    func Update() {
        self.connection.text = "\(CONN2)"
        self.mood.text = HAPPY2
        self.colortf.text = COLOR2
        self.tracktf.text = TRACK2
        self.acc.text = ACC2
        self.energy.text = "\(ENERGY2)"
    }
    
    @IBOutlet weak var BrightnessValue: UISlider!
    
    @IBAction func BrightnessChange(_ sender: Any) {
        let parameters: Parameters = [
            "brightness": BrightnessValue.value,

        ]
        
        Alamofire.request("\(ServerURL)/update?token=\(key)", method: .post, parameters: parameters)
        
}
    @IBAction func invtimer(_ sender: Any) {
        refreshcycle.invalidate()
    }
    @objc func Refresh() {
            Alamofire.request("\(ServerURL)/data?token=\(key)").responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    
                    
                    struct data2 {
                        public let user: String
                        public let track: String
                        public let colorhex: String
                        public let happyness: Double
                        public let enabled: Bool
                        public let brightness: Double
                        public let energy: Double
                    }
                    
                    if let JSON = json as? [String: AnyObject] {
                        if let user = JSON["authenticated_user"] as? String, let track = JSON["current_track"] as? String,let colorhex = JSON["mood_color_hex"] as? String,let happyness = JSON["happyness"] as? Double,let enabled = JSON["enabled"] as? Bool,let brightness = JSON["brightness"] as? Double,let energy = JSON["energy"] as? Double {
                            let prosseced = data2(user: user, track: track, colorhex: colorhex, happyness: happyness, enabled: enabled, brightness: brightness, energy: energy)
                            //Text Field
                             CONN2 = true
                             HAPPY2 = "\(prosseced.happyness)"
                             COLOR2 = prosseced.colorhex
                             TRACK2 = prosseced.track
                             ACC2 = prosseced.user
                             STATE2 = prosseced.enabled
                             BRIGHT2 = prosseced.brightness
                             ENERGY2 = prosseced.energy
                             self.Update()
                            
                        }
                        
                    }
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)") // original server data as UTF8 string
                    }
                }
            }
        }
}
