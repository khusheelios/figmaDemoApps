//
//  ViewController.swift
//  figmaDemoApps
//
//  Created by CG App Mac on 03/06/22.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var firstbackView: UIView!
    @IBOutlet weak var secondView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        
        // Do any additional setup after loading the view.
    }
    
    func getUserData()
    {
                DataService.shared.getUsers{data in
                    print("Count is",data.count)

                    let json = try! JSON(data: data)
                    print("JsonData :",json.count)
                  
                    let headerColor = json["global"]["header-color"]["value"]
                    let firstView = json["global"]["first_view_color"]["value"]
                    let seocndView = json["global"]["second_view_coolor"]["value"]
                 
                    
                    headerView.backgroundColor = UIColor(hexString: headerColor.rawValue as! String)
                    firstbackView.backgroundColor = UIColor(hexString: firstView.rawValue as! String)
                    secondView.backgroundColor = UIColor(hexString: seocndView.rawValue as! String)
        }
    }


}
class DataService
{
    static let shared = DataService()
    
    func getUsers(completion:(Data) -> Void)
    {
        guard let path = Bundle.main.path(forResource: "tokens", ofType: "json") else{return}
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        print("Url data",data)
        completion(data)
        
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
