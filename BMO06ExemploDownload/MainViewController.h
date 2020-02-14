//
//  ViewController.h
//  BMO06ExemploDownload
//
//  Created by Breno Medeiros on 10/02/20.
//  Copyright © 2020 Udemy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    IBOutlet UITextField *downloadField;
    IBOutlet UIProgressView *progressBar;
    IBOutlet UIActivityIndicatorView *loadingIndicator;
}

- (IBAction)startDownload:(id)sender;



@end

