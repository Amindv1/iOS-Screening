import UIKit

class GeneratedUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var userList : [User] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(generateUser))
        view.translatesAutoresizingMaskIntoConstraints = true
        navigationItem.rightBarButtonItem = doneItem
        navigationItem.title = "Generated Users"
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "user")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserDetailPageViewController()
        vc.user = userList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user",
                                                 for: indexPath as IndexPath) as! UserTableViewCell
        let user = userList[indexPath.item]
        cell.user = user
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    @objc func generateUser() {
        if let userDataUrl = URL(string: "https://randomuser.me/api/") {
            URLSession.shared.dataTask(with: userDataUrl) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data, error == nil
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                        guard let userData = json["results"] as? [[String: Any]] else { return }
                        
                        if let user = self?.userFrom(data: userData[0]) {
                            self?.userList.append(user)
                            self?.tableView.reloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func userFrom(data: [String: Any]) -> User? {
        guard let name = data["name"] as? [String: String] else { return nil }
        guard let picture = data["picture"] as? [String: String] else { return nil }
        guard let firstName = name["first"] else { return nil }
        guard let lastName = name["last"] else { return nil }
        guard let imageUrl = picture["large"] else { return nil }
        
        let user = User(first: firstName, last: lastName)
        
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() { [weak self] in
                    user.image = image
                    self?.tableView.reloadData()
                }
            }.resume()
        }
        
        return user
    }
}
