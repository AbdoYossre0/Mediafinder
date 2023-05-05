//
//  MediaVC.swift
//  Media XXX
//
//  Created by abdoyossre on 8/25/20.
//  Copyright © 2020 abdoyossre. All rights reserved.
//

import UIKit
import AVKit

class MediaVC: UIViewController {
    
    @IBOutlet weak var mediaTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mediaSegmentedControl: UISegmentedControl!
    
    var mediaArr: [Media] = []
    var mediaType: MediaType = .tvShow
    var mediaKind = MediaType.tvShow.rawValue
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefultsManger.shared().isLoggedIn = true
        mediaTableView.register(UINib(nibName: Cells.mediaCell, bundle: nil), forCellReuseIdentifier: Cells.mediaCell)
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
        searchBar.delegate = self
        self.navigationItem.hidesBackButton = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile->", style: .plain, target: self, action: #selector(tapButton))
        setSegmaneted()
        SQliteManager.shared().setupConnection()
        SQliteManager.shared().creteMediaTable()
        SQliteManager.shared().listOfMedia()
        
        
        
    }
    

    
    @objc private func tapButton() {
        let mainStorebord = UIStoryboard(name: "Main", bundle: nil)
        let profileV = mainStorebord.instantiateViewController(withIdentifier: ViewController.profileVC) as! ProfileVC
        navigationController?.pushViewController(profileV, animated: true)
    }

    
    private func setSegmaneted() {
        switch mediaKind {
        case MediaType.music.rawValue:
            mediaType = .music
            mediaSegmentedControl.selectedSegmentIndex = 1
        case MediaType.movie.rawValue:
            mediaType = .movie
            mediaSegmentedControl.selectedSegmentIndex = 2
        default:
            mediaType = .tvShow
            mediaSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 1:
            self.mediaType = .movie
        case 2:
            self.mediaType = .music
        default:
            self.mediaType = .tvShow
        }
        guard let searchText = searchBar.text, searchText != "" else {
            return
        }
        getData(term: searchText, media: mediaType.rawValue)
    }
    
    private func getData(term:String, media: String) {
     
        // the function need to give here the data
        APIManager.loadMedia(term: term, media: media) { (error, mediaData) in
        if let error = error {
            print(error)
        } else if let mediaData = mediaData {
            self.mediaArr = mediaData
            if self.mediaArr.count > 0 {
                SQliteManager.shared().insertNewMedia()
            }
//            print("xxx",self.mediaArr)
            self.mediaTableView.reloadData()
        }
      }
   }
    
    private func privewUrl(url: String, artworkUrl: String) {
        let url = URL(string: url)
        let player = AVPlayer(url: url!)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    
    
    
}

extension MediaVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return mediaArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mediaCell, for: indexPath) as? MediaTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(media: mediaArr[indexPath.row])

        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 132
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = mediaArr[indexPath.row].previewUrl {
            if let artworkUrl = mediaArr[indexPath.row].artworkUrl100 {
                privewUrl(url: url, artworkUrl: artworkUrl)
            }
        }
    }

}


extension MediaVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getData(term: searchText, media: mediaType.rawValue)
        mediaTableView.reloadData()
    }
}


