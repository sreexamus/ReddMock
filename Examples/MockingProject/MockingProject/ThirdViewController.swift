//
//  SecondViewController.swift
//  MockingTestUI
//
//  Created by iragam reddy, sreekanth reddy on 8/5/20.
//  Copyright © 2020 ReddMock. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    let vm = CitiesViewModel()
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var counties: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getCityDetails { (details) in
            self.counties.text = String(details.counties)
            self.population.text = String(details.population)
            self.name.text = details.name
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
