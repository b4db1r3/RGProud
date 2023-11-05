#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "rootless.h"

//  02.02.2023 
//  0.0.1 - Initial Release. 

//  02.02.2023 
//  0.0.2:
//    Fixing Positioning Logic.
//    Cleaning Unused Code
//    Improved Preferences Handling
//    Added Comments 


/*------------------------------------------------------------------------------------*/

//
//                              Interfaces

@interface SBUIProudLockIconView : UIView // The Actual ProudLock Image View,Sets about half of the things || inhierts from UIView (meaning i can use everything thats under UIView in my class)
      
      @property (nonatomic, strong, readwrite) UIColor *contentColor; // color the proudlock (in bounds)
      
      @property (assign, nonatomic) long long state; // for checking if the user is autenticated or not (returns 0/1/2)
     
      - (void)setContentColor:(UIColor *)arg1; // 1 method for the color changes besides layoutSubviews

@end


@interface BSUICAPackageView : UIView // More Like A Frame Class, Sets about the other half of the things that SBUIProudLockIconView doesnt || inhierts from UIView
      
      @property (nonatomic,assign,readwrite) CGRect frame; // frame property from UIView
    
      -(void)setFrame:(CGRect)arg1; //  above method setter 
    
      -(void)setBounds:(CGRect)bounds; // set the boundries of the proudlock 
@end 



//                              Functions
#define RGProudPrefs ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.b4db1r3.rgproudprefs.plist")  // defining my preferences location on the device
#define CGRectSetValues(rect, x, y, width, height) CGRectMake(x, y, width, height) // defining my method for bonderies calc's



//                              Static Varibales (meaning: i can use them where ever i want in my code. they are static - not related to any context) || 
                                         //  Uses: 
                                        //  for the user input values, 
                                       //  check if tweak is enabled  
                                      // decide which theme user choose


static BOOL tweakEnabled = YES; // Default value
static CGFloat xposition ; // x-axis position
static CGFloat yposition ; // y-axis position
static CGFloat wposition ; // width
static CGFloat hposition ; // height
static BOOL brightTheme = NO; 
static BOOL mediumTheme = NO;
static BOOL darkTheme = YES; // YES For default value.


%hook SBUIProudLockIconView

-(void)setContentColor:(UIColor *)arg1 //Setting most of the time, but not always, hence why im using layoutSubviews below
{

            //  Dark Color Loop
    if(tweakEnabled && self.state == 2 && darkTheme == YES)
            {

              %orig ([UIColor colorWithRed:0.0 green:0.25 blue:0.0 alpha:1.0]);
            }

    if ((tweakEnabled && self.state!= 2 && darkTheme == YES)) 
            {

              %orig ([UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0]); // dark red
   
            } // End Dark Color Loop
            

           //  Medium Color Loop
       if(tweakEnabled && self.state == 2 && mediumTheme == YES)
            {
              
              %orig ([UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0]);
            }
   
       if ((tweakEnabled && self.state!= 2 && mediumTheme == YES)) 
            {
   
              %orig ([UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0]); // Medium red
    
            } //  End Of Medium Color Loop
          

        //Bright Color Loop 
       if(tweakEnabled && self.state == 2 && brightTheme == YES)
            {
            
              %orig ([UIColor greenColor]);
            }
    
        if ((tweakEnabled && self.state!= 2 && brightTheme == YES)) 
            {
          
              %orig ([UIColor redColor]); // Medium red
            } //  End Of Bright Color Loop 


    } 
///
-(void)layoutSubviews // fixing some of the setContentColor method coloring. 
{
              %orig;

        //  Dark Color Loop
        if(tweakEnabled && self.state == 2 && darkTheme == YES) 
        {
         
              self.contentColor = ([UIColor colorWithRed:0.0 green:0.25 blue:0.0 alpha:1.0]);
        
        }
        
        if ((tweakEnabled && self.state!= 2 && darkTheme == YES))
        {
      
              self.contentColor = ([UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0]);
      
        }         // End Of Dark Color Loop

            //  Medium Color Loop
        if(tweakEnabled && self.state == 2 && mediumTheme == YES) 
        {

                self.contentColor = ([UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0]);
        
        }
       
        if ((tweakEnabled && self.state!= 2 && mediumTheme == YES))
        {
     
                self.contentColor = ([UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1.0]);
       
        }             // End Of Medium Color Loop


            //Bright Color Loop
        if(tweakEnabled && self.state == 2 && brightTheme == YES) 
        {
         
                self.contentColor = ([UIColor greenColor]);
        
        }
        
        if ((tweakEnabled && self.state!= 2 && brightTheme == YES))
        {
      
                self.contentColor = ([UIColor redColor]);
       
        }             //End Of Bright Color Loop
    
} 

        //  Setting the proudlock frame
-(void)setFrame:(CGRect)frame {
  
        //  Extracting Original Attributes (for first use, and that the user will be able to adjust them. when disabling the tweak it goes back to original frame.)
    CGFloat originalX = frame.origin.x;
    CGFloat originalY = frame.origin.y;
    CGFloat originalWidth = frame.size.width;
    CGFloat originalHeight = frame.size.height;

          if(tweakEnabled == YES) 
          {       // I am override every attribute in this method (if you wodering why i left H+W its because im laze. but it wont do anything becuase this method does not effect the H+W, only effects on X+Y)
                  %orig(CGRectSetValues(frame, xposition,  yposition,  wposition,  hposition));
          }
    
          if(tweakEnabled == NO) 
          {       // Return to the original device values
                  %orig(CGRectSetValues(frame, originalX , originalY, originalWidth, originalHeight));

          }
} 
%end // End SBUIProudLockIconView//

//
//  This class responsibale for Width & Height but not for X & Y values.
%hook BSUICAPackageView 
-(void)setBounds:(CGRect)bounds 
{
      //  Extracting Original Attributes 
    CGFloat originalXb = bounds.origin.x;
    CGFloat originalYB = bounds.origin.y;
    CGFloat originalWidthB = bounds.size.width;
    CGFloat originalHeightB = bounds.size.height;
           
           
            if(tweakEnabled == YES) 
            {
                          // Setting Only W+H But not X+Y Becuase its not affecting the values. X+Y values are affect from SBUIProudLockIconView (setFrame Method). -- yes, i had to dig deep to understand that. a little confusing apple...
                    %orig(CGRectSetValues(bounds, originalXb  ,originalYB ,originalWidthB + wposition ,originalHeightB  + hposition));
            
            }
          
            if(tweakEnabled == NO) 
          {
        
                    %orig(CGRectSetValues(bounds, originalXb  ,originalYB ,originalWidthB ,originalHeightB));
         
          }
}
%end // End BSUICAPackageView



static NSString *const domain = @"com.b4db1r3.rgproudprefs";
static NSString *const preferencesNotification = @"com.b4db1r3.rgproudprefs/settingschanged";

@interface NSUserDefaults (SoundPalette)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

#define LISTEN_NOTIF(_call, _name) CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)_call, CFSTR(_name), NULL, CFNotificationSuspensionBehaviorCoalesce);

// Prefs global variables

void loadPrefs() {
    // Fetch the NSUserDefaults for your tweak
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.b4db1r3.rgproudprefs"];
    if (prefs) {

           tweakEnabled = ([prefs objectForKey:@"tweakEnabled"]  ?    [[prefs objectForKey:@"tweakEnabled"] boolValue] : tweakEnabled );
        xposition =    ([prefs objectForKey:@"xposition"]     ?    [[prefs objectForKey:@"xposition"] floatValue] : xposition );
        yposition =    ([prefs objectForKey:@"yposition"]     ?    [[prefs objectForKey:@"yposition"] floatValue] : yposition );
        hposition =    ([prefs objectForKey:@"hposition"]     ?    [[prefs objectForKey:@"hposition"] floatValue] : hposition );
        wposition =    ([prefs objectForKey:@"wposition"]     ?    [[prefs objectForKey:@"wposition"] floatValue] : wposition );
        brightTheme =  ([prefs objectForKey:@"brightTheme"]   ?    [[prefs objectForKey:@"brightTheme"] boolValue] : brightTheme);
        mediumTheme =  ([prefs objectForKey:@"mediumTheme"]   ?    [[prefs objectForKey:@"mediumTheme"] boolValue] : mediumTheme);
        darkTheme =    ([prefs objectForKey:@"darkTheme"]     ?    [[prefs objectForKey:@"darkTheme"] boolValue] : darkTheme);

    }
}

%ctor {
     loadPrefs();
     LISTEN_NOTIF(loadPrefs, "com.b4db1r3.rgproudprefs/settingschanged")	
}

//