//
//  InPutViewController.swift
//  Swift5FirebaseAnonymousLogin_1
//
//  Created by 須藤英隼 on 2020/07/02.
//  Copyright © 2020 Eishun Sudo. All rights reserved.
//

import UIKit

class InPutViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var userImageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoImageView.layer.cornerRadius = 30.0
        
        
        // Do any additional setup after loading the view.
    }
    
    //戻れないようにナビゲーションバーを消す
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        //ユーザー名をアプリ内に保存
        UserDefaults.standard.set(userImageTextField.text, forKey: "userName")
        
        //アイコンもアプリ内に保存
        let data =  logoImageView.image?.jpegData(compressionQuality: 0.1)
        UserDefaults.standard.set(data, forKey: "userImage")
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") as! NextViewController
        self.navigationController?.pushViewController(NextViewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userImageTextField.resignFirstResponder()
    }
    @IBAction func imageViewTap(_ sender: Any) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        //アラートを出す
        showAlert()
        //カメラ or アルバムを選択させます
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] as? UIImage != nil {
            let selectedImage = info[.originalImage] as! UIImage
            UserDefaults.standard.set(selectedImage.jpegData(compressionQuality: 0.1), forKey: "userImage")
            logoImageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //アラート
    func showAlert() {
        let alertController = UIAlertController(title: "選択してください", message: "どちらを使用しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            self.doCamera()
        }
        
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            self.doAlbu()
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        
        alertController.addAction(action2)
        
        alertController.addAction(action3)
        
        self.present(alertController, animated: true, completion: nil)
        
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
