//
//  ViewController.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/8/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    let loadBalancer = LoadBalancer(playerId: "playerId") // TODO get cached playerId

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGames() {
        let gameMetadata = self.loadBalancer.getAllGames()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
