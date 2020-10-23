//
//  ViewController.swift
//  MockingProject
//
//  Created by sreekanth reddy iragam reddy on 9/9/20.
//  Copyright © 2020 ReddMockProj. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let vm = CitiesViewModel()
    var cities: Cities?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        vm.getCities { (cities) in
            self.cities = cities
            print("ceities.....")
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.cities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = cities?.cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}


