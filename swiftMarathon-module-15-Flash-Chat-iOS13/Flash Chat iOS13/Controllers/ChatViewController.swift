//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [MessageModel] = [
        MessageModel(sender: "1@gmail.com", body: "Hey!"),
        MessageModel(sender: "2@gmail.com", body: "Hello!"),
        MessageModel(sender: "1@gmail.com", body: "What's up?!")
    ]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "😎 FlashChat"
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil),
                           forCellReuseIdentifier: K.cellIdentifier)
        loadMessage()
    }
    
    private func loadMessage() {
        // db.collection(K.FStore.collectionName).getDocuments Просто получить данные
        // db.collection(K.FStore.collectionName).addSnapshotListener Следит за измененими в базе и при изменении базы получает данные
        // order - Сортировать данные, а затем получить их
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            // очистить сообщения перед загрузкой
            self.messages = []
            if let error = error {
                print("Ошибка с получением данных из базы ", error.localizedDescription)
            } else {
                if let documents = snapshot?.documents {
                    for doc in documents {
                        let data = doc.data()
                        // data будет иметь вид ["body": Test message, "sender": 123@gmail.com] Это одно сообщение. Если сообщений несколько, то несколько таких словарей.
                        if let messageSender = data[K.FStore.senderField ] as? String,
                           let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = MessageModel(sender: messageSender,
                                                          body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexLastMessage = IndexPath(row: self.messages.count - 1, section: 0)
                                // animated: false, - не будет видно как прокручивается таблица. true будет видно пролистывание вниз.
                                self.tableView.scrollToRow(at: indexLastMessage, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                // Создаем словарь типа String: Any
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Проблема с сохранением данных в Firestore: ", error.localizedDescription)
                } else {
                    print("Данные успешно сохранены")
                    print("Thread = \(Thread.current)")
                    print("qos = \(qos_class_self().rawValue)")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = "" // очистить текстовое поле после отправки сообщения
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier,
                                                 for: indexPath)
        as! MessageCell
        cell.lbl.text = message.body
        
        // Если отправитель совпадет с текущем юзером, то показать другую ячейку
        if message.sender == Auth.auth().currentUser?.email {
            cell.companionAvatarImageView.isHidden = true
            cell.avatarImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.lbl.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.companionAvatarImageView.isHidden = false
            cell.avatarImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.lbl.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
