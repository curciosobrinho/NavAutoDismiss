NavAutoDismiss
==============

Really nice and easy way to dismiss any modal on iPads (tap outside the viewcontroller to dismiss the modal).

IMPORTANT:
This implementation is just a navigation implementation of 

http://stackoverflow.com/questions/9102497/dismiss-modal-view-form-sheet-controller-on-outside-tap

All credits go to the original authors..

I just thought I could make it more generic and easier to use.


How to use it:
-----------

    Copy BOTH files to your project
    
    Import the .h file
    #import "NavDismissViewController.h"
    
    //Instanciate your view controller (the view you want to present)
    
    YourViewController * yourVC = [YourViewController new];
    
    //Instanciate the NavDismissViewController with your view controller as the rootViewController
    
    NavDismissViewController *nav = [[NavDismissViewController alloc] initWithRootViewController:yourVC];
    
    //if you want to change the navigationBar translucent behaviour
    
    [nav.navigationBar setTranslucent:NO];
    
    //Choose the Modal style
    
    nav.modalPresentationStyle=UIModalPresentationFormSheet;
    
    //present your controller
    
    [self presentViewController:nav animated:YES completion:nil];
    
    //Done
