//
//  TableViewController.swift
//  GuillotineApp
//
//  Created by Joseph Kesting on 9/5/18.
//  Copyright © 2018 Joseph Kesting. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var gamesView: UITableView!
    let cellIdentifier = "reuseIdentifier"
    
    let gameManager = GameManagerProvider.getShared()
    
    let names = [
        "Joe", "Micha", "Nick", "Payton", "Austin"
    ]

    override func loadView() {
        super.loadView()
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Games"
        self.gamesView.register(GameCell.self, forCellReuseIdentifier: cellIdentifier)
        self.gamesView.delegate = self
        self.gamesView.dataSource = self
        
        
//        self.gamesView.reloadData()
        newGameButton.titleLabel?.textAlignment = .center
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "BREAK"
        label.backgroundColor = UIColor.red
        return label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameManager.listGames().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameCell
        cell.textLabel?.text = names[indexPath.row]
        cell.setColor()
        let gameId = self.gameManager.listGames()[indexPath.row]
        let game = self.gameManager.getGameInformation(gameId: gameId)
        
        cell.setGame(game: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GameCell
        
        print(cell.textLabel?.text ?? "No Game")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveGameViewController") as! ActiveGameViewController
        // TODO factor into its own method
        let gameId = self.gameManager.listGames()[indexPath.row]
    
        controller.setGame(gameId: gameId)
        present(controller, animated: true, completion: nil)
    }
    
    func update() {
        gameManager.fetchAndUpdateAllGames()
        gamesView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
