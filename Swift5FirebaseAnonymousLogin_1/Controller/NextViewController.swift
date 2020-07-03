//
//  NextViewController.swift
//  Swift5FirebaseAnonymousLogin_1
//
//  Created by 須藤英隼 on 2020/07/03.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import UIKit
import SDWebImage

class NextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var timeLineTableView: UITableView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    var selectedImage = UIImage()
    
    var userName = String()
    var userImageData = Data()
    var userImage = UIImage()
    var createDate = String()
    var contentImageString = String()
    var userProfileImagestring = String()
    var contentsArray = [Contents]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
        
        //取り出す
        if UserDefaults.standard.object(forKey: "userName") != nil {
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            
        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            userImage = UIImage(data: userImageData)!
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  contentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = timeLineTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //コンテンツ
        
        
        //profileImageView
        let profileImageView = cell.viewWithTag(1) as! UIImageView
        profileImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].profileImageString), completed: nil)
        
        profileImageView.layer.cornerRadius = 30.0
        
        //ユーザー名
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userNameString
        
        //投稿日時
        let dateLabel = cell.viewWithTag(3) as! UILabel
        dateLabel.text = contentsArray[indexPath.row].postDateString
        
        //投稿画像
        let contentImageView = cell.viewWithTag(4) as! UIImageView
        contentImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].contentImageString), completed: nil)
        
        //コメントラベル
        let commentLabel = cell.viewWithTag(5) as! UILabel
        commentLabel.text = contentsArray[indexPath.row].commentString
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 589
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        
        
        
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
