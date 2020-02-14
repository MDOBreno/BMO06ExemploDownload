//
//  ViewController.m
//  BMO06ExemploDownload
//
//  Created by Breno Medeiros on 10/02/20.
//  Copyright © 2020 Udemy. All rights reserved.
//

#import "MainViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPRequestOperation.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)startDownload:(id)sender {
    NSURL *url = [NSURL URLWithString:downloadField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *saveFilename = [self downloadSavePathFor:url.lastPathComponent];
    NSLog(@"Salvando o arquivo em %@", saveFilename);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:saveFilename append:NO];
    
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *op, NSHTTPURLResponse *response) {
        [self->loadingIndicator stopAnimating];
        self->loadingIndicator.hidden = YES;
        [self showMessage:@"Download finalizado com sucesso"];
    } failure:^(AFHTTPRequestOperation *op, NSError *error) {
        [self showMessage:[NSString stringWithFormat:@"Erro no download: %@",[error localizedDescription]]];
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger read, long long totalRead, long long totalExpected) {
        self->progressBar.progress = (float)totalRead / (float)totalExpected;
    }];
    progressBar.hidden = NO;
    loadingIndicator.hidden = NO;
    [loadingIndicator startAnimating];
    
    [operation start];
}

-(NSString*)downloadSavePathFor:(NSString*)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:filename];
}

-(void) showMessage:(NSString *) message {
    /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show]; */
    
    UIAlertController* alerta = [UIAlertController alertControllerWithTitle:@"Aviso"
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alerta addAction:defaultAction];
    [self presentViewController:alerta animated:YES completion:nil];
}

@end
