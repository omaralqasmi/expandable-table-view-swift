//
//  ViewController.swift
//  expandable table view
//
//  Created by LYNX ART on 08/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblExpandable: UITableView!
    var arrItems = [HeaderCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        arrItems = [
            HeaderCell(title: "WWE", desc: "list of people working in WWE!", arrSubCells: [
                SubCell(fname: "John", lname: "Cena", gender: 0),
                SubCell(fname: "Triple", lname: "H", gender: 0),
                SubCell(fname: "Rounda", lname: "Rosey", gender: 1),
                SubCell(fname: "Shawn", lname: "Michles", gender: 0),
                SubCell(fname: "Stephanie", lname: "McMahon", gender: 1),
                SubCell(fname: "Randy", lname: "Orton", gender: 0)
            ]),
            HeaderCell(title: "TEKKEN 7", desc: "list of fighters in TEKKEN 7 game", arrSubCells: [
                SubCell(fname: "Jin", lname: "Kazama", gender: 0),
                SubCell(fname: "Ling", lname: "Xiaoyu", gender: 1),
                SubCell(fname: "Nina", lname: "Williams", gender: 1),
                SubCell(fname: "Kazuya", lname: "Mishima", gender: 0)
            ]),
            HeaderCell(title: "Singers", desc: "list of top singers", arrSubCells: [
                SubCell(fname: "Micheal", lname: "Jackson", gender: 0),
                SubCell(fname: "Lady", lname: "Gaga", gender: 1),
                SubCell(fname: "Ed", lname: "Sheeran", gender: 0),
                SubCell(fname: "Enrique", lname: "Iglesias", gender: 0),
                SubCell(fname: "Avril", lname: "Lavigne", gender: 1)
            ])
        ]
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        arrItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = arrItems[section]
        if item.isOpened {
            // show all sub cells + section cell (Header Cell)
            return item.arrSubCells.count + 1
        }else{
            // show section cell
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // section cell
            let item = arrItems[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
            cell.lblTitle.text = item.title
            cell.lblDescreption.text = item.desc
            cell.imageArrow.image = item.isOpened ? UIImage.init(systemName: "chevron.up") : UIImage.init(systemName: "chevron.down")
            return cell
        }else{
            //sub cell
            let item = arrItems[indexPath.section].arrSubCells[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath) as! SubTableViewCell
            cell.lblFirstName.text = item.fname
            cell.lblLastName.text = item.lname
            cell.segmentGender.selectedSegmentIndex = item.gender
            return cell

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            //section cell
            let item = arrItems[indexPath.section]
            item.isOpened = !item.isOpened
            
//            closeAllSections(except : indexPath.section)// uncomment to close all other sections
            tableView.reloadSections([indexPath.section], with: .none)//comment this line if above line is uncommented
            print("Did tap : \(item.title)")

        }else{
            //sub cell
            let item = arrItems[indexPath.section].arrSubCells[indexPath.row - 1]
            print("Did tap : \(item.fname)  \(item.lname)")

        }
    }
    
    func closeAllSections(except : Int) {
        var  arr : [Int] = []
        
        for (index, item) in arrItems.enumerated() {
            if except != index {
                item.isOpened = false
                
            }
            arr.append(index)
        }
        tblExpandable.reloadSections(IndexSet(arr), with: .none)


    }
}

class HeaderCell {
    
    let title : String
    let desc : String
    let arrSubCells : [SubCell]
    var isOpened : Bool = false
    
    internal init(title: String, desc: String, arrSubCells: [SubCell], isOpened: Bool = false) {
        self.title = title
        self.desc = desc
        self.arrSubCells = arrSubCells
        self.isOpened = isOpened
    }
    

}
class SubCell {
    
    let fname : String
    let lname : String
    let gender : Int
    
    internal init(fname: String, lname: String, gender: Int) {
        self.fname = fname
        self.lname = lname
        self.gender = gender
    }

}
