//
//  AppCoordinator.swift
//  SA-CaseStudy-MVMM
//
//  Created by Tural Babayev on 18.01.2025.
//

import UIKit

// MARK: - Coordinator Protocol
/// Base coordinator protocol that defines the core navigation functionality
/// Used as a foundation for implementing navigation coordination in the app
///
/// Key responsibilities:
/// 1. Manages view controller navigation flow
/// 2. Handles dependencies between screens
/// 3. Centralizes navigation logic
///
protocol Coordinator: AnyObject {
    // MARK: - Properties
    /// Each coordinator manages its own navigation stack
    var navigationController: UINavigationController { get set }
    
    // MARK: - Methods
    /// Starts the coordinator's flow
    /// Should be called to initialize the first screen in the flow
    func start()
}
