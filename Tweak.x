#import <UIKit/UIKit.h>

// Método para obtener el path de las preferencias dinámicamente en un entorno rootless
NSString* getDynamicPreferencesPath() {
    // Obtener el UUID del directorio de la aplicación en rootless
    NSString *appSupportPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    NSString *preferencesPath = [appSupportPath stringByAppendingPathComponent:@"/Preferences/com.tuusuario.bordertweak.plist"]; // Ruta del plist
    return preferencesPath;
}

%hook SpringBoard

- (void)applicationDidBecomeActive:(id)application {
    %orig(application);

    // Obtener la ventana principal de manera compatible con iOS 13+
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;

    // Cargar el path dinámico de las preferencias
    NSString *preferencesPath = getDynamicPreferencesPath();

    // Cargar el radio del borde desde las preferencias
    NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:preferencesPath];
    NSNumber *borderRadius = preferences[@"borderRadius"] ?: @5.0; // Valor por defecto si no hay configuraciones
    
    if (mainWindow != nil) {
        mainWindow.layer.borderColor = [UIColor blackColor].CGColor;
        mainWindow.layer.borderWidth = 5.0; // Grosor del borde negro
        mainWindow.layer.cornerRadius = [borderRadius floatValue]; // Aplicar radio personalizado
        mainWindow.clipsToBounds = YES;

        // Mensaje de depuración para verificar si las preferencias están cargadas
        NSLog(@"ScreenBorder Tweak: Radio del borde aplicado: %@", borderRadius);
    } else {
        NSLog(@"ScreenBorder Tweak: No se pudo obtener la ventana principal.");
    }
}

%end
