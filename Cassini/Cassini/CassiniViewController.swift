//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Kyuhong Jo on 2023/05/16.
//

import UIKit

class CassiniViewController: UIViewController
{
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destination as? ImageViewController {
                print(ivc)
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                ivc.title = imageName
            }
        }
    }
    

}
