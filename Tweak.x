#import <UIKit/UIKit.h>

// Método para obtener el path de las preferencias dinámicamente en un entorno rootless
NSString* getDynamicPreferencesPath() {
    // Obtener el UUID del directorio de la aplicación en rootless
    NSString *appSupportPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES).firstObject;
    NSString *preferencesPath = [appSupportPath stringByAppendingPathComponent:@"/Preferences/com.aldev.bordertweak.plist"]; // Ruta del plist
    return preferencesPath;
}

%hook SpringBoard

- (void)applicationDidBecomeActive:(id)application {
    %orig(application);

    // Obtener la ventana principal de manera compatible con iOS 13+
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;

    // Cargar el path dinámico de las preferencias
    NSString *preferencesPath = getDynamicPreferencesPath();

    // Cargar las preferencias del archivo .plist
    NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile:preferencesPath];
    if (!preferences) {
        // Si no se pudo cargar el archivo, mostrar mensaje de depuración y usar valores por defecto
        NSLog(@"ScreenBorder Tweak: No se pudieron cargar las preferencias. Usando valores por defecto.");
        preferences = @{@"borderRadius": @5.0}; // Valor por defecto
    } else {
        NSLog(@"ScreenBorder Tweak: Preferencias cargadas correctamente desde %@", preferencesPath);
    }

    // Obtener el radio del borde desde las preferencias o usar un valor por defecto
    NSNumber *borderRadius = preferences[@"borderRadius"] ?: @5.0;

    if (mainWindow != nil) {
        // Aplicar el borde a la ventana principal
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
