//
//  ViewController.swift
//  Login-Table
//
//  Created by khacviet on 11/11/16.
//  Copyright © 2016 khacviet. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var actions : String?
    
    
    @IBOutlet weak var text_Username: UITextField!
    
    @IBOutlet weak var text_Password: UITextField!
    
    @IBOutlet weak var text_Other: UITextField!
    
    @IBOutlet weak var but_prtMember: UIButton!
    
    @IBOutlet weak var but_Delete: UIButton!
    
    @IBOutlet weak var but_Change: UIButton!
    
    @IBOutlet weak var newPassword: UILabel!

    @IBOutlet weak var user: UILabel!
    
    
    
    
    
    var users = ["admin":"admin", "khacviet":"0", "manhcuong":"1", "hongnhung":"2", "anhdung":"3"]
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       but_prtMember.hidden = true
        but_Delete.hidden = true
        but_Change.hidden = true
        text_Other.hidden = true
        newPassword.hidden = true
        user.hidden = true
    }
    
    @IBAction func action_Login(sender: AnyObject)
    {
        if let password = users[text_Username.text!]
        {
            if password == text_Password.text
            {
                print("Đăng nhập thành công")
                showAlert()
                but_Change.hidden = false
                text_Other.hidden = false
                newPassword.hidden = false
                confirmAdmin()
            }
            else
            {
                print("Mật khẩu không đúng")
            }
        }
        else
        {
            print("Tài khoản không tồn tại")
        }
    }
    
    @IBAction func action_SignUp(sender: AnyObject)
    {
        if (checkValidateInfo(text_Username.text!, password: text_Password.text!) == true)
        {
            checkAvalidate()
        }
    }
    
    func checkValidateInfo(name:String, password:String) -> Bool
    {
        if (text_Username.text! == "" || text_Password.text! == "")
        {
            print("Tài khoản và mật khẩu không được để trống")
            return false
        }
        return true
    }
    
    func checkAvalidate()
    {
        print("\(users[text_Username.text!])")
        if users[text_Username.text!] != nil
        {
            print("Tài khoản đã tồn tại. Mời nhập tên khác")
        }
        else
        {
            users[text_Username.text!] = text_Password.text!
        }
    }
    
    @IBAction func prt_MemberList(sender: AnyObject)
    {
        if confirmAdmin() == true
        {
            for (name, password) in users
            {
                print("\(name): \(password)")
            }
        }
        else
        {
            print("Chỉ admin có quyền thấy member list")
        }
    }
    
    @IBAction func action_Delete(sender: AnyObject)
    {
        if confirmAdmin() == true
        {
            users.removeValueForKey(text_Other.text!)
            for (name, password) in users
            {
                print("\(name): \(password)")
            }
        }
        else
        {
            print("Chỉ admin có quyền xóa user")
        }
    }
    
    func confirmAdmin() -> Bool
    {
        if (text_Username.text! == "admin" || text_Password.text! == "admin")
        {
            but_prtMember.hidden = false
            but_Delete.hidden = false
            text_Other.hidden = false
            user.hidden = false
            return true
        }
        return false
    }
    
    @IBAction func action_ChangePasword(sender: AnyObject)
    {
        if changePassword() == true
        {
            users[text_Username.text!] = text_Other.text!
            print("Mật khẩu đã được thay đổi: \(text_Username.text!): \(text_Other.text!)")
        }
        else
        {
            print("Mời nhập đầy đủ thông tin")
        }
    }
    
    func changePassword() -> Bool
    {
        if (text_Username.text! != "" || text_Username.text! != "admin" || text_Username.text! == users[text_Username.text!] || text_Password.text! != "" || text_Password.text! == users[text_Password.text!])
        {
            return true
        }
        return false
    }
    
    func showAlert ()
    {
        
        let alert = UIAlertController(title: "Hi! Boss", message: "Well come back house", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default)
        {
            (UIAlertAction) in
            self.actions = "OK"
        }
        let cancle = UIAlertAction(title: "Cancle", style: .Default)
        {
            (UIAlertAction) in
            self.actions = "Cancle"
        }
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}



