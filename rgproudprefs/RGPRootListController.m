#import <Foundation/Foundation.h>
#import "RGPRootListController.h"
#include <spawn.h>

@implementation RGPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}


-(void)OpenGithub {
    [[UIApplication sharedApplication]
    openURL:[NSURL URLWithString:@"https://github.com"]
    options:@{}
    completionHandler:nil];
}

-(void)OpenSC {
    [[UIApplication sharedApplication]
    openURL:[NSURL URLWithString:@"https://soundcloud.com/skinnykat/tracks"]
    options:@{}
    completionHandler:nil];
}

-(void)respring {
  pid_t pid;
  const char* args[] = {"killall", "SpringBoard", NULL};
  posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(void)respringTwice {
  [self respring];
  sleep(1);
  [self respring];
}

@end


