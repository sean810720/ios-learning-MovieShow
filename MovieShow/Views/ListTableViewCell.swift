//
//  ListTableViewCell.swift
//  MovieShow
//
//  Created by Sean on 2020/1/17.
//  Copyright © 2020 Sean. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ListTableViewCell: UITableViewCell {
    
    // Youtube 預告片
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    // 標題
    @IBOutlet weak var movieTitle: UILabel!
    
    // IMDB 評分
    @IBOutlet weak var movieImdbRating: UILabel!
    
    // 片長
    @IBOutlet weak var movieRuntime: UILabel!
    
    // 上映日
    @IBOutlet weak var movieOpenDate: UILabel!
}
