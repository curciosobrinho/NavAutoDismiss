//
//  NavDismissViewController.m
//
//  Created by Curcio J Sobrinho on 24/09/14.
//
//

#import "NavDismissViewController.h"

@interface NavDismissViewController (){
    
    UITapGestureRecognizer * tapBehindGesture;
}


@end

@implementation NavDismissViewController

-(BOOL) shouldAutorotate {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return YES;
    }
    
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        return UIInterfaceOrientationMaskAll;
    }
    
    return (UIInterfaceOrientationMaskPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    //se quiser passar tamanho
    
    if (self.mySize.width>0) {
        self.preferredContentSize = CGSizeMake(self.mySize.width,self.mySize.height);
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) viewDidAppear:(BOOL)animated {
    
    if(!tapBehindGesture) {
        tapBehindGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBehindDetected:)];
        [tapBehindGesture setNumberOfTapsRequired:1];
        [tapBehindGesture setCancelsTouchesInView:NO]; //So the user can still interact with controls in the modal view
        [tapBehindGesture setDelegate:self];
    }
    
    UIView *view = [[self.viewControllers lastObject] view];
    
    [view.window addGestureRecognizer:tapBehindGesture];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.view.window removeGestureRecognizer:tapBehindGesture];
}

- (void)tapBehindDetected:(UITapGestureRecognizer *)sender
{
   // NSLog(@"tapBehindDetected");
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        UIView *view = [[self.viewControllers lastObject] view];
        
        CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
        
        //NSLog(@"na window=%@ e na view=%@", NSStringFromCGPoint(location), NSStringFromCGPoint([sender locationInView:view]));
        
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            location = CGPointMake(location.y, location.x);
        }
        
        
        
        //Convert tap location into the local view's coordinate system. If outside, dismiss the view.
        if (![view pointInside:[view convertPoint:location fromView:view.window] withEvent:nil])
        {
            if(view) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}

#pragma mark - UIGestureRecognizer Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
