#import <UIKit/UIKit.h>

#define PREFERENCES_PATH @"/var/mobile/Library/Preferences/com.tuusuario.bordertweak.plist"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig(application);

    // Agrega bordes a la pantalla principal con radio personalizado
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    // Cargar el radio del borde desde las preferencias
    NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:PREFERENCES_PATH];
    NSNumber *borderRadius = preferences[@"borderRadius"] ?: @5.0; // Valor por defecto si no hay configuraciones
    
    mainWindow.layer.borderColor = [UIColor blackColor].CGColor;
    mainWindow.layer.borderWidth = 5.0; // Grosor del borde negro
    mainWindow.layer.cornerRadius = [borderRadius floatValue]; // Aplicar radio personalizado
    mainWindow.clipsToBounds = YES;
}

%end

