//
//  ConversationsController.swift
//  Networking Project
//
//  Created by Zachary Ellis on 9/29/20.
//  Copyright © 2020 Zachary Ellis. All rights reserved.
//

/*
 
    This is the Code to be submitted for D2
    
    As of now the x amount of users can sign in
    and will be authenticated and stored into the Firebase server/database
 
 */

import UIKit
import Firebase

private let reuseIndentifier = "ConversationCell"

class ConversationsController: UIViewController {
    
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
    }
    
    
    // MARK: Selectors
    @objc func showProfile() {
        logout()
    }
    
    // MARK: API
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        } else {
            print("DEBUG: User is\(Auth.auth().currentUser?.uid)")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out...")
        }
    }
     
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavigationBar()
        confgiureTableView()
        
        // Constant: let image is an Apple pre-loaded image of the circled human in the top left corner of app
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
    }
    
    func configureNavigationBar() {
        /*
         Kinda like CSS: This part strictly styling the color of top part AKA nav bar.
         These do nothing more than simply color the app.
         */
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        // When you scroll this compacts the top nav bar
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    
       func confgiureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIndentifier)
        
         /* tableFooterView:
            
            For the number of cells (rows) you have, That's how many separators you will have too
                
                Nav Bar
                --------
                cell one
                --------
                cell two
                --------
                cell...
                --------
        
         */
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.frame
       }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIndentifier, for: indexPath)
        cell.textLabel?.text = "Test Cell"
        return cell
    }
    
    
}

