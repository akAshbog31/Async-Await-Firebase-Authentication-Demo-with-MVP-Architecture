//
//  Extention+UIviewController.swift
//  Summit
//
//  Created by mac on 22/12/22.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    class func instantiate<T: UIViewController>(appStoryboard: StoryboardType = .main) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func pushVc<T: UIViewController>(vc: T.Type, appStoryboard: StoryboardType = .main) {
        let vc = vc.instantiate(appStoryboard: appStoryboard)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popVc() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showHUD(progressLabel: String = "Loading..."){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: (Utils.shared.getSceneDelegate()?.window)!, animated: true)
            progressHUD.label.text = progressLabel
            progressHUD.bezelView.layer.cornerRadius = 18
            progressHUD.bezelView.blurEffectStyle = .systemChromeMaterialDark
            progressHUD.contentColor = .systemBackground
            progressHUD.bezelView.style = .blur
        }
    }
    
    func dismissHUD(isAnimated: Bool = true) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: (Utils.shared.getSceneDelegate()?.window)!, animated: isAnimated)
        }
    }
    
    func showAlertWithTitle(title: String = "Summit", msg: String, options: String..., completion: @escaping ((Int) -> ())) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alert.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        Utils.shared.getSceneDelegate()?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String = "Error", msg: String) {
        self.showAlertWithTitle(title: title,msg: msg, options: "Ok", completion: { option in
            switch option {
            case 0: break
            default: break
            }
        })
    }
    
    func gotoSettingAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let gotoSetting = UIAlertAction(title: "Go to settings", style: .default) { _ in
            let url = URL(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:])
            }
        }
        let btnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(gotoSetting)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadImge(withUrlStr url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw DemoError.inValidUrl
        }
        
        let res = try await URLSession.shared.data(from: url)
        let image = UIImage(data: res.0) ?? UIImage()
        return image
    }
}

enum DemoError: Error {
    case inValidUrl
}
