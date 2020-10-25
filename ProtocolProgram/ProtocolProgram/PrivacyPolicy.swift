//
//  PrivacyPolicy.swift
//  ProtocolProgram
//
//  Created by Sebastin on 24/10/20.
//  Copyright © 2020 Sebastin. All rights reserved.
//

import UIKit

public protocol PrivacyPolicyDataSource {
    var onlinePrivacy: String { get }
    var copyRights: String { get }
    var legalDisclosure: String { get }
    var accessibility: String { get }
}

public protocol PrivacyPolicyDelegate {
    func getPrivatePolicyConfiguration() -> PrivacyPolicyDataSource
}

public class PrivacyPolicy: UIView {
    @IBOutlet weak var onlinePrivacy: UILabel!
    @IBOutlet weak var copyRights: UILabel!
    @IBOutlet weak var legalDisclosure: UILabel!
    @IBOutlet weak var accessibility: UILabel!
    
    public var privatePolicyDelegate:PrivacyPolicyDelegate?
    
    public class func loadViewFromNib() -> PrivacyPolicy? {
        let nib = UINib(nibName: "PrivacyPolicy", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? PrivacyPolicy else {
            return nil
        }
        return view
    }
    
    /// Set up banner using BannerDataSource
    public func setupPrivacyPolicy(_ delegate: PrivacyPolicyDelegate) {
        privatePolicyDelegate = delegate
        guard let privatePolicyModel = privatePolicyDelegate?.getPrivatePolicyConfiguration() else {
            return
        }
        onlinePrivacy.text = privatePolicyModel.onlinePrivacy
        copyRights.text = privatePolicyModel.copyRights
        legalDisclosure.text = privatePolicyModel.legalDisclosure
        accessibility.text = privatePolicyModel.accessibility
    }
}
