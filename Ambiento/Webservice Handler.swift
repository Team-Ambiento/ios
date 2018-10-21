//
//  Webservice Handler.swift
//  Ambiento
//
//  Created by Lennart Kobosil on 20.10.18.
//  Copyright © 2018 JugendHackt. All rights reserved.
//
/*
import Foundation
import Alamofire
var Shutdown = false



func Refresh() {
    while Shutdown == false {
        Alamofire.request("\(ServerURL)/service/spotify/data?token=\(key)").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                
                
                struct data2 {
                    public let user: String
                    public let track: String
                    public let colorrgb: UIColor
                    public let colorhex: String
                    public let happyness: Double
                }
                
                if let JSON = json as? [String: AnyObject] {
                    if let user = JSON["authenticated_user"] as? String, let track = JSON["current_track"] as? String,let colorrgb = JSON["mood_color_rgb"] as? UIColor,let colorhex = JSON["mood_color_hex"] as? String,let happyness = JSON["happyness"] as? Double {
                        let prosseced = data2(user: user, track: track, colorrgb: colorrgb, colorhex: colorhex, happyness: happyness)
                        //Text Fields
                        
                        
                        
                        
                        
                        
                        
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
}
 
 */

