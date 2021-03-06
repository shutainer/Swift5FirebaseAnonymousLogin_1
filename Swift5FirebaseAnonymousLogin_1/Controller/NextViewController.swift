//
//  NextViewController.swift
//  Swift5FirebaseAnonymousLogin_1
//
//  Created by 須藤英隼 on 2020/07/03.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import UIKit
import SDWebImage

class NextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    

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
        
        //アラート or アクションシート
        showAlert()
        
    }
    
    //カメラ立ち上げメソッド
    func doCamera() {
        //変数宣言で型を指定しているのはなぜ？？　メリットは？
        let sourceType:UIImagePickerController.SourceType = .camera
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //アルバム
    func doAlbum() {

        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    //アラート
    func showAlert() {
        let alertController = UIAlertController(title: "選択してください", message: "どちらを使用しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbum()
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        
        alertController.addAction(action2)
        
        alertController.addAction(action3)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //画像が選択 or 撮影後に呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    selectedImage = info[.originalImage] as! UIImage
    //ナビゲーションを用いて画面遷移
        let editPostVC = self.storyboard?.instantiateViewController(identifier: "editPost") as! EditAndPostViewController
        
        editPostVC.passedImage = selectedImage
        self.navigationController?.pushViewController(editPostVC, animated: true)
    //ピッカーを閉じる
        picker.dismiss(animated: true, completion: nil)

        
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
