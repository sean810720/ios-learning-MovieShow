//
//  ListTableViewController.swift
//  MovieShow
//
//  Created by Sean on 2020/1/16.
//  Copyright © 2020 Sean. All rights reserved.
//

import UIKit
import SDWebImage

class ListTableViewController: UITableViewController {
    
    // 電影資料 API
    let movieDataUrl = "https://movieshowapp-3def6.firebaseio.com/MovieData.json"
       
    // 電影資料
    var movieData = [[String: String]]()
    
    // 下拉重整
    @IBOutlet weak var ListRefresh: UIRefreshControl!
    
    // 下拉重整處理
    @IBAction func listRefreshControl(_ sender: Any) {
        getMovieData()
    }
    
    // 下載電影資料
    private func getMovieData() {
        if let dataUrl = URL(string: movieDataUrl) {
            URLSession.shared.dataTask(with: dataUrl) { (data, response, error) in
                
                do {
                    if let data = data {
                        if let movieData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: String]] {
                            
                            // 強制放在主執行緒
                            DispatchQueue.main.async {
                                self.movieData = movieData
                                print("電影資料下載完成")
                                
                                self.tableView.reloadData()
                                print("頁面資料更新完成")
                                
                                self.ListRefresh.endRefreshing()
                            }
                        }
                    }
                    
                } catch {
                    print("電影資料下載失敗")
                }
                
            }.resume()
            
        } else {
            print("電影資料 API 未設定")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "本週首輪片"
        
        // 下載電影資料
        getMovieData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! ListTableViewCell
        let movie = movieData[indexPath.row]
            
        // Configure the cell...
        
        // 標題
        cell.movieTitle.text = "無資料"
        if let movie_title = movie["title"] {
            cell.movieTitle.text = movie_title
        }
        
        // IMDB 評分 - 用星星表示
        cell.movieImdbRating.text = "無評分資料"
        if let imdbRating = movie["imdb_rating"] {
            
            if imdbRating.count > 0 {
                let star      = "★"
                let star_half = "☆"
                let imdb = Double(imdbRating)!
                let star_count = Int((imdb / 12.0) * 5.0)
                let star_count_double = Double((imdb / 12.0) * 5.0)
                
                var star_show = ""
                for _ in 0...star_count {
                    star_show.append(star)
                }
                
                if (star_count_double - Double(star_count)) >= 0.5 {
                    star_show.append(star_half)
                }
                
                cell.movieImdbRating.text = star_show
            }
        }
        
        // 片長
        cell.movieRuntime.text = "片長: 無資料"
        if let runtime = movie["runtime"] {
            let hour = Int(Double(runtime)!/60.0)
            let min = Int(Double(runtime)!) - hour*60
            
            cell.movieRuntime.text = "片長: \(hour) 時 \(min) 分"
        }
        
        // 上映日
        cell.movieOpenDate.text = "無上映日資料"
        if let open_date = movie["open_date"] {
            cell.movieOpenDate.text = open_date
        }
        
        // 預告片
        // 強制放在主執行緒
        DispatchQueue.main.async {
            if let youtube_url = movie["youtube_url"] {
                if let youtube = URL(string: youtube_url) {
                    let request = URLRequest(url: youtube)
                    cell.movieYoutubeView.load(request)
                }
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}