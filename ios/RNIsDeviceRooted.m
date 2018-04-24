#import "RNIsDeviceRooted.h"
#import "UIKit/UIKit.h"

@implementation RNIsDeviceRooted
    
    RCT_EXPORT_MODULE(RNIsDeviceRooted);
    
    RCT_REMAP_METHOD(isDeviceRooted,
                     rootresolver:(RCTPromiseResolveBlock)resolve
                     rejecter:(RCTPromiseRejectBlock)reject)
    {
        
        @try{
            BOOL isRooted = isJailbroken();
            if (isRooted){
                resolve(@true);
            } else {
                resolve(@false);
            }
            
        } @catch (NSException *exception)
        {
            reject(@"error", @"error trying to detect jailbreaking", exception);
        }
        
    }
    
    BOOL isJailbroken()
    {
        if (!(TARGET_OS_SIMULATOR)){
            // https://developers.tune.com/sdk/detecting-ios-jailbroken-devices/#determining-if-device-is-jailbroken
            // https://www.trustwave.com/Resources/SpiderLabs-Blog/Jailbreak-Detection-Methods/
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/stash"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/tmp/cydia.log"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/cydia"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/mobile/Library/SBSettings/Themes"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/LaunchDaemons/com.ikey.bbot.plist"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/var/cache/apt"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/cydia"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/var/tmp/cydia.log"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/bin/sshd"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/libexec/sftp-server"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/RockApp.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Icy.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/WinterBoard.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/SBSettings.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/MxTube.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/IntelliScreen.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/FakeCarrier.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/blackra1n.app"] ||
                [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/cydia"] ||
                [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]])  {
                return YES;
            }
            
            FILE *f = NULL ;
            if ((f = fopen("/bin/bash", "r")) ||
                (f = fopen("/Applications/Cydia.app", "r")) ||
                (f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r")) ||
                (f = fopen("/usr/sbin/sshd", "r")) ||
                (f = fopen("/etc/apt", "r")))  {
                fclose(f);
                return YES;
            }
            fclose(f);
            
            NSError *error;
            NSString *stringToBeWritten = @"This is a test.";
            [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
            if(error == nil)
            {
                return YES;
            }
        }
        
        else{
            
            return NO;
        }
        
        return NO;
    }
    
    @end



