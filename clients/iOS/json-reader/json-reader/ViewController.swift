//
//  ViewController.swift
//  json-reader
//
//  Created by Ildar Gubaydullin on 25/03/2018.
//  Copyright © 2018 Ildar Gubaydullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let URL_EVENTS = "http://62.109.16.88/REST/events";
    var eventArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = insertButton(start_y: 150, caption: "Получить мероприятия")
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func getJsonFromUrl(url: String) {
        
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
                
                for eventObj in jsonObj!{
                    
                    //converting the element to a dictionary
                    if let event = eventObj as? NSDictionary {
                        
                        //getting the name from the dictionary
                        if let name = event.value(forKey: "name") {
                            
                            //adding the name to the array
                            self.eventArray.append((name as? String)!)
                        }
                        
                    }
                }
            }
                
            OperationQueue.main.addOperation({
                //calling another function after fetching the json
                //it will show the names to label
                self.showNames()
            })
        }).resume()
    }
    
    func insertButton(start_y: Int, caption: String) -> UIButton {
        let x: Int = 50
        let width: Int = Int(self.view.frame.size.width) - x * 2
        let button_height = 50
        
        let button = UIButton(frame: CGRect(x: x, y: start_y, width: width, height: button_height))
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.setTitle(caption, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.view.addSubview(button)
        return button
    }
    
    func showNames(){
        let distance = 60
        var start = 150
        var cnt = 0
        for event in eventArray{
            print(event)
            cnt += 1
            start += distance
            insertButton(start_y: start, caption: "#\(cnt) \(event)")
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        getJsonFromUrl(url: URL_EVENTS)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

