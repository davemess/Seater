//
//  BuildConfiguration.swift
//  AppConfiguration
//
//  Created by David Messing on 10/13/18.
//

import Foundation

/// Represents a build configuration for an Xcode project.
public struct BuildConfiguration: CustomStringConvertible {
    
    /// An identifier for the build configuration.
    public let identifier: String
    
    /// An identifier for the deployment environment for the build configuration.
    public let deployment: Deployment
    
    public var description: String {
        return String(format: "<%@> Identifier: %@, Deployment: %@", String(describing: type(of: self)), identifier, deployment.rawValue)
    }
    
    // MARK: - lifecycle
    
    public init(identifier: String, deployment: Deployment) {
        self.identifier = identifier
        self.deployment = deployment
    }
}

public extension BuildConfiguration {
    
    init?(bundle: Bundle) {
        guard let identifier = bundle[.configuration] else {
            return nil
        }
        
        guard let deploymentKey = bundle[.deployment],
            let deployment = Deployment(rawValue: deploymentKey) else {
                return nil
        }
        
        self = BuildConfiguration(identifier: identifier, deployment: deployment)
    }
}
