
//
//  RepoListViewController.swift
//  RepoList
//
//  Created by Hrishikesh Pol on 20/10/21.
//

import UIKit
import SDWebImage
import MBProgressHUD

/// View that show all public repo from git.
class RepoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: RepoListViewModel?
    @IBOutlet weak var nextButton: UIButton!
    var repoList = [Value]()
    var repoListResponse = RepoListResponse(pagelen: 0, values: [], next: "")
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign viewModel to the viewController.
        viewModel = repoContainer.resolve(RepoListViewModel.self)
        
        // Load RepoTableViewCell in tableview.
        listTableView.register(UINib(nibName: .kRepoListTableViewCellIdentifier, bundle: nil),
                               forCellReuseIdentifier: .kRepoListTableViewCellIdentifier)
        
        // Load all repo's from API.
        viewModel?.onAppLoad.value = ""
        showIndicator()
        
        // Add app load event listner.
        viewModel?.onRepoListProcessing.observeValues({ [weak self] response in
            self?.hideIndicator()
            guard let weakSelf = self,
                  let repoResponse = response,
                  let values = repoResponse.values else { return }
            weakSelf.repoListResponse = repoResponse
            weakSelf.repoList += values
            weakSelf.nextButton.isHidden = repoResponse.next == nil
            weakSelf.listTableView.reloadData()
        })
    }
        
    //MARK: Next button tapped.
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let next = repoListResponse.next else {
            return
        }
        showIndicator()
        viewModel?.onNextButtonTapped.value = next
    }
    
    //MARK: Show and hide indicator.
    func showIndicator() {
        MBProgressHUD.showAdded(to: self.view, animated: true).show(animated: true)
    }
    /// Hide indicator.
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    //MARK: UITableView DataSource methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .kRepoListTableViewCellIdentifier, for: indexPath) as? RepoTableViewCell else {
            return UITableViewCell()
        }
        let repo = repoList[indexPath.row]
        if let owner = repo.owner,
           let avtarLinks = owner.links,
           let avtarLink = avtarLinks.avatar?.href,
           let displayName = owner.displayName,
           let date = repo.createdOn {
            cell.avtarImageView.sd_setImage(with: URL(string: avtarLink),
                                                    placeholderImage: UIImage(named: "logo"))
            cell.nameLabel.text = displayName
            cell.dateLabel.text = date
            cell.typeLabel.text = repo.type?.rawValue
        }
        cell.selectionStyle = .none
        return cell
    }
}
