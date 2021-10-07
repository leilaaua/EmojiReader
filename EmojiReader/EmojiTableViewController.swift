//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by leila leila on 04.10.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Let's love each other", isFavorite: false),
        Emoji(emoji: "⚽️", name: "Football", description: "Let's play football", isFavorite: false),
        Emoji(emoji: "🐱", name: "Cat", description: "Cat is the cutest animal", isFavorite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editEmoji" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let emoji = objects[indexPath.row]
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let newEmojiVC = navigationVC.topViewController as? NewEmojiTableViewController else { return }
        
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        guard let sourceVC = segue.source as? NewEmojiTableViewController else { return }
        let emoji = sourceVC.emoji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.setEmoji(object: object)
    
        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(moveEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = favoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .systemPink
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var objects = objects[indexPath.row]
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completion) in
            objects.isFavorite.toggle()
            self.objects[indexPath.row] = objects
            completion(true)
        }
        favoriteAction.backgroundColor = objects.isFavorite ? .systemPurple : .systemGray
        favoriteAction.image = UIImage(systemName: "heart")
        return favoriteAction
    }
}
