//
//  Deployment.swift
//  AppConfiguration
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// Identifies a deployment target for a service.
public enum Deployment: String {
    case development
    case staging
    case production
}
