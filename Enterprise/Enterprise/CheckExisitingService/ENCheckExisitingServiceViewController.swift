//
//  ENCheckExisitingServiceViewController.swift
//  Enterprise
//
//  Created by user on 11/13/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class ENCheckExisitingServiceViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate {
   
    
    let cellId = "cell"
  

    var showIndexPaths = false
    var delegate : MenuViewShowHideDelegate?
    var requestActionDelegate : MenuViewShowHideDelegate?

    var menuCheckMenuActionDelegate : MenuActionDelegate?
    var logoutDelegate : MenuActionDelegate?
    var touchEvent = true
    var toolBar = UIToolbar()
    
    
    var ht : Int!
    var dismissBool : Bool!
    var temp : Bool!
    
    var Secondht : Int!
    var SeconddismissBool : Bool!
    var Secondtemp : Bool!
    
    var thirdHt : Int!
    var thirdDismissBool : Bool!
    var thirdTemp : Bool!
    private var customView: UIView!
    
    var expandThirdCellBool : Bool!
    
    @IBOutlet weak var requestAnotherServiceBtn: UIButton!
    @IBOutlet weak var ratingHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var submitBtnObject: UIButton!
    
    
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var rateTextView: UITextView!
    var rateBtnBool = true
    @IBAction func didSelectRatingButton(_ sender: Any) {
        if rateBtnBool == true
        {
            ratingHeightConstraint.constant = 0
            rateBtnBool = false
        }
        else
        {
            ratingHeightConstraint.constant = 168
            rateBtnBool =   true
        }
    }
    
    
    
    
    @IBAction func didSelectSubmitButton(_ sender: Any) {
        /* not working code...when i want o clear the ratetextview.text when submit is clicked
        let indexPath = NSIndexPath(row: 1, section: 3)
        var rateText = eventDetailsTableView.cellForRow(at: indexPath as IndexPath) as? RatingTableViewCell // we cast here so that you can access your custom property.
        rateText?.textLabel?.text = " "
        */
//        let indexPath = IndexPath(item: 1, section: 3)
//        eventDetailsTableView.reloadRows(at: [indexPath], with: .top)
        
        let rowNumber: Int = 0
        let sectionNumber: Int = 3
        
        let indexPath = IndexPath(item: rowNumber, section: sectionNumber)
        
        eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        ThankYouContainerView.isHidden  = false
        view.addSubview(ThankYouContainerView)
        
        ThankYouContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let horizontalConstraint = NSLayoutConstraint(item: ThankYouContainerView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
        let verticalConstraint  =   NSLayoutConstraint(item: ThankYouContainerView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        
        let bottomConstraint    =   NSLayoutConstraint(item: ThankYouContainerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        let topConstraint    =   NSLayoutConstraint(item: ThankYouContainerView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
       
        
       NSLayoutConstraint(item: ThankYouContainerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0.0).isActive = true
        

        NSLayoutConstraint.activate([horizontalConstraint,verticalConstraint,bottomConstraint,topConstraint])
    }
    
    @IBAction func didSelectReqAnotherService(_ sender: Any) {
        ThankYouContainerView.removeFromSuperview()
        //self.requestActionDelegate?.showMenu()
        self.logoutDelegate?.showSelected(selectedMenu: .Request)
    }
    @IBAction func didSelectLogOutBtn(_ sender: Any) {
        
//        let navigateVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
//        self.navigationController?.pushViewController(navigateVC!, animated: true)
        showLogoutPopUp()
    }
    
    func showLogoutPopUp(){
        
        let logoutAlert : UIAlertController = UIAlertController(title: APP_NAME, message: LOGOUT_ALERT_MESSAGE, preferredStyle: UIAlertController.Style.alert)
        
        let yesAction : UIAlertAction = UIAlertAction(title: ALERT_TITLE_YES, style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
//            self.ThankYouContainerView.removeFromSuperview()
            let loginVC : LoginViewController = LoginViewController()//self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            //let navlogin = UINavigationController(rootViewController: loginVC)
            //self.navigationController?.popViewController(animated: true)
            
          
            self.navigationController?.popToRootViewController(animated: true)
            //self.navigationController?.pushViewController(loginVC, animated: false)
            
//            let navArray = self.navigationController?.viewControllers
//
            
//            for loginvc in navArray!
//            {
//                if (loginvc is LoginViewController)
//               {
//                    self.navigationController?.popToViewController(navlogin, animated: false)
//                }
//
////                if (loginvc.isKind(of:LoginViewController))
////                {
////
////                }
//            }
            
            
//            self.present(loginVC, animated: false, completion: nil)
        }
        
        let cancelAction : UIAlertAction = UIAlertAction(title: ALERT_TITLE_CANCEL, style: UIAlertAction.Style.default) { (alert : UIAlertAction) in
        }
        
        logoutAlert.addAction(yesAction)
        logoutAlert.addAction(cancelAction)
        self.present(logoutAlert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var ThankYouContainerView: UIView!
    @IBOutlet weak var eventDetailsTableView: UITableView!
    @IBOutlet weak var CreatedStateObj: UIControl!
    @IBAction func didSelectHamMenu(_ sender: Any) {
        if delegate != nil
        {
            DispatchQueue.main.async {
                self.delegate?.showMenu()
            }
        }
        let rowNumber: Int = 0
        let sectionNumber: Int = 3
        
        let indexPath = IndexPath(item: rowNumber, section: sectionNumber)
        
        eventDetailsTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    override func viewWillAppear(_ animated: Bool) {
//        if UserDefaults.standard.bool(forKey: "NavigateFromEvent") == true
//        {
//            showAlertControllerWithMessage(messageToShow: "Event Created Successfully")
//        }
//        else
//        {
//            UserDefaults.standard.removeObject(forKey: "NavigateFromEvent")
//        }
    }
    func addToolBar(textField: UITextField){
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: "donePressed")
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "cancelPressed")
        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
       
    }
    func donePressed(){
        view.endEditing(true)
    }
    func cancelPressed(){
        view.endEditing(true) // or do something
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
   
    private func loadCustomViewIntoController() {
        let customViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
        
        customView = UIView(frame: customViewFrame)
        customView.backgroundColor = .red
        view.addSubview(customView)
        customView.isHidden = false
        
        let okayButtonFrame = CGRect(x: 40, y: 100, width: 50, height: 50)
        let okayButton = UIButton(frame: okayButtonFrame )
        okayButton.backgroundColor = .blue
        customView.addSubview(okayButton)
        okayButton.addTarget(self, action: #selector(self.didPressButtonFromCustomView), for:.touchUpInside)
        
    }
    @objc func didPressButtonFromCustomView(sender:UIButton) {
        // do whatever
        customView.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CreatedStateObj.addTarget(self, action: #selector(touchUP), for: UIControl.Event.touchUpInside)
        ThankYouContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        eventDetailsTableView.sectionHeaderHeight = 0
        eventDetailsTableView.sectionFooterHeight   =   0
        eventDetailsTableView.dataSource  =   self
        eventDetailsTableView.delegate    =   self
        //rateTextView.delegate   =   self
        SeconddismissBool =  true
        dismissBool = true
        temp = false
        ThankYouContainerView.isHidden  = true
        expandThirdCellBool = true
        
        logoutBtn.titleLabel?.font = .systemFont(ofSize: 13)
        requestAnotherServiceBtn.titleLabel?.font =  .systemFont(ofSize: 13)
        Utility.setupButtonCorner(buttonRcv: logoutBtn)
        Utility.setupButtonCorner(buttonRcv: requestAnotherServiceBtn)
        
        
       
        
        //working nib register for adding map on header
        let headerNib = UINib.init(nibName: "ENEventHeaderViewGoogleMap", bundle: Bundle.main)
        eventDetailsTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ENEventHeaderViewGoogleMap")
        
        
        //working code when 2 xib's added
        //let nib = UINib(nibName: "ExpandableCell", bundle: nil)
        //eventDetailsTableView.register(nib, forCellReuseIdentifier: "cell")

        //DateTableViewCell
        //let nibDate = UINib(nibName: "DateTableViewCell", bundle: nil)
        //eventDetailsTableView.register(nibDate, forCellReuseIdentifier: "cellDate")
        
    }
    /*
    @objc func touchUP()
    {
        if touchEvent   ==  true
        {
            print("UP selected")
            view.backgroundColor    =   UIColor.blue
            touchEvent  =   false
        }
        else if touchEvent == false
        {
            print("Down selected")
            view.backgroundColor    =   UIColor.red
            touchEvent  =   true
        }
    }*/

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            text.resignFirstResponder()
//            return false
//        }
//        return true
//    }
}

    




extension ENCheckExisitingServiceViewController : UITableViewDataSource, UITableViewDelegate
{
    //working code to add map on header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0
        {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ENEventHeaderViewGoogleMap") as! ENEventHeaderViewGoogleMap
            return headerView
            //return UIView(frame: CGRect.zero)
        }
        else
        {
            
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0
        {
            return 200
        }
        else
        {
            return 0
        }
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventDetailsTableView.dequeueReusableCell(withIdentifier: "cell")
        let cellEvent = eventDetailsTableView.dequeueReusableCell(withIdentifier: "cellEvent")
        let cellRate = eventDetailsTableView.dequeueReusableCell(withIdentifier: "cellRate")
        let cellStarNotes = eventDetailsTableView.dequeueReusableCell(withIdentifier:"cellStarNotes") as! RatingTableViewCell
        let cellSubmit = eventDetailsTableView.dequeueReusableCell(withIdentifier: "cellSubmit")
        
        if indexPath.section == 0
        {
            
            if indexPath.row == Secondht && SeconddismissBool == false
                //to show expanded view
            {
                //cell!.textLabel?.text = "first"
            }
            else //temp = false //to collapse view
            {
                //cell!.textLabel?.text = "first"
            }
            return cell!
        }
        else if indexPath.section == 1
        {
            
            if indexPath.row == ht && dismissBool == false
                //to show expanded view
            {
                //cell!.textLabel?.text = "second"
            }
            else //temp = false //to collapse view
            {
                
            }
            return cellEvent!
        }
        else if indexPath.section   == 2
        {
//            DispatchQueue.main.async {
//                cellRate?.textLabel?.text   =   "Rate your service provider"
//                
//            }
            return cellRate!
        }
        else if indexPath.section   ==  3
        {
//            cellStarNotes.ratingTxtView.delegate = self
//            cellStarNotes.ratingTxtView.inputAccessoryView = toolBar
            cellStarNotes.ratingTxtView.layer.borderColor  =   UIColor.black.cgColor
            cellStarNotes.ratingTxtView.layer.borderWidth  =   0.5
            cellStarNotes.ratingTxtView.text = ""
            return cellStarNotes
        }
        else if indexPath.section   ==  4
        {
            return cellSubmit!
        }
        return cellEvent!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
        {
            if SeconddismissBool ==  true
            {
                Secondht  =   indexPath.row
                SeconddismissBool = false
            }
            else
            {
                Secondht  =   indexPath.row
                SeconddismissBool = true
            }
            //need to make false when selected again....
            eventDetailsTableView.reloadData()
        }
        else
            if indexPath.section == 1
            {
                //                if dismissBool ==  true
                //                {
                //                    ht  =   indexPath.row
                //                    dismissBool = false
                //                }
                //                else
                //                {
                //                    ht  =   indexPath.row
                //                    dismissBool = true
                //                }
                //                tblObj.reloadData()
            }
            else if indexPath.section == 3
            {
//                if thirdDismissBool ==  true
//                {
//                    thirdHt  =   indexPath.row
//                    thirdDismissBool = false
//                    expandThirdCellBool = true
//                }
//                else
//                {
//                    thirdHt  =   indexPath.row
//                    thirdDismissBool = true
//                    expandThirdCellBool = false
//                    thirdDismissBool = false
//                    thirdTemp = false
//                }
//                eventDetailsTableView.reloadData()
                //expandThirdCellBool = false
        }
        else if indexPath.section == 4
            {
                ThankYouContainerView.isHidden  = false
                view.addSubview(ThankYouContainerView)
            }
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        //return 0.00001
//        //return CGFloat.leastNormalMagnitude
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            if indexPath.row == Secondht
            {
                if SeconddismissBool == false && Secondtemp == false || Secondtemp == nil
                {
                    Secondtemp = true
                    return 780
                }
                else
                {
                    Secondtemp = false
                    return 60
                }
            }
        }
        else
            if indexPath.section == 1
            {
                return 480
                //                if indexPath.row == ht
                //                {
                //                    if dismissBool == false && temp == false
                //                    {
                //                        temp = true
                //                        return 600
                //                    }
                //                    else
                //                    {
                //                        temp = false
                //                        return 50
                //                    }
                //                }
            }
            else if indexPath.section == 3
            {
//                if indexPath.row == thirdHt
//                {
//                    //expandThirdCellBool = false
//                    if thirdDismissBool == false && thirdTemp == false && expandThirdCellBool == false
//                    {
//                        thirdTemp = true
//                        expandThirdCellBool = false
//                        return 195
//                    }
//                    else
//                    {
//                        thirdTemp = false
                        return 170
//                    }
//                }
        }
        else if indexPath.section   ==  4
        {
            return 60
        }
        return 60
    }
}

