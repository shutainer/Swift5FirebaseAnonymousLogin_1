//
//  EditAndPostViewController.swift
//  Swift5FirebaseAnonymousLogin_1
//
//  Created by 須藤英隼 on 2020/07/06.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import UIKit
import Firebase

class EditAndPostViewController: UIViewController {
    
    var passedImage = UIImage()
    
    var userName = String()
    var userImageString = String()
    var userImageData = Data()
    var userImage = UIImage()
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アプリ内の保存されているデータを良い出してパーツに反映
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            userImage = UIImage(data: userImageData)!
        }
        
        userProfileImageView.image = userImage
        userNameLabel.text = userName
        contentImageView.image = passedImage
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        //DBのチャイルドを決める
        let timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        
        let storage = Storage.storage().reference(forURL: "")
        
        let key = timeLineDB.child("Users").childByAutoId().key
        let key2 = timeLineDB.child("Contents").childByAutoId().key
        
        let imageRef = storage.child("Users").child("\(String(describing: key!))")
        let imageRef2 = storage.child("Contents").child("\(String(describing: key2!))")
        
        var userProfileImageData:Data = Data()
        var contentImageData:Data = Data()
        
        if userProfileImageView.image != nil {
            userProfileImageData = userProfileImageView.image?.jpegData(compressionQuality: 0.01) as! Data
        }
        
        if contentImageView.image != nil {
            contentImageData = contentImageView.image?.jpegData(compressionQuality: 0.01) as! Data
        }
        
        let uploadTask = imageRef.putData(userProfileImageData, metadata: nil) {
            (metaData, error) in
            if error != nil {
                print(error)
                return
            }
            let uploadTask2 = imageRef2.putData(contentImageData, metadata: nil){
                (metaData, error) in
            if error != nil {
                print(error)
                return
            }
                
                imageRef.downloadURL { (url, error) in
                    if url != nil {
                        imageRef2.downloadURL { (url2, error) in
                            if url2 != nil {
                                //キーバリュー型で送信するものを準備する
                                let timeLineInfo = ["userName":self.userName as Any, "userProfileImage":url?.absoluteString as Any, "contents": url2?.absoluteString as Any, "comment": self.commentTextView.text as Any, "postData": ServerValue.timestamp()] as [String:Any]
                                timeLineDB.updateChildValues(timeLineInfo)
                                
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
                
            }
            
        }
        
        uploadTask.resume()
        
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
