class LocalizationTemplates {
  // Supported languages with their codes
  static const Map<String, String> supportedLanguages = {
    // International Languages
    'en': 'English',
    'es': 'Spanish (Español)',
    'fr': 'French (Français)',
    'de': 'German (Deutsch)',
    'it': 'Italian (Italiano)',
    'pt': 'Portuguese (Português)',
    'ru': 'Russian (Русский)',
    'zh': 'Chinese (中文)',
    'ja': 'Japanese (日本語)',
    'ar': 'Arabic (العربية)',

    // Indian Languages
    'hi': 'Hindi (हिन्दी)',
    'bn': 'Bengali (বাংলা)',
    'te': 'Telugu (తెలుగు)',
    'mr': 'Marathi (मराठी)',
    'ta': 'Tamil (தமிழ்)',
    'gu': 'Gujarati (ગુજરાતી)',
    'kn': 'Kannada (ಕನ್ನಡ)',
    'ml': 'Malayalam (മലയാളം)',
    'pa': 'Punjabi (ਪੰਜਾਬੀ)',
    'or': 'Odia (ଓଡ଼ିଆ)',
  };

  // Generate l10n.yaml configuration
  static String generateL10nConfig(List<String> selectedLanguages) {
    return '''
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
synthetic-package: false
output-class: AppLocalizations
''';
  }

  // Generate English ARB file (template)
  static String generateEnglishArb() {
    return '''
{
  "@@locale": "en",
  "appTitle": "Demo App",
  "@appTitle": {
    "description": "The application title"
  },
  "welcome": "Welcome",
  "@welcome": {
    "description": "Welcome message"
  },
  "hello": "Hello",
  "@hello": {
    "description": "Greeting message"
  },
  "login": "Login",
  "@login": {
    "description": "Login button text"
  },
  "signup": "Sign Up",
  "@signup": {
    "description": "Sign up button text"
  },
  "email": "Email",
  "@email": {
    "description": "Email field label"
  },
  "password": "Password",
  "@password": {
    "description": "Password field label"
  },
  "username": "Username",
  "@username": {
    "description": "Username field label"
  },
  "phone": "Phone Number",
  "@phone": {
    "description": "Phone number field label"
  },
  "forgotPassword": "Forgot Password?",
  "@forgotPassword": {
    "description": "Forgot password link text"
  },
  "home": "Home",
  "@home": {
    "description": "Home screen title"
  },
  "profile": "Profile",
  "@profile": {
    "description": "Profile screen title"
  },
  "settings": "Settings",
  "@settings": {
    "description": "Settings screen title"
  },
  "logout": "Logout",
  "@logout": {
    "description": "Logout button text"
  },
  "save": "Save",
  "@save": {
    "description": "Save button text"
  },
  "cancel": "Cancel",
  "@cancel": {
    "description": "Cancel button text"
  },
  "delete": "Delete",
  "@delete": {
    "description": "Delete button text"
  },
  "edit": "Edit",
  "@edit": {
    "description": "Edit button text"
  },
  "search": "Search",
  "@search": {
    "description": "Search field placeholder"
  },
  "loading": "Loading...",
  "@loading": {
    "description": "Loading indicator text"
  },
  "error": "Error",
  "@error": {
    "description": "Error message title"
  },
  "success": "Success",
  "@success": {
    "description": "Success message title"
  },
  "confirm": "Confirm",
  "@confirm": {
    "description": "Confirm button text"
  },
  "yes": "Yes",
  "@yes": {
    "description": "Yes option"
  },
  "no": "No",
  "@no": {
    "description": "No option"
  },
  "back": "Back",
  "@back": {
    "description": "Back button text"
  },
  "next": "Next",
  "@next": {
    "description": "Next button text"
  },
  "skip": "Skip",
  "@skip": {
    "description": "Skip button text"
  },
  "done": "Done",
  "@done": {
    "description": "Done button text"
  },
  "viewAll": "View All",
  "@viewAll": {
    "description": "View all items link"
  },
  "noDataFound": "No data found",
  "@noDataFound": {
    "description": "Empty state message"
  },
  "chatbot": "AI Assistant",
  "@chatbot": {
    "description": "Chatbot screen title"
  },
  "typeMessage": "Type your message...",
  "@typeMessage": {
    "description": "Chat input placeholder"
  },
  "thinking": "Thinking...",
  "@thinking": {
    "description": "AI thinking indicator"
  },
  "selectLanguage": "Select Language",
  "@selectLanguage": {
    "description": "Language selection tooltip"
  },
  "welcomeDeveloper": "Welcome Developer!",
  "@welcomeDeveloper": {
    "description": "Welcome message for developers"
  },
  "startCodingMessage": "Start coding your app by customizing this home screen.",
  "@startCodingMessage": {
    "description": "Instruction message for developers"
  },
  "photoGallery": "Photo Gallery",
  "@photoGallery": {
    "description": "Photo gallery section title"
  },
  "takePhoto": "Take Photo",
  "@takePhoto": {
    "description": "Take photo button text"
  },
  "pickImage": "Pick Image",
  "@pickImage": {
    "description": "Pick image from gallery button text"
  },
  "viewPhotos": "View Photos ({count})",
  "@viewPhotos": {
    "description": "View photos button with count",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "calling": "Calling",
  "@calling": {
    "description": "Calling section title"
  },
  "makeACall": "Make a Call",
  "@makeACall": {
    "description": "Make a call card title"
  },
  "quicklyDialNumber": "Quickly dial a phone number",
  "@quicklyDialNumber": {
    "description": "Make a call card description"
  },
  "startCall": "Start Call",
  "@startCall": {
    "description": "Start call button text"
  },
  "contacts": "Contacts",
  "@contacts": {
    "description": "Contacts section title"
  },
  "pickContact": "Pick Contact",
  "@pickContact": {
    "description": "Pick contact button text"
  },
  "savedContacts": "Saved ({count})",
  "@savedContacts": {
    "description": "Saved contacts button with count",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "call": "Call",
  "@call": {
    "description": "Call button text"
  },
  "copy": "Copy",
  "@copy": {
    "description": "Copy button text"
  },
  "aiAssistant": "AI Assistant",
  "@aiAssistant": {
    "description": "AI Assistant section title"
  },
  "chatWithAI": "Chat with AI",
  "@chatWithAI": {
    "description": "Chat with AI card title"
  },
  "askQuestionsInstant": "Ask questions and get instant answers",
  "@askQuestionsInstant": {
    "description": "AI assistant description"
  },
  "photoCapturedSuccess": "Photo captured successfully!",
  "@photoCapturedSuccess": {
    "description": "Success message after capturing photo"
  },
  "imageAddedGallery": "Image added from gallery!",
  "@imageAddedGallery": {
    "description": "Success message after picking image from gallery"
  },
  "deletePhoto": "Delete Photo",
  "@deletePhoto": {
    "description": "Delete photo dialog title"
  },
  "deletePhotoConfirm": "Are you sure you want to delete this photo?",
  "@deletePhotoConfirm": {
    "description": "Delete photo confirmation message"
  },
  "photoDeleted": "Photo deleted",
  "@photoDeleted": {
    "description": "Photo deleted success message"
  },
  "callError": "Call error: {error}",
  "@callError": {
    "description": "Call error message",
    "placeholders": {
      "error": {
        "type": "String"
      }
    }
  },
  "enterPhoneNumber": "Enter phone number",
  "@enterPhoneNumber": {
    "description": "Enter phone number dialog title"
  },
  "phoneNumberHint": "+1 555 123 4567",
  "@phoneNumberHint": {
    "description": "Phone number hint text"
  },
  "contactSelected": "Contact selected: {name}",
  "@contactSelected": {
    "description": "Contact selected success message",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  },
  "numberCopied": "{number} copied!",
  "@numberCopied": {
    "description": "Number copied success message",
    "placeholders": {
      "number": {
        "type": "String"
      }
    }
  },
  "contactAlreadySaved": "Contact already saved!",
  "@contactAlreadySaved": {
    "description": "Contact already saved message"
  },
  "contactSaved": "{name} saved!",
  "@contactSaved": {
    "description": "Contact saved success message",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  },
  "savedContactsTitle": "Saved Contacts ({count})",
  "@savedContactsTitle": {
    "description": "Saved contacts modal title with count",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "contactDeleted": "{name} deleted",
  "@contactDeleted": {
    "description": "Contact deleted message",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  },
  "errorMessage": "Error: {error}",
  "@errorMessage": {
    "description": "Generic error message",
    "placeholders": {
      "error": {
        "type": "String"
      }
    }
  },
  "photoGalleryTitle": "Photo Gallery ({count})",
  "@photoGalleryTitle": {
    "description": "Photo gallery modal title with count",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "currentLocation": "Current Location",
  "@currentLocation": {
    "description": "Location section header"
  },
  "getCurrentGPS": "Get your current GPS coordinates",
  "@getCurrentGPS": {
    "description": "Prompt to fetch GPS coordinates"
  },
  "getLocation": "Get Location",
  "@getLocation": {
    "description": "Get location button text"
  },
  "latitude": "Latitude",
  "@latitude": {
    "description": "Latitude label"
  },
  "longitude": "Longitude",
  "@longitude": {
    "description": "Longitude label"
  },
  "altitude": "Altitude",
  "@altitude": {
    "description": "Altitude label"
  },
  "accuracy": "Accuracy",
  "@accuracy": {
    "description": "Accuracy label"
  },
  "copyCoordinates": "Copy Coordinates",
  "@copyCoordinates": {
    "description": "Copy coordinates button text"
  }
}
''';
  }

  // Generate translations for other languages
  static String generateArbFile(String languageCode) {
    final translations = _getTranslations(languageCode);

    return '''
{
  "@@locale": "$languageCode",
  "appTitle": "${translations['appTitle']}",
  "welcome": "${translations['welcome']}",
  "hello": "${translations['hello']}",
  "login": "${translations['login']}",
  "signup": "${translations['signup']}",
  "email": "${translations['email']}",
  "password": "${translations['password']}",
  "username": "${translations['username']}",
  "phone": "${translations['phone']}",
  "forgotPassword": "${translations['forgotPassword']}",
  "home": "${translations['home']}",
  "profile": "${translations['profile']}",
  "settings": "${translations['settings']}",
  "logout": "${translations['logout']}",
  "save": "${translations['save']}",
  "cancel": "${translations['cancel']}",
  "delete": "${translations['delete']}",
  "edit": "${translations['edit']}",
  "search": "${translations['search']}",
  "loading": "${translations['loading']}",
  "error": "${translations['error']}",
  "success": "${translations['success']}",
  "confirm": "${translations['confirm']}",
  "yes": "${translations['yes']}",
  "no": "${translations['no']}",
  "back": "${translations['back']}",
  "next": "${translations['next']}",
  "skip": "${translations['skip']}",
  "done": "${translations['done']}",
  "viewAll": "${translations['viewAll']}",
  "noDataFound": "${translations['noDataFound']}",
  "chatbot": "${translations['chatbot']}",
  "typeMessage": "${translations['typeMessage']}",
  "thinking": "${translations['thinking']}",
  "selectLanguage": "${translations['selectLanguage']}",
  "welcomeDeveloper": "${translations['welcomeDeveloper']}",
  "startCodingMessage": "${translations['startCodingMessage']}",
  "photoGallery": "${translations['photoGallery']}",
  "takePhoto": "${translations['takePhoto']}",
  "pickImage": "${translations['pickImage']}",
  "viewPhotos": "${translations['viewPhotos']}",
  "calling": "${translations['calling']}",
  "makeACall": "${translations['makeACall']}",
  "quicklyDialNumber": "${translations['quicklyDialNumber']}",
  "startCall": "${translations['startCall']}",
  "contacts": "${translations['contacts']}",
  "pickContact": "${translations['pickContact']}",
  "savedContacts": "${translations['savedContacts']}",
  "call": "${translations['call']}",
  "copy": "${translations['copy']}",
  "aiAssistant": "${translations['aiAssistant']}",
  "chatWithAI": "${translations['chatWithAI']}",
  "askQuestionsInstant": "${translations['askQuestionsInstant']}",
  "photoCapturedSuccess": "${translations['photoCapturedSuccess']}",
  "imageAddedGallery": "${translations['imageAddedGallery']}",
  "deletePhoto": "${translations['deletePhoto']}",
  "deletePhotoConfirm": "${translations['deletePhotoConfirm']}",
  "photoDeleted": "${translations['photoDeleted']}",
  "callError": "${translations['callError']}",
  "enterPhoneNumber": "${translations['enterPhoneNumber']}",
  "phoneNumberHint": "${translations['phoneNumberHint']}",
  "contactSelected": "${translations['contactSelected']}",
  "numberCopied": "${translations['numberCopied']}",
  "contactAlreadySaved": "${translations['contactAlreadySaved']}",
  "contactSaved": "${translations['contactSaved']}",
  "savedContactsTitle": "${translations['savedContactsTitle']}",
  "contactDeleted": "${translations['contactDeleted']}",
  "errorMessage": "${translations['errorMessage']}",
  "photoGalleryTitle": "${translations['photoGalleryTitle']}",
  "currentLocation": "${translations['currentLocation']}",
  "getCurrentGPS": "${translations['getCurrentGPS']}",
  "getLocation": "${translations['getLocation']}",
  "latitude": "${translations['latitude']}",
  "longitude": "${translations['longitude']}",
  "altitude": "${translations['altitude']}",
  "accuracy": "${translations['accuracy']}",
  "copyCoordinates": "${translations['copyCoordinates']}"
}
''';
  }

  // Get translations for each language
  static Map<String, String> _getTranslations(String languageCode) {
    const en = {
      'appTitle': 'My App',
      'welcome': 'Welcome',
      'hello': 'Hello',
      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'username': 'Username',
      'phone': 'Phone Number',
      'forgotPassword': 'Forgot Password?',
      'home': 'Home',
      'profile': 'Profile',
      'settings': 'Settings',
      'logout': 'Logout',
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'search': 'Search',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'confirm': 'Confirm',
      'yes': 'Yes',
      'no': 'No',
      'back': 'Back',
      'next': 'Next',
      'skip': 'Skip',
      'done': 'Done',
      'viewAll': 'View All',
      'noDataFound': 'No data found',
      'chatbot': 'AI Assistant',
      'typeMessage': 'Type your message...',
      'thinking': 'Thinking...',
    };
    final translations = <String, Map<String, String>>{
      'es': {
        "@@locale": "es",
        "appTitle": "Aplicación de demostración",
        "welcome": "Bienvenido",
        "hello": "Hola",
        "login": "Iniciar Sesión",
        "signup": "Registrarse",
        "email": "Correo Electrónico",
        "password": "Contraseña",
        "username": "Nombre de Usuario",
        "phone": "Número de Teléfono",
        "forgotPassword": "¿Olvidó su Contraseña?",
        "home": "Inicio",
        "profile": "Perfil",
        "settings": "Configuración",
        "logout": "Cerrar Sesión",
        "save": "Guardar",
        "cancel": "Cancelar",
        "delete": "Eliminar",
        "edit": "Editar",
        "search": "Buscar",
        "loading": "Cargando...",
        "error": "Error",
        "success": "Éxito",
        "confirm": "Confirmar",
        "yes": "Sí",
        "no": "No",
        "back": "Atrás",
        "next": "Siguiente",
        "skip": "Omitir",
        "done": "Hecho",
        "viewAll": "Ver Todo",
        "noDataFound": "No se encontraron datos",
        "chatbot": "Asistente de IA",
        "typeMessage": "Escribe tu mensaje...",
        "thinking": "Pensando...",
        "selectLanguage": "Seleccionar Idioma",
        "welcomeDeveloper": "¡Bienvenido Desarrollador!",
        "startCodingMessage":
            "Comienza a programar tu aplicación personalizando esta pantalla de inicio.",
        "photoGallery": "Galería de Fotos",
        "takePhoto": "Tomar Foto",
        "pickImage": "Elegir Imagen",
        "viewPhotos": "Ver Fotos ({count})",
        "calling": "Llamadas",
        "makeACall": "Hacer una Llamada",
        "quicklyDialNumber": "Marca rápidamente un número de teléfono",
        "startCall": "Iniciar Llamada",
        "contacts": "Contactos",
        "pickContact": "Elegir Contacto",
        "savedContacts": "Guardados ({count})",
        "call": "Llamar",
        "copy": "Copiar",
        "aiAssistant": "Asistente de IA",
        "chatWithAI": "Chatear con IA",
        "askQuestionsInstant": "Haz preguntas y obtén respuestas instantáneas",
        "photoCapturedSuccess": "¡Foto capturada exitosamente!",
        "imageAddedGallery": "¡Imagen añadida desde la galería!",
        "deletePhoto": "Eliminar Foto",
        "deletePhotoConfirm":
            "¿Estás seguro de que quieres eliminar esta foto?",
        "photoDeleted": "Foto eliminada",
        "callError": "Error de llamada: {error}",
        "enterPhoneNumber": "Ingresa el número de teléfono",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "Contacto seleccionado: {name}",
        "numberCopied": "¡{number} copiado!",
        "contactAlreadySaved": "¡El contacto ya está guardado!",
        "contactSaved": "¡{name} guardado!",
        "savedContactsTitle": "Contactos Guardados ({count})",
        "contactDeleted": "{name} eliminado",
        "errorMessage": "Error: {error}",
        "photoGalleryTitle": "Galería de Fotos ({count})",
        "currentLocation": "Ubicación actual",
        "getCurrentGPS": "Obtén tus coordenadas GPS actuales",
        "getLocation": "Obtener ubicación",
        "latitude": "Latitud",
        "longitude": "Longitud",
        "altitude": "Altitud",
        "accuracy": "Precisión",
        "copyCoordinates": "Copiar coordenadas"
      },
      'fr': {
        "@@locale": "fr",
        "appTitle": "Application de démonstration",
        "welcome": "Bienvenue",
        "hello": "Bonjour",
        "login": "Se Connecter",
        "signup": "S'inscrire",
        "email": "Email",
        "password": "Mot de Passe",
        "username": "Nom d'Utilisateur",
        "phone": "Numéro de Téléphone",
        "forgotPassword": "Mot de Passe Oublié?",
        "home": "Accueil",
        "profile": "Profil",
        "settings": "Paramètres",
        "logout": "Se Déconnecter",
        "save": "Enregistrer",
        "cancel": "Annuler",
        "delete": "Supprimer",
        "edit": "Modifier",
        "search": "Rechercher",
        "loading": "Chargement...",
        "error": "Erreur",
        "success": "Succès",
        "confirm": "Confirmer",
        "yes": "Oui",
        "no": "Non",
        "back": "Retour",
        "next": "Suivant",
        "skip": "Passer",
        "done": "Terminé",
        "viewAll": "Voir Tout",
        "noDataFound": "Aucune donnée trouvée",
        "chatbot": "Assistant IA",
        "typeMessage": "Tapez votre message...",
        "thinking": "Réflexion...",
        "selectLanguage": "Sélectionner la Langue",
        "welcomeDeveloper": "Bienvenue Développeur!",
        "startCodingMessage":
            "Commencez à coder votre application en personnalisant cet écran d'accueil.",
        "photoGallery": "Galerie de Photos",
        "takePhoto": "Prendre une Photo",
        "pickImage": "Choisir une Image",
        "viewPhotos": "Voir les Photos ({count})",
        "calling": "Appel",
        "makeACall": "Passer un Appel",
        "quicklyDialNumber": "Composer rapidement un numéro de téléphone",
        "startCall": "Démarrer l'Appel",
        "contacts": "Contacts",
        "pickContact": "Choisir un Contact",
        "savedContacts": "Enregistrés ({count})",
        "call": "Appeler",
        "copy": "Copier",
        "aiAssistant": "Assistant IA",
        "chatWithAI": "Discuter avec l'IA",
        "askQuestionsInstant":
            "Posez des questions et obtenez des réponses instantanées",
        "photoCapturedSuccess": "Photo capturée avec succès!",
        "imageAddedGallery": "Image ajoutée depuis la galerie!",
        "deletePhoto": "Supprimer la Photo",
        "deletePhotoConfirm": "Êtes-vous sûr de vouloir supprimer cette photo?",
        "photoDeleted": "Photo supprimée",
        "callError": "Erreur d'appel: {error}",
        "enterPhoneNumber": "Entrer le numéro de téléphone",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "Contact sélectionné: {name}",
        "numberCopied": "{number} copié!",
        "contactAlreadySaved": "Contact déjà enregistré!",
        "contactSaved": "{name} enregistré!",
        "savedContactsTitle": "Contacts Enregistrés ({count})",
        "contactDeleted": "{name} supprimé",
        "errorMessage": "Erreur: {error}",
        "photoGalleryTitle": "Galerie de Photos ({count})",
        "currentLocation": "Position actuelle",
        "getCurrentGPS": "Obtenez vos coordonnées GPS actuelles",
        "getLocation": "Obtenir la position",
        "latitude": "Latitude",
        "longitude": "Longitude",
        "altitude": "Altitude",
        "accuracy": "Précision",
        "copyCoordinates": "Copier les coordonnées"
      },
      'de': {
        "@@locale": "de",
        "appTitle": "Demo-App",
        "welcome": "Willkommen",
        "hello": "Hallo",
        "login": "Anmelden",
        "signup": "Registrieren",
        "email": "E-Mail",
        "password": "Passwort",
        "username": "Benutzername",
        "phone": "Telefonnummer",
        "forgotPassword": "Passwort Vergessen?",
        "home": "Startseite",
        "profile": "Profil",
        "settings": "Einstellungen",
        "logout": "Abmelden",
        "save": "Speichern",
        "cancel": "Abbrechen",
        "delete": "Löschen",
        "edit": "Bearbeiten",
        "search": "Suchen",
        "loading": "Laden...",
        "error": "Fehler",
        "success": "Erfolg",
        "confirm": "Bestätigen",
        "yes": "Ja",
        "no": "Nein",
        "back": "Zurück",
        "next": "Weiter",
        "skip": "Überspringen",
        "done": "Fertig",
        "viewAll": "Alle Anzeigen",
        "noDataFound": "Keine Daten Gefunden",
        "chatbot": "KI-Assistent",
        "typeMessage": "Geben Sie Ihre Nachricht ein...",
        "thinking": "Denken...",
        "selectLanguage": "Sprache auswählen",
        "welcomeDeveloper": "Willkommen Entwickler!",
        "startCodingMessage":
            "Beginnen Sie mit der Codierung Ihrer App, indem Sie diesen Startbildschirm anpassen.",
        "photoGallery": "Fotogalerie",
        "takePhoto": "Foto Aufnehmen",
        "pickImage": "Bild Auswählen",
        "viewPhotos": "Fotos Ansehen ({count})",
        "calling": "Anrufe",
        "makeACall": "Anruf Tätigen",
        "quicklyDialNumber": "Schnell eine Telefonnummer wählen",
        "startCall": "Anruf Starten",
        "contacts": "Kontakte",
        "pickContact": "Kontakt Auswählen",
        "savedContacts": "Gespeichert ({count})",
        "call": "Anrufen",
        "copy": "Kopieren",
        "aiAssistant": "KI-Assistent",
        "chatWithAI": "Mit KI Chatten",
        "askQuestionsInstant":
            "Stellen Sie Fragen und erhalten Sie sofortige Antworten",
        "photoCapturedSuccess": "Foto erfolgreich aufgenommen!",
        "imageAddedGallery": "Bild aus Galerie hinzugefügt!",
        "deletePhoto": "Foto Löschen",
        "deletePhotoConfirm": "Möchten Sie dieses Foto wirklich löschen?",
        "photoDeleted": "Foto gelöscht",
        "callError": "Anruffehler: {error}",
        "enterPhoneNumber": "Telefonnummer eingeben",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "Kontakt ausgewählt: {name}",
        "numberCopied": "{number} kopiert!",
        "contactAlreadySaved": "Kontakt bereits gespeichert!",
        "contactSaved": "{name} gespeichert!",
        "savedContactsTitle": "Gespeicherte Kontakte ({count})",
        "contactDeleted": "{name} gelöscht",
        "errorMessage": "Fehler: {error}",
        "photoGalleryTitle": "Fotogalerie ({count})",
        "currentLocation": "Aktueller Standort",
        "getCurrentGPS": "Holen Sie sich Ihre aktuellen GPS-Koordinaten",
        "getLocation": "Standort abrufen",
        "latitude": "Breitengrad",
        "longitude": "Längengrad",
        "altitude": "Höhe",
        "accuracy": "Genauigkeit",
        "copyCoordinates": "Koordinaten kopieren"
      },
      'it': {
        "@@locale": "it",
        "appTitle": "App dimostrativa",
        "welcome": "Benvenuto",
        "hello": "Ciao",
        "login": "Accedi",
        "signup": "Registrati",
        "email": "Email",
        "password": "Password",
        "username": "Nome Utente",
        "phone": "Numero di Telefono",
        "forgotPassword": "Password Dimenticata?",
        "home": "Home",
        "profile": "Profilo",
        "settings": "Impostazioni",
        "logout": "Esci",
        "save": "Salva",
        "cancel": "Annulla",
        "delete": "Elimina",
        "edit": "Modifica",
        "search": "Cerca",
        "loading": "Caricamento...",
        "error": "Errore",
        "success": "Successo",
        "confirm": "Conferma",
        "yes": "Sì",
        "no": "No",
        "back": "Indietro",
        "next": "Avanti",
        "skip": "Salta",
        "done": "Fatto",
        "viewAll": "Vedi Tutto",
        "noDataFound": "Nessun Dato Trovato",
        "chatbot": "Assistente IA",
        "typeMessage": "Scrivi il tuo messaggio...",
        "thinking": "Pensando...",
        "selectLanguage": "Seleziona Lingua",
        "welcomeDeveloper": "Benvenuto Sviluppatore!",
        "startCodingMessage":
            "Inizia a codificare la tua app personalizzando questa schermata iniziale.",
        "photoGallery": "Galleria Foto",
        "takePhoto": "Scatta Foto",
        "pickImage": "Scegli Immagine",
        "viewPhotos": "Visualizza Foto ({count})",
        "calling": "Chiamate",
        "makeACall": "Fai una Chiamata",
        "quicklyDialNumber": "Componi rapidamente un numero di telefono",
        "startCall": "Inizia Chiamata",
        "contacts": "Contatti",
        "pickContact": "Scegli Contatto",
        "savedContacts": "Salvati ({count})",
        "call": "Chiama",
        "copy": "Copia",
        "aiAssistant": "Assistente IA",
        "chatWithAI": "Chatta con IA",
        "askQuestionsInstant": "Fai domande e ottieni risposte istantanee",
        "photoCapturedSuccess": "Foto scattata con successo!",
        "imageAddedGallery": "Immagine aggiunta dalla galleria!",
        "deletePhoto": "Elimina Foto",
        "deletePhotoConfirm": "Sei sicuro di voler eliminare questa foto?",
        "photoDeleted": "Foto eliminata",
        "callError": "Errore chiamata: {error}",
        "enterPhoneNumber": "Inserisci numero di telefono",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "Contatto selezionato: {name}",
        "numberCopied": "{number} copiato!",
        "contactAlreadySaved": "Contatto già salvato!",
        "contactSaved": "{name} salvato!",
        "savedContactsTitle": "Contatti Salvati ({count})",
        "contactDeleted": "{name} eliminato",
        "errorMessage": "Errore: {error}",
        "photoGalleryTitle": "Galleria Foto ({count})",
        "currentLocation": "Posizione attuale",
        "getCurrentGPS": "Ottieni le tue coordinate GPS attuali",
        "getLocation": "Ottieni posizione",
        "latitude": "Latitudine",
        "longitude": "Longitudine",
        "altitude": "Altitudine",
        "accuracy": "Precisione",
        "copyCoordinates": "Copia coordinate"
      },
      'pt': {
        "@@locale": "pt",
        "appTitle": "App Demo",
        "welcome": "Bem-vindo",
        "hello": "Olá",
        "login": "Entrar",
        "signup": "Cadastrar",
        "email": "E-mail",
        "password": "Senha",
        "username": "Nome de usuário",
        "phone": "Número de telefone",
        "forgotPassword": "Esqueceu a senha?",
        "home": "Início",
        "profile": "Perfil",
        "settings": "Configurações",
        "logout": "Sair",
        "save": "Salvar",
        "cancel": "Cancelar",
        "delete": "Excluir",
        "edit": "Editar",
        "search": "Pesquisar",
        "loading": "Carregando...",
        "error": "Erro",
        "success": "Sucesso",
        "confirm": "Confirmar",
        "yes": "Sim",
        "no": "Não",
        "back": "Voltar",
        "next": "Próximo",
        "skip": "Pular",
        "done": "Concluído",
        "viewAll": "Ver tudo",
        "noDataFound": "Nenhum dado encontrado",
        "chatbot": "Assistente de IA",
        "typeMessage": "Digite sua mensagem...",
        "thinking": "Pensando...",
        "selectLanguage": "Selecionar idioma",
        "welcomeDeveloper": "Bem-vindo Desenvolvedor!",
        "startCodingMessage":
            "Comece a codificar seu aplicativo personalizando esta tela inicial.",
        "photoGallery": "Galeria de fotos",
        "takePhoto": "Tirar foto",
        "pickImage": "Escolher imagem",
        "viewPhotos": "Ver fotos ({count})",
        "calling": "Chamadas",
        "makeACall": "Fazer uma ligação",
        "quicklyDialNumber": "Disque rapidamente um número de telefone",
        "startCall": "Iniciar chamada",
        "contacts": "Contatos",
        "pickContact": "Escolher contato",
        "savedContacts": "Salvos ({count})",
        "call": "Ligar",
        "copy": "Copiar",
        "aiAssistant": "Assistente de IA",
        "chatWithAI": "Conversar com IA",
        "askQuestionsInstant":
            "Faça perguntas e obtenha respostas instantâneas",
        "photoCapturedSuccess": "Foto capturada com sucesso!",
        "imageAddedGallery": "Imagem adicionada da galeria!",
        "deletePhoto": "Excluir foto",
        "deletePhotoConfirm": "Tem certeza de que deseja excluir esta foto?",
        "photoDeleted": "Foto excluída",
        "callError": "Erro de chamada: {error}",
        "enterPhoneNumber": "Digite o número de telefone",
        "phoneNumberHint": "+55 11 98765 4321",
        "contactSelected": "Contato selecionado: {name}",
        "numberCopied": "{number} copiado!",
        "contactAlreadySaved": "Contato já salvo!",
        "contactSaved": "{name} salvo!",
        "savedContactsTitle": "Contatos salvos ({count})",
        "contactDeleted": "{name} excluído",
        "errorMessage": "Erro: {error}",
        "photoGalleryTitle": "Galeria de fotos ({count})",
        "currentLocation": "Localização atual",
        "getCurrentGPS": "Obtenha suas coordenadas GPS atuais",
        "getLocation": "Obter localização",
        "latitude": "Latitude",
        "longitude": "Longitude",
        "altitude": "Altitude",
        "accuracy": "Precisão",
        "copyCoordinates": "Copiar coordenadas"
      },
      'ru': {
        "@@locale": "ru",
        "appTitle": "Демо приложение",
        "welcome": "Добро пожаловать",
        "hello": "Привет",
        "login": "Войти",
        "signup": "Зарегистрироваться",
        "email": "Электронная почта",
        "password": "Пароль",
        "username": "Имя пользователя",
        "phone": "Номер телефона",
        "forgotPassword": "Забыли пароль?",
        "home": "Главная",
        "profile": "Профиль",
        "settings": "Настройки",
        "logout": "Выйти",
        "save": "Сохранить",
        "cancel": "Отмена",
        "delete": "Удалить",
        "edit": "Редактировать",
        "search": "Поиск",
        "loading": "Загрузка...",
        "error": "Ошибка",
        "success": "Успешно",
        "confirm": "Подтвердить",
        "yes": "Да",
        "no": "Нет",
        "back": "Назад",
        "next": "Далее",
        "skip": "Пропустить",
        "done": "Готово",
        "viewAll": "Посмотреть все",
        "noDataFound": "Данные не найдены",
        "chatbot": "AI-ассистент",
        "typeMessage": "Введите ваше сообщение...",
        "thinking": "Думаю...",
        "selectLanguage": "Выберите язык",
        "welcomeDeveloper": "Добро пожаловать, разработчик!",
        "startCodingMessage":
            "Начните кодировать свое приложение, настроив этот главный экран.",
        "photoGallery": "Фотогалерея",
        "takePhoto": "Сделать фото",
        "pickImage": "Выбрать изображение",
        "viewPhotos": "Посмотреть фото ({count})",
        "calling": "Звонки",
        "makeACall": "Сделать звонок",
        "quicklyDialNumber": "Быстро набрать номер телефона",
        "startCall": "Начать звонок",
        "contacts": "Контакты",
        "pickContact": "Выбрать контакт",
        "savedContacts": "Сохранено ({count})",
        "call": "Позвонить",
        "copy": "Копировать",
        "aiAssistant": "AI-ассистент",
        "chatWithAI": "Общайтесь с ИИ",
        "askQuestionsInstant":
            "Задавайте вопросы и получайте мгновенные ответы",
        "photoCapturedSuccess": "Фото успешно сделано!",
        "imageAddedGallery": "Изображение добавлено из галереи!",
        "deletePhoto": "Удалить фото",
        "deletePhotoConfirm": "Вы уверены, что хотите удалить это фото?",
        "photoDeleted": "Фото удалено",
        "callError": "Ошибка звонка: {error}",
        "enterPhoneNumber": "Введите номер телефона",
        "phoneNumberHint": "+7 912 345 67 89",
        "contactSelected": "Выбран контакт: {name}",
        "numberCopied": "{number} скопирован!",
        "contactAlreadySaved": "Контакт уже сохранен!",
        "contactSaved": "{name} сохранен!",
        "savedContactsTitle": "Сохраненные контакты ({count})",
        "contactDeleted": "{name} удален",
        "errorMessage": "Ошибка: {error}",
        "photoGalleryTitle": "Фотогалерея ({count})",
        "currentLocation": "Текущее местоположение",
        "getCurrentGPS": "Получите ваши текущие GPS координаты",
        "getLocation": "Получить местоположение",
        "latitude": "Широта",
        "longitude": "Долгота",
        "altitude": "Высота",
        "accuracy": "Точность",
        "copyCoordinates": "Копировать координаты"
      },
      'hi': {
        "@@locale": "hi",
        "appTitle": "डेमो ऐप",
        "welcome": "स्वागत है",
        "hello": "नमस्ते",
        "login": "लॉगिन करें",
        "signup": "साइन अप करें",
        "email": "ईमेल",
        "password": "पासवर्ड",
        "username": "उपयोगकर्ता नाम",
        "phone": "फ़ोन नंबर",
        "forgotPassword": "पासवर्ड भूल गए?",
        "home": "होम",
        "profile": "प्रोफाइल",
        "settings": "सेटिंग्स",
        "logout": "लॉगआउट",
        "save": "सेव करें",
        "cancel": "रद्द करें",
        "delete": "हटाएं",
        "edit": "एडिट करें",
        "search": "खोजें",
        "loading": "लोड हो रहा है...",
        "error": "त्रुटि",
        "success": "सफलता",
        "confirm": "पुष्टि करें",
        "yes": "हाँ",
        "no": "नहीं",
        "back": "वापस",
        "next": "अगला",
        "skip": "स्किप करें",
        "done": "पूर्ण",
        "viewAll": "सभी देखें",
        "noDataFound": "कोई डेटा नहीं मिला",
        "chatbot": "एआई सहायक",
        "typeMessage": "अपना संदेश टाइप करें...",
        "thinking": "सोच रहा है...",
        "selectLanguage": "भाषा चुनें",
        "welcomeDeveloper": "स्वागत है डेवलपर!",
        "startCodingMessage":
            "इस होम स्क्रीन को अनुकूलित करके अपने ऐप की कोडिंग शुरू करें।",
        "photoGallery": "फोटो गैलरी",
        "takePhoto": "फोटो लें",
        "pickImage": "छवि चुनें",
        "viewPhotos": "फ़ोटो देखें ({count})",
        "calling": "कॉलिंग",
        "makeACall": "कॉल करें",
        "quicklyDialNumber": "जल्दी से फ़ोन नंबर डायल करें",
        "startCall": "कॉल शुरू करें",
        "contacts": "संपर्क",
        "pickContact": "संपर्क चुनें",
        "savedContacts": "सहेजे गए ({count})",
        "call": "कॉल करें",
        "copy": "कॉपी करें",
        "aiAssistant": "एआई सहायक",
        "chatWithAI": "एआई के साथ चैट करें",
        "askQuestionsInstant": "प्रश्न पूछें और तुरंत उत्तर प्राप्त करें",
        "photoCapturedSuccess": "फोटो सफलतापूर्वक कैप्चर की गई!",
        "imageAddedGallery": "गैलरी से छवि जोड़ी गई!",
        "deletePhoto": "फोटो हटाएं",
        "deletePhotoConfirm": "क्या आप वाकई इस फोटो को हटाना चाहते हैं?",
        "photoDeleted": "फोटो हटा दी गई",
        "callError": "कॉल त्रुटि: {error}",
        "enterPhoneNumber": "फोन नंबर दर्ज करें",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "संपर्क चुना गया: {name}",
        "numberCopied": "{number} कॉपी किया गया!",
        "contactAlreadySaved": "संपर्क पहले से सहेजा गया है!",
        "contactSaved": "{name} सहेजा गया!",
        "savedContactsTitle": "सहेजे गए संपर्क ({count})",
        "contactDeleted": "{name} हटाया गया",
        "errorMessage": "त्रुटि: {error}",
        "photoGalleryTitle": "फोटो गैलरी ({count})",
        "currentLocation": "वर्तमान स्थान",
        "getCurrentGPS": "अपने वर्तमान GPS निर्देशांक प्राप्त करें",
        "getLocation": "स्थान प्राप्त करें",
        "latitude": "अक्षांश",
        "longitude": "देशांतर",
        "altitude": "ऊंचाई",
        "accuracy": "सटीकता",
        "copyCoordinates": "निर्देशांक कॉपी करें"
      },
      'bn': {
        "@@locale": "bn",
        "appTitle": "ডেমো অ্যাপ",
        "welcome": "স্বাগতম",
        "hello": "হ্যালো",
        "login": "লগইন",
        "signup": "সাইন আপ",
        "email": "ইমেইল",
        "password": "পাসওয়ার্ড",
        "username": "ব্যবহারকারীর নাম",
        "phone": "ফোন নম্বর",
        "forgotPassword": "পাসওয়ার্ড ভুলে গেছেন?",
        "home": "হোম",
        "profile": "প্রোফাইল",
        "settings": "সেটিংস",
        "logout": "লগআউট",
        "save": "সংরক্ষণ",
        "cancel": "বাতিল",
        "delete": "মুছুন",
        "edit": "সম্পাদনা",
        "search": "অনুসন্ধান",
        "loading": "লোড হচ্ছে...",
        "error": "ত্রুটি",
        "success": "সফল",
        "confirm": "নিশ্চিত করুন",
        "yes": "হ্যাঁ",
        "no": "না",
        "back": "পিছনে",
        "next": "পরবর্তী",
        "skip": "এড়িয়ে যান",
        "done": "সম্পন্ন",
        "viewAll": "সব দেখুন",
        "noDataFound": "কোনো ডেটা পাওয়া যায়নি",
        "chatbot": "এআই সহায়ক",
        "typeMessage": "আপনার বার্তা টাইপ করুন...",
        "thinking": "চিন্তা করছে...",
        "selectLanguage": "ভাষা নির্বাচন করুন",
        "welcomeDeveloper": "স্বাগতম ডেভেলপার!",
        "startCodingMessage":
            "এই হোম স্ক্রিন কাস্টমাইজ করে আপনার অ্যাপ কোডিং শুরু করুন।",
        "photoGallery": "ফটো গ্যালারি",
        "takePhoto": "ফটো তুলুন",
        "pickImage": "ছবি নির্বাচন করুন",
        "viewPhotos": "ফটো দেখুন ({count})",
        "calling": "কলিং",
        "makeACall": "একটি কল করুন",
        "quicklyDialNumber": "দ্রুত একটি ফোন নম্বর ডায়াল করুন",
        "startCall": "কল শুরু করুন",
        "contacts": "যোগাযোগ",
        "pickContact": "যোগাযোগ নির্বাচন করুন",
        "savedContacts": "সংরক্ষিত ({count})",
        "call": "কল করুন",
        "copy": "কপি করুন",
        "aiAssistant": "এআই সহায়ক",
        "chatWithAI": "এআই এর সাথে চ্যাট করুন",
        "askQuestionsInstant": "প্রশ্ন জিজ্ঞাসা করুন এবং তাৎক্ষণিক উত্তর পান",
        "photoCapturedSuccess": "ফটো সফলভাবে ক্যাপচার করা হয়েছে!",
        "imageAddedGallery": "গ্যালারি থেকে ছবি যুক্ত করা হয়েছে!",
        "deletePhoto": "ফটো মুছুন",
        "deletePhotoConfirm": "আপনি কি নিশ্চিত এই ফটোটি মুছে ফেলতে চান?",
        "photoDeleted": "ফটো মুছে ফেলা হয়েছে",
        "callError": "কল ত্রুটি: {error}",
        "enterPhoneNumber": "ফোন নম্বর লিখুন",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "যোগাযোগ নির্বাচিত: {name}",
        "numberCopied": "{number} কপি করা হয়েছে!",
        "contactAlreadySaved": "যোগাযোগ আগেই সংরক্ষিত!",
        "contactSaved": "{name} সংরক্ষিত!",
        "savedContactsTitle": "সংরক্ষিত যোগাযোগ ({count})",
        "contactDeleted": "{name} মুছে ফেলা হয়েছে",
        "errorMessage": "ত্রুটি: {error}",
        "photoGalleryTitle": "ফটো গ্যালারি ({count})",
        "currentLocation": "বর্তমান অবস্থান",
        "getCurrentGPS": "আপনার বর্তমান GPS স্থানাঙ্ক পান",
        "getLocation": "অবস্থান পান",
        "latitude": "অক্ষাংশ",
        "longitude": "দ্রাঘিমাংশ",
        "altitude": "উচ্চতা",
        "accuracy": "নির্ভুলতা",
        "copyCoordinates": "স্থানাঙ্ক কপি করুন"
      },
      'te': {
        "@@locale": "te",
        "appTitle": "డెమో యాప్",
        "welcome": "స్వాగతం",
        "hello": "నమస్కారం",
        "login": "లాగిన్",
        "signup": "సైన్ అప్",
        "email": "ఇమెయిల్",
        "password": "పాస్‌వర్డ్",
        "username": "వినియోగదారు పేరు",
        "phone": "ఫోన్ నంబర్",
        "forgotPassword": "పాస్‌వర్డ్ మర్చిపోయారా?",
        "home": "హోమ్",
        "profile": "ప్రొఫైల్",
        "settings": "సెట్టింగులు",
        "logout": "లాగౌట్",
        "save": "సేవ్ చేయండి",
        "cancel": "రద్దు చేయండి",
        "delete": "తొలగించండి",
        "edit": "ఎడిట్ చేయండి",
        "search": "వెతకండి",
        "loading": "లోడ్ అవుతోంది...",
        "error": "లోపం",
        "success": "విజయం",
        "confirm": "నిర్ధారించండి",
        "yes": "అవును",
        "no": "కాదు",
        "back": "వెనక్కి",
        "next": "తదుపరి",
        "skip": "దాటవేయండి",
        "done": "పూర్తయింది",
        "viewAll": "అన్నీ చూడండి",
        "noDataFound": "డేటా కనుగొనబడలేదు",
        "chatbot": "AI సహాయకుడు",
        "typeMessage": "మీ సందేశాన్ని టైప్ చేయండి...",
        "thinking": "ఆలోచిస్తోంది...",
        "selectLanguage": "భాషను ఎంచుకోండి",
        "welcomeDeveloper": "డెవలపర్‌కు స్వాగతం!",
        "startCodingMessage":
            "ఈ హోమ్ స్క్రీన్‌ను కస్టమైజ్ చేయడం ద్వారా మీ యాప్ కోడింగ్ ప్రారంభించండి.",
        "photoGallery": "ఫోటో గ్యాలరీ",
        "takePhoto": "ఫోటో తీయండి",
        "pickImage": "చిత్రాన్ని ఎంచుకోండి",
        "viewPhotos": "ఫోటోలను చూడండి ({count})",
        "calling": "కాలింగ్",
        "makeACall": "కాల్ చేయండి",
        "quicklyDialNumber": "త్వరగా ఫోన్ నంబర్‌ను డయల్ చేయండి",
        "startCall": "కాల్ ప్రారంభించండి",
        "contacts": "పరిచయాలు",
        "pickContact": "పరిచయాన్ని ఎంచుకోండి",
        "savedContacts": "సేవ్ చేయబడింది ({count})",
        "call": "కాల్",
        "copy": "కాపీ",
        "aiAssistant": "AI సహాయకుడు",
        "chatWithAI": "AI తో చాట్ చేయండి",
        "askQuestionsInstant": "ప్రశ్నలు అడగండి మరియు తక్షణ సమాధానాలు పొందండి",
        "photoCapturedSuccess": "ఫోటో విజయవంతంగా క్యాప్చర్ చేయబడింది!",
        "imageAddedGallery": "గ్యాలరీ నుండి చిత్రం జోడించబడింది!",
        "deletePhoto": "ఫోటో తొలగించండి",
        "deletePhotoConfirm": "మీరు ఖచ్చితంగా ఈ ఫోటోను తొలగించాలనుకుంటున్నారా?",
        "photoDeleted": "ఫోటో తొలగించబడింది",
        "callError": "కాల్ లోపం: {error}",
        "enterPhoneNumber": "ఫోన్ నంబర్‌ను నమోదు చేయండి",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "పరిచయం ఎంచుకోబడింది: {name}",
        "numberCopied": "{number} కాపీ చేయబడింది!",
        "contactAlreadySaved": "పరిచయం ఇప్పటికే సేవ్ చేయబడింది!",
        "contactSaved": "{name} సేవ్ చేయబడింది!",
        "savedContactsTitle": "సేవ్ చేసిన పరిచయాలు ({count})",
        "contactDeleted": "{name} తొలగించబడింది",
        "errorMessage": "లోపం: {error}",
        "photoGalleryTitle": "ఫోటో గ్యాలరీ ({count})",
        "currentLocation": "ప్రస్తుత స్థానం",
        "getCurrentGPS": "మీ ప్రస్తుత GPS కోఆర్డినేట్‌లను పొందండి",
        "getLocation": "స్థానాన్ని పొందండి",
        "latitude": "అక్షాంశం",
        "longitude": "రేఖాంశం",
        "altitude": "ఎత్తు",
        "accuracy": "ఖచ్చితత్వం",
        "copyCoordinates": "కోఆర్డినేట్‌లను కాపీ చేయండి"
      },
      'mr': {
        "@@locale": "mr",
        "appTitle": "डेमो अॅप",
        "welcome": "स्वागत आहे",
        "hello": "नमस्कार",
        "login": "लॉगिन",
        "signup": "साइन अप",
        "email": "ईमेल",
        "password": "पासवर्ड",
        "username": "वापरकर्तानाव",
        "phone": "फोन नंबर",
        "forgotPassword": "पासवर्ड विसरलात?",
        "home": "होम",
        "profile": "प्रोफाइल",
        "settings": "सेटिंग्ज",
        "logout": "लॉगआउट",
        "save": "जतन करा",
        "cancel": "रद्द करा",
        "delete": "हटवा",
        "edit": "संपादित करा",
        "search": "शोधा",
        "loading": "लोड होत आहे...",
        "error": "त्रुटी",
        "success": "यश",
        "confirm": "पुष्टी करा",
        "yes": "होय",
        "no": "नाही",
        "back": "मागे",
        "next": "पुढे",
        "skip": "वगळा",
        "done": "पूर्ण झाले",
        "viewAll": "सर्व पहा",
        "noDataFound": "डेटा आढळला नाही",
        "chatbot": "AI सहाय्यक",
        "typeMessage": "तुमचा संदेश टाइप करा...",
        "thinking": "विचार करत आहे...",
        "selectLanguage": "भाषा निवडा",
        "welcomeDeveloper": "डेव्हलपरचे स्वागत आहे!",
        "startCodingMessage":
            "ही होम स्क्रीन कस्टमाइझ करून तुमचे अॅप कोडिंग सुरू करा.",
        "photoGallery": "फोटो गॅलरी",
        "takePhoto": "फोटो घ्या",
        "pickImage": "इमेज निवडा",
        "viewPhotos": "फोटो पहा ({count})",
        "calling": "कॉलिंग",
        "makeACall": "कॉल करा",
        "quicklyDialNumber": "त्वरीत फोन नंबर डायल करा",
        "startCall": "कॉल सुरू करा",
        "contacts": "संपर्क",
        "pickContact": "संपर्क निवडा",
        "savedContacts": "जतन केलेले ({count})",
        "call": "कॉल",
        "copy": "कॉपी",
        "aiAssistant": "AI सहाय्यक",
        "chatWithAI": "AI शी चॅट करा",
        "askQuestionsInstant": "प्रश्न विचारा आणि त्वरित उत्तरे मिळवा",
        "photoCapturedSuccess": "फोटो यशस्वीरित्या कॅप्चर झाला!",
        "imageAddedGallery": "गॅलरीमधून इमेज जोडली!",
        "deletePhoto": "फोटो हटवा",
        "deletePhotoConfirm":
            "तुम्हाला खात्री आहे की तुम्ही हा फोटो हटवू इच्छिता?",
        "photoDeleted": "फोटो हटवला",
        "callError": "कॉल त्रुटी: {error}",
        "enterPhoneNumber": "फोन नंबर प्रविष्ट करा",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "संपर्क निवडला: {name}",
        "numberCopied": "{number} कॉपी केला!",
        "contactAlreadySaved": "संपर्क आधीच जतन केला आहे!",
        "contactSaved": "{name} जतन केला!",
        "savedContactsTitle": "जतन केलेले संपर्क ({count})",
        "contactDeleted": "{name} हटवला",
        "errorMessage": "त्रुटी: {error}",
        "photoGalleryTitle": "फोटो गॅलरी ({count})",
        "currentLocation": "सध्याचे स्थान",
        "getCurrentGPS": "तुमचे सध्याचे GPS निर्देशांक मिळवा",
        "getLocation": "स्थान मिळवा",
        "latitude": "अक्षांश",
        "longitude": "रेखांश",
        "altitude": "उंची",
        "accuracy": "अचूकता",
        "copyCoordinates": "निर्देशांक कॉपी करा"
      },
      'ta': {
        "@@locale": "ta",
        "appTitle": "டெமோ ஆப்",
        "welcome": "வரவேற்கிறோம்",
        "hello": "வணக்கம்",
        "login": "உள்நுழைய",
        "signup": "பதிவு செய்ய",
        "email": "மின்னஞ்சல்",
        "password": "கடவுச்சொல்",
        "username": "பயனர் பெயர்",
        "phone": "தொலைபேசி எண்",
        "forgotPassword": "கடவுச்சொல்லை மறந்துவிட்டீர்களா?",
        "home": "முகப்பு",
        "profile": "சுயவிவரம்",
        "settings": "அமைப்புகள்",
        "logout": "வெளியேறு",
        "save": "சேமி",
        "cancel": "ரத்து செய்",
        "delete": "நீக்கு",
        "edit": "திருத்து",
        "search": "தேடு",
        "loading": "ஏற்றுகிறது...",
        "error": "பிழை",
        "success": "வெற்றி",
        "confirm": "உறுதிப்படுத்து",
        "yes": "ஆம்",
        "no": "இல்லை",
        "back": "பின்செல்",
        "next": "அடுத்து",
        "skip": "தவிர்",
        "done": "முடிந்தது",
        "viewAll": "அனைத்தையும் பார்",
        "noDataFound": "தரவு எதுவும் இல்லை",
        "chatbot": "AI உதவியாளர்",
        "typeMessage": "உங்கள் செய்தியை தட்டச்சு செய்யவும்...",
        "thinking": "சிந்திக்கிறது...",
        "selectLanguage": "மொழியைத் தேர்ந்தெடு",
        "welcomeDeveloper": "உருவாக்குநருக்கு வரவேற்பு!",
        "startCodingMessage":
            "இந்த முகப்பு திரையை தனிப்பயனாக்குவதன் மூலம் உங்கள் பயன்பாட்டை குறியீட்டில் தொடங்குங்கள்.",
        "photoGallery": "புகைப்பட தொகுப்பு",
        "takePhoto": "புகைப்படம் எடு",
        "pickImage": "படத்தைத் தேர்ந்தெடு",
        "viewPhotos": "புகைப்படங்களைக் காண்க ({count})",
        "calling": "அழைத்தல்",
        "makeACall": "அழைப்பு செய்",
        "quicklyDialNumber": "விரைவாக தொலைபேசி எண்ணை டயல் செய்யவும்",
        "startCall": "அழைப்பைத் தொடங்கு",
        "contacts": "தொடர்புகள்",
        "pickContact": "தொடர்பைத் தேர்ந்தெடு",
        "savedContacts": "சேமிக்கப்பட்டது ({count})",
        "call": "அழை",
        "copy": "நகலெடு",
        "aiAssistant": "AI உதவியாளர்",
        "chatWithAI": "AI உடன் அரட்டை",
        "askQuestionsInstant": "கேள்விகள் கேட்டு உடனடி பதில்களைப் பெறுங்கள்",
        "photoCapturedSuccess": "புகைப்படம் வெற்றிகரமாக எடுக்கப்பட்டது!",
        "imageAddedGallery": "தொகுப்பிலிருந்து படம் சேர்க்கப்பட்டது!",
        "deletePhoto": "புகைப்படத்தை நீக்கு",
        "deletePhotoConfirm": "இந்த புகைப்படத்தை நீக்க விரும்புகிறீர்களா?",
        "photoDeleted": "புகைப்படம் நீக்கப்பட்டது",
        "callError": "அழைப்பு பிழை: {error}",
        "enterPhoneNumber": "தொலைபேசி எண்ணை உள்ளிடவும்",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "தேர்ந்தெடுக்கப்பட்ட தொடர்பு: {name}",
        "numberCopied": "{number} நகலெடுக்கப்பட்டது!",
        "contactAlreadySaved": "தொடர்பு ஏற்கனவே சேமிக்கப்பட்டது!",
        "contactSaved": "{name} சேமிக்கப்பட்டது!",
        "savedContactsTitle": "சேமிக்கப்பட்ட தொடர்புகள் ({count})",
        "contactDeleted": "{name} நீக்கப்பட்டது",
        "errorMessage": "பிழை: {error}",
        "photoGalleryTitle": "புகைப்பட தொகுப்பு ({count})",
        "currentLocation": "தற்போதைய இடம்",
        "getCurrentGPS": "உங்கள் தற்போதைய GPS ஆயத்தொலைவுகளைப் பெறுங்கள்",
        "getLocation": "இடத்தைப் பெறுங்கள்",
        "latitude": "அட்சரேகை",
        "longitude": "தீர்க்கரேகை",
        "altitude": "உயரம்",
        "accuracy": "துல்லியம்",
        "copyCoordinates": "ஆயத்தொலைவுகளை நகலெடுக்கவும்"
      },
      'gu': {
        "@@locale": "gu",
        "appTitle": "ડેમો એપ",
        "welcome": "સ્વાગત છે",
        "hello": "નમસ્તે",
        "login": "લૉગિન",
        "signup": "સાઇન અપ",
        "email": "ઈમેલ",
        "password": "પાસવર્ડ",
        "username": "વપરાશકર્તા નામ",
        "phone": "ફોન નંબર",
        "forgotPassword": "પાસવર્ડ ભૂલી ગયા?",
        "home": "હોમ",
        "profile": "પ્રોફાઇલ",
        "settings": "સેટિંગ્સ",
        "logout": "લૉગઆઉટ",
        "save": "સાચવો",
        "cancel": "રદ કરો",
        "delete": "કાઢી નાખો",
        "edit": "સંપાદિત કરો",
        "search": "શોધો",
        "loading": "લોડ થઈ રહ્યું છે...",
        "error": "ભૂલ",
        "success": "સફળતા",
        "confirm": "પુષ્ટિ કરો",
        "yes": "હા",
        "no": "ના",
        "back": "પાછળ",
        "next": "આગળ",
        "skip": "છોડો",
        "done": "પૂર્ણ",
        "viewAll": "બધું જુઓ",
        "noDataFound": "કોઈ ડેટા મળ્યો નથી",
        "chatbot": "AI સહાયક",
        "typeMessage": "તમારો સંદેશ ટાઇપ કરો...",
        "thinking": "વિચારી રહ્યું છે...",
        "selectLanguage": "ભાષા પસંદ કરો",
        "welcomeDeveloper": "ડેવલપરનું સ્વાગત છે!",
        "startCodingMessage":
            "આ હોમ સ્ક્રીનને કસ્ટમાઇઝ કરીને તમારી એપ કોડિંગ શરૂ કરો.",
        "photoGallery": "ફોટો ગેલરી",
        "takePhoto": "ફોટો લો",
        "pickImage": "ચિત્ર પસંદ કરો",
        "viewPhotos": "ફોટો જુઓ ({count})",
        "calling": "કોલિંગ",
        "makeACall": "કોલ કરો",
        "quicklyDialNumber": "ઝડપથી ફોન નંબર ડાયલ કરો",
        "startCall": "કોલ શરૂ કરો",
        "contacts": "સંપર્કો",
        "pickContact": "સંપર્ક પસંદ કરો",
        "savedContacts": "સાચવેલા ({count})",
        "call": "કોલ કરો",
        "copy": "કોપી કરો",
        "aiAssistant": "AI સહાયક",
        "chatWithAI": "AI સાથે ચેટ કરો",
        "askQuestionsInstant": "પ્રશ્નો પૂછો અને તુરંત જવાબો મેળવો",
        "photoCapturedSuccess": "ફોટો સફળતાપૂર્વક કેપ્ચર થયો!",
        "imageAddedGallery": "ગેલરીમાંથી ચિત્ર જોડાયું!",
        "deletePhoto": "ફોટો કાઢી નાખો",
        "deletePhotoConfirm": "શું તમે ખરેખર આ ફોટો કાઢી નાખવા માંગો છો?",
        "photoDeleted": "ફોટો કાઢ્યો",
        "callError": "કોલ શુદ્ધ: {error}",
        "enterPhoneNumber": "ફોન નંબર દાખલ કરો",
        "phoneNumberHint": "+1 555 123 4567",
        "contactSelected": "સંપર્ક પસંદ કર્યો: {name}",
        "numberCopied": "{number} કોપી થયો!",
        "contactAlreadySaved": "સંપર્ક પહેલાથી સાચવ્યો છે!",
        "contactSaved": "{name} સાચવ્યો!",
        "savedContactsTitle": "સાચવેલા સંપર્કો ({count})",
        "contactDeleted": "{name} કાઢ્યો",
        "errorMessage": "શુદ્ધ: {error}",
        "photoGalleryTitle": "ફોટો ગેલરી ({count})",
        "currentLocation": "વર્તમાન સ્થાન",
        "getCurrentGPS": "તમારા વર્તમાન GPS કોઓર્ડિનેટ્સ મેળવો",
        "getLocation": "સ્થાન મેળવો",
        "latitude": "અક્ષાંશ",
        "longitude": "રેખાંશ",
        "altitude": "ઊંચાઈ",
        "accuracy": "ચોકસાઈ",
        "copyCoordinates": "કોઓર્ડિનેટ્સ કૉપિ કરો"
      },
      'kn': {
        "@@locale": "kn",
        "appTitle": "ಡೆಮೋ ಅಪ್ಲಿಕೇಶನ್",
        "welcome": "ಸುಸ್ವಾಗತ",
        "hello": "ನಮಸ್ಕಾರ",
        "login": "ಲಾಗಿನ್",
        "signup": "ಸೈನ್ ಅಪ್",
        "email": "ಇಮೇಲ್",
        "password": "ಪಾಸ್‌ವರ್ಡ್",
        "username": "ಬಳಕೆದಾರ ಹೆಸರು",
        "phone": "ಫೋನ್ ಸಂಖ್ಯೆ",
        "forgotPassword": "ಪಾಸ್‌ವರ್ಡ್ ಮರೆತಿರುವಿರಾ?",
        "home": "ಮುಖಪುಟ",
        "profile": "ಪ್ರೊಫೈಲ್",
        "settings": "ಸೆಟ್ಟಿಂಗ್‌ಗಳು",
        "logout": "ಲಾಗ್‌ಔಟ್",
        "save": "ಉಳಿಸಿ",
        "cancel": "ರದ್ದುಮಾಡಿ",
        "delete": "ಅಳಿಸಿ",
        "edit": "ಸಂಪಾದಿಸಿ",
        "search": "ಹುಡುಕಿ",
        "loading": "ಲೋಡ್ ಆಗುತ್ತಿದೆ...",
        "error": "ದೋಷ",
        "success": "ಯಶಸ್ಸು",
        "confirm": "ದೃಢೀಕರಿಸಿ",
        "yes": "ಹೌದು",
        "no": "ಇಲ್ಲ",
        "back": "ಹಿಂದೆ",
        "next": "ಮುಂದೆ",
        "skip": "ಬಿಟ್ಟುಬಿಡಿ",
        "done": "ಮುಗಿದಿದೆ",
        "viewAll": "ಎಲ್ಲವನ್ನೂ ನೋಡಿ",
        "noDataFound": "ಯಾವುದೇ ಡೇಟಾ ಕಂಡುಬಂದಿಲ್ಲ",
        "chatbot": "AI ಸಹಾಯಕ",
        "typeMessage": "ನಿಮ್ಮ ಸಂದೇಶವನ್ನು ಟೈಪ್ ಮಾಡಿ...",
        "thinking": "ಯೋಚಿಸುತ್ತಿದೆ...",
        "selectLanguage": "ಭಾಷೆಯನ್ನು ಆಯ್ಕೆಮಾಡಿ",
        "welcomeDeveloper": "ಡೆವಲಪರ್‌ಗೆ ಸುಸ್ವಾಗತ!",
        "startCodingMessage":
            "ಈ ಮುಖಪುಟ ಪರದೆಯನ್ನು ಕಸ್ಟಮೈಸ್ ಮಾಡುವ ಮೂಲಕ ನಿಮ್ಮ ಅಪ್ಲಿಕೇಶನ್ ಕೋಡಿಂಗ್ ಪ್ರಾರಂಭಿಸಿ.",
        "photoGallery": "ಫೋಟೋ ಗ್ಯಾಲರಿ",
        "takePhoto": "ಫೋಟೋ ತೆಗೆಯಿರಿ",
        "pickImage": "ಚಿತ್ರವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
        "viewPhotos": "ಫೋಟೋಗಳನ್ನು ವೀಕ್ಷಿಸಿ ({count})",
        "calling": "ಕರೆಮಾಡುವಿಕೆ",
        "makeACall": "ಕರೆ ಮಾಡಿ",
        "quicklyDialNumber": "ತ್ವರಿತವಾಗಿ ಫೋನ್ ಸಂಖ್ಯೆಯನ್ನು ಡಯಲ್ ಮಾಡಿ",
        "startCall": "ಕರೆ ಪ್ರಾರಂಭಿಸಿ",
        "contacts": "ಸಂಪರ್ಕಗಳು",
        "pickContact": "ಸಂಪರ್ಕವನ್ನು ಆಯ್ಕೆಮಾಡಿ",
        "savedContacts": "ಉಳಿಸಲಾಗಿದೆ ({count})",
        "call": "ಕರೆ",
        "copy": "ನಕಲಿಸಿ",
        "aiAssistant": "AI ಸಹಾಯಕ",
        "chatWithAI": "AI ಜೊತೆ ಚಾಟ್ ಮಾಡಿ",
        "askQuestionsInstant":
            "ಪ್ರಶ್ನೆಗಳನ್ನು ಕೇಳಿ ಮತ್ತು ತ್ವರಿತ ಉತ್ತರಗಳನ್ನು ಪಡೆಯಿರಿ",
        "photoCapturedSuccess": "ಫೋಟೋ ಯಶಸ್ವಿಯಾಗಿ ಸೆರೆಹಿಡಿಯಲಾಗಿದೆ!",
        "imageAddedGallery": "ಗ್ಯಾಲರಿಯಿಂದ ಚಿತ್ರವನ್ನು ಸೇರಿಸಲಾಗಿದೆ!",
        "deletePhoto": "ಫೋಟೋ ಅಳಿಸಿ",
        "deletePhotoConfirm": "ನೀವು ಈ ಫೋಟೋವನ್ನು ಅಳಿಸಲು ಖಚಿತವಾಗಿ ಬಯಸುವಿರಾ?",
        "photoDeleted": "ಫೋಟೋ ಅಳಿಸಲಾಗಿದೆ",
        "callError": "ಕರೆ ದೋಷ: {error}",
        "enterPhoneNumber": "ಫೋನ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "ಆಯ್ಕೆಮಾಡಿದ ಸಂಪರ್ಕ: {name}",
        "numberCopied": "{number} ನಕಲಿಸಲಾಗಿದೆ!",
        "contactAlreadySaved": "ಸಂಪರ್ಕ ಈಗಾಗಲೇ ಉಳಿಸಲಾಗಿದೆ!",
        "contactSaved": "{name} ಉಳಿಸಲಾಗಿದೆ!",
        "savedContactsTitle": "ಉಳಿಸಲಾದ ಸಂಪರ್ಕಗಳು ({count})",
        "contactDeleted": "{name} ಅಳಿಸಲಾಗಿದೆ",
        "errorMessage": "ದೋಷ: {error}",
        "photoGalleryTitle": "ಫೋಟೋ ಗ್ಯಾಲರಿ ({count})",
        "currentLocation": "ಪ್ರಸ್ತುತ ಸ್ಥಳ",
        "getCurrentGPS": "ನಿಮ್ಮ ಪ್ರಸ್ತುತ GPS ನಿರ್ದೇಶಾಂಕಗಳನ್ನು ಪಡೆಯಿರಿ",
        "getLocation": "ಸ್ಥಳವನ್ನು ಪಡೆಯಿರಿ",
        "latitude": "ಅಕ್ಷಾಂಶ",
        "longitude": "ರೇಖಾಂಶ",
        "altitude": "ಎತ್ತರ",
        "accuracy": "ನಿಖರತೆ",
        "copyCoordinates": "ನಿರ್ದೇಶಾಂಕಗಳನ್ನು ನಕಲಿಸಿ"
      },
      'ml': {
        "@@locale": "ml",
        "appTitle": "ഡെമോ ആപ്പ്",
        "welcome": "സ്വാഗതം",
        "hello": "നമസ്കാരം",
        "login": "ലോഗിൻ",
        "signup": "സൈൻ അപ്പ്",
        "email": "ഇമെയിൽ",
        "password": "പാസ്‌വേഡ്",
        "username": "ഉപയോക്തൃനാമം",
        "phone": "ഫോൺ നമ്പർ",
        "forgotPassword": "പാസ്‌വേഡ് മറന്നോ?",
        "home": "ഹോം",
        "profile": "പ്രൊഫൈൽ",
        "settings": "ക്രമീകരണങ്ങൾ",
        "logout": "ലോഗൗട്ട്",
        "save": "സേവ് ചെയ്യുക",
        "cancel": "റദ്ദാക്കുക",
        "delete": "ഇല്ലാതാക്കുക",
        "edit": "എഡിറ്റ് ചെയ്യുക",
        "search": "തിരയുക",
        "loading": "ലോഡ് ചെയ്യുന്നു...",
        "error": "പിശക്",
        "success": "വിജയം",
        "confirm": "സ്ഥിരീകരിക്കുക",
        "yes": "അതെ",
        "no": "ഇല്ല",
        "back": "മടങ്ങുക",
        "next": "അടുത്തത്",
        "skip": "ഒഴിവാക്കുക",
        "done": "പൂർത്തിയായി",
        "viewAll": "എല്ലാം കാണുക",
        "noDataFound": "ഡാറ്റ കണ്ടെത്തിയില്ല",
        "chatbot": "AI സഹായി",
        "typeMessage": "നിങ്ങളുടെ സന്ദേശം ടൈപ്പ് ചെയ്യുക...",
        "thinking": "ചിന്തിക്കുന്നു...",
        "selectLanguage": "ഭാഷ തിരഞ്ഞെടുക്കുക",
        "welcomeDeveloper": "ഡെവലപ്പർക്ക് സ്വാഗതം!",
        "startCodingMessage":
            "ഈ ഹോം സ്ക്രീൻ കസ്റ്റമൈസ് ചെയ്ത് നിങ്ങളുടെ ആപ്പ് കോഡിംഗ് ആരംഭിക്കുക.",
        "photoGallery": "ഫോട്ടോ ഗാലറി",
        "takePhoto": "ഫോട്ടോ എടുക്കുക",
        "pickImage": "ചിത്രം തിരഞ്ഞെടുക്കുക",
        "viewPhotos": "ഫോട്ടോകൾ കാണുക ({count})",
        "calling": "കോളിംഗ്",
        "makeACall": "ഒരു കോൾ ചെയ്യുക",
        "quicklyDialNumber": "വേഗത്തിൽ ഒരു ഫോൺ നമ്പർ ഡയൽ ചെയ്യുക",
        "startCall": "കോൾ ആരംഭിക്കുക",
        "contacts": "കോൺടാക്റ്റുകൾ",
        "pickContact": "കോൺടാക്റ്റ് തിരഞ്ഞെടുക്കുക",
        "savedContacts": "സംരക്ഷിച്ചത് ({count})",
        "call": "കോൾ",
        "copy": "പകർത്തുക",
        "aiAssistant": "AI സഹായി",
        "chatWithAI": "AI-യുമായി ചാറ്റ് ചെയ്യുക",
        "askQuestionsInstant":
            "ചോദ്യങ്ങൾ ചോദിക്കുകയും തൽക്ഷണ ഉത്തരങ്ങൾ നേടുകയും ചെയ്യുക",
        "photoCapturedSuccess": "ഫോട്ടോ വിജയകരമായി എടുത്തു!",
        "imageAddedGallery": "ഗാലറിയിൽ നിന്ന് ചിത്രം ചേർത്തു!",
        "deletePhoto": "ഫോട്ടോ ഇല്ലാതാക്കുക",
        "deletePhotoConfirm": "ഈ ഫോട്ടോ ഇല്ലാതാക്കണമെന്ന് ഉറപ്പാണോ?",
        "photoDeleted": "ഫോട്ടോ ഇല്ലാതാക്കി",
        "callError": "കോൾ പിശക്: {error}",
        "enterPhoneNumber": "ഫോൺ നമ്പർ നൽകുക",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "കോൺടാക്റ്റ് തിരഞ്ഞെടുത്തു: {name}",
        "numberCopied": "{number} പകർത്തി!",
        "contactAlreadySaved": "കോൺടാക്റ്റ് ഇതിനകം സംരക്ഷിച്ചിട്ടുണ്ട്!",
        "contactSaved": "{name} സംരക്ഷിച്ചു!",
        "savedContactsTitle": "സംരക്ഷിച്ച കോൺടാക്റ്റുകൾ ({count})",
        "contactDeleted": "{name} ഇല്ലാതാക്കി",
        "errorMessage": "പിശക്: {error}",
        "photoGalleryTitle": "ഫോട്ടോ ഗാലറി ({count})",
        "currentLocation": "നിലവിലെ സ്ഥാനം",
        "getCurrentGPS": "നിങ്ങളുടെ നിലവിലെ GPS കോർഡിനേറ്റുകൾ നേടുക",
        "getLocation": "സ്ഥാനം നേടുക",
        "latitude": "അക്ഷാംശം",
        "longitude": "രേഖാംശം",
        "altitude": "ഉയരം",
        "accuracy": "കൃത്യത",
        "copyCoordinates": "കോർഡിനേറ്റുകൾ പകർത്തുക"
      },
      'pa': {
        "@@locale": "pa",
        "appTitle": "ਡੈਮੋ ਐਪ",
        "welcome": "ਸਵਾਗਤ ਹੈ",
        "hello": "ਸਤ ਸ੍ਰੀ ਅਕਾਲ",
        "login": "ਲੌਗਇਨ",
        "signup": "ਸਾਈਨ ਅੱਪ",
        "email": "ਈਮੇਲ",
        "password": "ਪਾਸਵਰਡ",
        "username": "ਯੂਜ਼ਰਨੇਮ",
        "phone": "ਫ਼ੋਨ ਨੰਬਰ",
        "forgotPassword": "ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ?",
        "home": "ਹੋਮ",
        "profile": "ਪ੍ਰੋਫਾਈਲ",
        "settings": "ਸੈਟਿੰਗਾਂ",
        "logout": "ਲੌਗਆਉਟ",
        "save": "ਸੇਵ ਕਰੋ",
        "cancel": "ਰੱਦ ਕਰੋ",
        "delete": "ਡਿਲੀਟ ਕਰੋ",
        "edit": "ਐਡਿਟ ਕਰੋ",
        "search": "ਖੋਜੋ",
        "loading": "ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...",
        "error": "ਗਲਤੀ",
        "success": "ਸਫਲਤਾ",
        "confirm": "ਪੁਸ਼ਟੀ ਕਰੋ",
        "yes": "ਹਾਂ",
        "no": "ਨਹੀਂ",
        "back": "ਪਿੱਛੇ",
        "next": "ਅੱਗੇ",
        "skip": "ਛੱਡੋ",
        "done": "ਹੋ ਗਿਆ",
        "viewAll": "ਸਭ ਵੇਖੋ",
        "noDataFound": "ਕੋਈ ਡੇਟਾ ਨਹੀਂ ਮਿਲਿਆ",
        "chatbot": "AI ਸਹਾਇਕ",
        "typeMessage": "ਆਪਣਾ ਸੁਨੇਹਾ ਟਾਈਪ ਕਰੋ...",
        "thinking": "ਸੋਚ ਰਿਹਾ ਹੈ...",
        "selectLanguage": "ਭਾਸ਼ਾ ਚੁਣੋ",
        "welcomeDeveloper": "ਸਵਾਗਤ ਹੈ ਡਿਵੈਲਪਰ!",
        "startCodingMessage":
            "ਇਸ ਹੋਮ ਸਕ੍ਰੀਨ ਨੂੰ ਕਸਟਮਾਈਜ਼ ਕਰਕੇ ਆਪਣੀ ਐਪ ਕੋਡਿੰਗ ਸ਼ੁਰੂ ਕਰੋ.",
        "photoGallery": "ਫੋਟੋ ਗੈਲਰੀ",
        "takePhoto": "ਫੋਟੋ ਲਓ",
        "pickImage": "ਤਸਵੀਰ ਚੁਣੋ",
        "viewPhotos": "ਫੋਟੋਆਂ ਵੇਖੋ ({count})",
        "calling": "ਕਾਲਿੰਗ",
        "makeACall": "ਇੱਕ ਕਾਲ ਕਰੋ",
        "quicklyDialNumber": "ਤੁਰੰਤ ਇੱਕ ਫ਼ੋਨ ਨੰਬਰ ਡਾਇਲ ਕਰੋ",
        "startCall": "ਕਾਲ ਸ਼ੁਰੂ ਕਰੋ",
        "contacts": "ਸੰਪਰਕ",
        "pickContact": "ਸੰਪਰਕ ਚੁਣੋ",
        "savedContacts": "ਸੇਵ ਕੀਤੇ ({count})",
        "call": "ਕਾਲ",
        "copy": "ਕਾਪੀ",
        "aiAssistant": "AI ਸਹਾਇਕ",
        "chatWithAI": "AI ਨਾਲ ਚੈਟ ਕਰੋ",
        "askQuestionsInstant": "ਸਵਾਲ ਪੁੱਛੋ ਅਤੇ ਤੁਰੰਤ ਜਵਾਬ ਪ੍ਰਾਪਤ ਕਰੋ",
        "photoCapturedSuccess": "ਫੋਟੋ ਸਫਲਤਾਪੂਰਵਕ ਕੈਪਚਰ ਹੋ ਗਈ!",
        "imageAddedGallery": "ਗੈਲਰੀ ਤੋਂ ਤਸਵੀਰ ਸ਼ਾਮਲ ਕੀਤੀ ਗਈ!",
        "deletePhoto": "ਫੋਟੋ ਡਿਲੀਟ ਕਰੋ",
        "deletePhotoConfirm":
            "ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ 'ਤੇ ਇਸ ਫੋਟੋ ਨੂੰ ਡਿਲੀਟ ਕਰਨਾ ਚਾਹੁੰਦੇ ਹੋ?",
        "photoDeleted": "ਫੋਟੋ ਡਿਲੀਟ ਹੋ ਗਈ",
        "callError": "ਕਾਲ ਗਲਤੀ: {error}",
        "enterPhoneNumber": "ਫ਼ੋਨ ਨੰਬਰ ਦਾਖਲ ਕਰੋ",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "ਸੰਪਰਕ ਚੁਣਿਆ ਗਿਆ: {name}",
        "numberCopied": "{number} ਕਾਪੀ ਹੋ ਗਿਆ!",
        "contactAlreadySaved": "ਸੰਪਰਕ ਪਹਿਲਾਂ ਹੀ ਸੇਵ ਹੈ!",
        "contactSaved": "{name} ਸੇਵ ਹੋ ਗਿਆ!",
        "savedContactsTitle": "ਸੇਵ ਕੀਤੇ ਸੰਪਰਕ ({count})",
        "contactDeleted": "{name} ਡਿਲੀਟ ਹੋ ਗਿਆ",
        "errorMessage": "ਗਲਤੀ: {error}",
        "photoGalleryTitle": "ਫੋਟੋ ਗੈਲਰੀ ({count})",
        "currentLocation": "ਮੌਜੂਦਾ ਸਥਿਤੀ",
        "getCurrentGPS": "ਆਪਣੇ ਮੌਜੂਦਾ GPS ਕੋਆਰਡੀਨੇਟਸ ਪ੍ਰਾਪਤ ਕਰੋ",
        "getLocation": "ਸਥਿਤੀ ਪ੍ਰਾਪਤ ਕਰੋ",
        "latitude": "ਅਕਸ਼ਾਂਸ਼",
        "longitude": "ਰੇਖਾਂਸ਼",
        "altitude": "ਉਚਾਈ",
        "accuracy": "ਸਟੀਕਤਾ",
        "copyCoordinates": "ਕੋਆਰਡੀਨੇਟਸ ਕਾਪੀ ਕਰੋ"
      },
      'or': {
        "@@locale": "or",
        "appTitle": "ଡେମୋ ଆପ୍",
        "welcome": "ସ୍ୱାଗତ",
        "hello": "ନମସ୍କାର",
        "login": "ଲଗଇନ୍",
        "signup": "ସାଇନ୍ ଅପ୍",
        "email": "ଇମେଲ୍",
        "password": "ପାସୱାର୍ଡ",
        "username": "ବ୍ୟବହାରକାରୀ ନାମ",
        "phone": "ଫୋନ୍ ନମ୍ବର",
        "forgotPassword": "ପାସୱାର୍ଡ ଭୁଲିଗଲେ?",
        "home": "ହୋମ୍",
        "profile": "ପ୍ରୋଫାଇଲ୍",
        "settings": "ସେଟିଂସ୍",
        "logout": "ଲଗଆଉଟ୍",
        "save": "ସେଭ୍ କରନ୍ତୁ",
        "cancel": "ବାତିଲ୍ କରନ୍ତୁ",
        "delete": "ଡିଲିଟ୍ କରନ୍ତୁ",
        "edit": "ଏଡିଟ୍ କରନ୍ତୁ",
        "search": "ଖୋଜନ୍ତୁ",
        "loading": "ଲୋଡ୍ ହେଉଛି...",
        "error": "ତ୍ରୁଟି",
        "success": "ସଫଳତା",
        "confirm": "ନିଶ୍ଚିତ କରନ୍ତୁ",
        "yes": "ହଁ",
        "no": "ନା",
        "back": "ପଛକୁ",
        "next": "ପରବର୍ତ୍ତୀ",
        "skip": "ଛାଡିଦିଅନ୍ତୁ",
        "done": "ସମ୍ପୂର୍ଣ୍ଣ",
        "viewAll": "ସମସ୍ତ ଦେଖନ୍ତୁ",
        "noDataFound": "କୌଣସି ଡାଟା ମିଳିଲା ନାହିଁ",
        "chatbot": "AI ସହାୟକ",
        "typeMessage": "ଆପଣଙ୍କର ମେସେଜ୍ ଟାଇପ୍ କରନ୍ତୁ...",
        "thinking": "ଚିନ୍ତା କରୁଛି...",
        "selectLanguage": "ଭାଷା ବାଛନ୍ତୁ",
        "welcomeDeveloper": "ଡେଭଲପରଙ୍କୁ ସ୍ୱାଗତ!",
        "startCodingMessage":
            "ଏହି ହୋମ ସ୍କ୍ରିନ୍ କଷ୍ଟମାଇଜ୍ କରି ଆପଣଙ୍କର ଆପ୍ କୋଡିଂ ଆରମ୍ଭ କରନ୍ତୁ.",
        "photoGallery": "ଫଟୋ ଗ୍ୟାଲେରି",
        "takePhoto": "ଫଟୋ ନିଅନ୍ତୁ",
        "pickImage": "ଇମେଜ୍ ବାଛନ୍ତୁ",
        "viewPhotos": "ଫଟୋ ଦେଖନ୍ତୁ ({count})",
        "calling": "କଲିଂ",
        "makeACall": "ଏକ କଲ୍ କରନ୍ତୁ",
        "quicklyDialNumber": "ଶୀଘ୍ର ଏକ ଫୋନ୍ ନମ୍ବର ଡାଏଲ୍ କରନ୍ତୁ",
        "startCall": "କଲ୍ ଆରମ୍ଭ କରନ୍ତୁ",
        "contacts": "ସମ୍ପର୍କଗୁଡ଼ିକ",
        "pickContact": "ସମ୍ପର୍କ ବାଛନ୍ତୁ",
        "savedContacts": "ସେଭ୍ ହୋଇଛି ({count})",
        "call": "କଲ୍",
        "copy": "କପି",
        "aiAssistant": "AI ସହାୟକ",
        "chatWithAI": "AI ସହିତ ଚାଟ୍ କରନ୍ତୁ",
        "askQuestionsInstant": "ପ୍ରଶ୍ନ ପଚାରନ୍ତୁ ଏବଂ ତୁରନ୍ତ ଉତ୍ତର ପାଆନ୍ତୁ",
        "photoCapturedSuccess": "ଫଟୋ ସଫଳତାର ସହିତ କ୍ୟାପଚର୍ ହୋଇଛି!",
        "imageAddedGallery": "ଗ୍ୟାଲେରିରୁ ଇମେଜ୍ ଯୋଡ଼ାଗଲା!",
        "deletePhoto": "ଫଟୋ ଡିଲିଟ୍ କରନ୍ତୁ",
        "deletePhotoConfirm":
            "ଆପଣ ନିଶ୍ଚିତ କି ଏହି ଫଟୋ ଡିଲିଟ୍ କରିବାକୁ ଚାହାଁନ୍ତି?",
        "photoDeleted": "ଫଟୋ ଡିଲିଟ୍ ହୋଇଛି",
        "callError": "କଲ୍ ତ୍ରୁଟି: {error}",
        "enterPhoneNumber": "ଫୋନ୍ ନମ୍ବର ପ୍ରବେଶ କରନ୍ତୁ",
        "phoneNumberHint": "+91 98765 43210",
        "contactSelected": "ସମ୍ପର୍କ ବାଛାଗଲା: {name}",
        "numberCopied": "{number} କପି ହୋଇଛି!",
        "contactAlreadySaved": "ସମ୍ପର୍କ ପୂର୍ବରୁ ସେଭ୍ ହୋଇଛି!",
        "contactSaved": "{name} ସେଭ୍ ହୋଇଛି!",
        "savedContactsTitle": "ସେଭ୍ ହୋଇଥିବା ସମ୍ପର୍କଗୁଡ଼ିକ ({count})",
        "contactDeleted": "{name} ଡିଲିଟ୍ ହୋଇଛି",
        "errorMessage": "ତ୍ରୁଟି: {error}",
        "photoGalleryTitle": "ଫଟୋ ଗ୍ୟାଲେରି ({count})",
        "currentLocation": "ବର୍ତ୍ତମାନର ଅବସ୍ଥାନ",
        "getCurrentGPS": "ଆପଣଙ୍କର ବର୍ତ୍ତମାନର GPS ସ୍ଥାନାଙ୍କ ପାଆନ୍ତୁ",
        "getLocation": "ଅବସ୍ଥାନ ପାଆନ୍ତୁ",
        "latitude": "ଅକ୍ଷାଂଶ",
        "longitude": "ଦ୍ରାଘିମା",
        "altitude": "ଉଚ୍ଚତା",
        "accuracy": "ସଠିକତା",
        "copyCoordinates": "ସ୍ଥାନାଙ୍କ କପି କରନ୍ତୁ"
      },
      'zh': {
        "@@locale": "zh",
        "appTitle": "演示应用",
        "welcome": "欢迎",
        "hello": "你好",
        "login": "登录",
        "signup": "注册",
        "email": "电子邮件",
        "password": "密码",
        "username": "用户名",
        "phone": "电话号码",
        "forgotPassword": "忘记密码？",
        "home": "主页",
        "profile": "个人资料",
        "settings": "设置",
        "logout": "退出",
        "save": "保存",
        "cancel": "取消",
        "delete": "删除",
        "edit": "编辑",
        "search": "搜索",
        "loading": "加载中...",
        "error": "错误",
        "success": "成功",
        "confirm": "确认",
        "yes": "是",
        "no": "否",
        "back": "返回",
        "next": "下一步",
        "skip": "跳过",
        "done": "完成",
        "viewAll": "查看全部",
        "noDataFound": "未找到数据",
        "chatbot": "AI助手",
        "typeMessage": "输入您的消息...",
        "thinking": "思考中...",
        "selectLanguage": "选择语言",
        "welcomeDeveloper": "欢迎开发者！",
        "startCodingMessage": "通过自定义此主屏幕开始编写您的应用程序。",
        "photoGallery": "照片库",
        "takePhoto": "拍照",
        "pickImage": "选择图片",
        "viewPhotos": "查看照片 ({count})",
        "calling": "通话",
        "makeACall": "拨打电话",
        "quicklyDialNumber": "快速拨打电话号码",
        "startCall": "开始通话",
        "contacts": "联系人",
        "pickContact": "选择联系人",
        "savedContacts": "已保存 ({count})",
        "call": "呼叫",
        "copy": "复制",
        "aiAssistant": "AI助手",
        "chatWithAI": "与AI聊天",
        "askQuestionsInstant": "提问并获得即时答案",
        "photoCapturedSuccess": "照片拍摄成功！",
        "imageAddedGallery": "已从图库添加图片！",
        "deletePhoto": "删除照片",
        "deletePhotoConfirm": "您确定要删除此照片吗？",
        "photoDeleted": "照片已删除",
        "callError": "通话错误：{error}",
        "enterPhoneNumber": "输入电话号码",
        "phoneNumberHint": "+86 138 1234 5678",
        "contactSelected": "已选择联系人：{name}",
        "numberCopied": "已复制{number}！",
        "contactAlreadySaved": "联系人已保存！",
        "contactSaved": "已保存{name}！",
        "savedContactsTitle": "已保存的联系人 ({count})",
        "contactDeleted": "已删除{name}",
        "errorMessage": "错误：{error}",
        "photoGalleryTitle": "照片库 ({count})",
        "currentLocation": "当前位置",
        "getCurrentGPS": "获取您当前的GPS坐标",
        "getLocation": "获取位置",
        "latitude": "纬度",
        "longitude": "经度",
        "altitude": "海拔",
        "accuracy": "精确度",
        "copyCoordinates": "复制坐标"
      },
      'ja': {
        "@@locale": "ja",
        "appTitle": "デモアプリ",
        "welcome": "ようこそ",
        "hello": "こんにちは",
        "login": "ログイン",
        "signup": "サインアップ",
        "email": "メール",
        "password": "パスワード",
        "username": "ユーザー名",
        "phone": "電話番号",
        "forgotPassword": "パスワードをお忘れですか?",
        "home": "ホーム",
        "profile": "プロフィール",
        "settings": "設定",
        "logout": "ログアウト",
        "save": "保存",
        "cancel": "キャンセル",
        "delete": "削除",
        "edit": "編集",
        "search": "検索",
        "loading": "読み込み中...",
        "error": "エラー",
        "success": "成功",
        "confirm": "確認",
        "yes": "はい",
        "no": "いいえ",
        "back": "戻る",
        "next": "次へ",
        "skip": "スキップ",
        "done": "完了",
        "viewAll": "すべて見る",
        "noDataFound": "データが見つかりません",
        "chatbot": "AIアシスタント",
        "typeMessage": "メッセージを入力...",
        "thinking": "考え中...",
        "selectLanguage": "言語を選択",
        "welcomeDeveloper": "開発者の皆様、ようこそ!",
        "startCodingMessage": "このホーム画面をカスタマイズして、アプリのコーディングを始めましょう。",
        "photoGallery": "フォトギャラリー",
        "takePhoto": "写真を撮る",
        "pickImage": "画像を選択",
        "viewPhotos": "写真を見る ({count})",
        "calling": "通話",
        "makeACall": "電話をかける",
        "quicklyDialNumber": "電話番号を素早くダイヤル",
        "startCall": "通話開始",
        "contacts": "連絡先",
        "pickContact": "連絡先を選択",
        "savedContacts": "保存済み ({count})",
        "call": "電話",
        "copy": "コピー",
        "aiAssistant": "AIアシスタント",
        "chatWithAI": "AIとチャット",
        "askQuestionsInstant": "質問して即座に回答を得る",
        "photoCapturedSuccess": "写真の撮影に成功しました!",
        "imageAddedGallery": "ギャラリーから画像を追加しました!",
        "deletePhoto": "写真を削除",
        "deletePhotoConfirm": "この写真を削除してもよろしいですか?",
        "photoDeleted": "写真が削除されました",
        "callError": "通話エラー: {error}",
        "enterPhoneNumber": "電話番号を入力",
        "phoneNumberHint": "+81 90 1234 5678",
        "contactSelected": "選択された連絡先: {name}",
        "numberCopied": "{number}をコピーしました!",
        "contactAlreadySaved": "連絡先はすでに保存されています!",
        "contactSaved": "{name}を保存しました!",
        "savedContactsTitle": "保存済み連絡先 ({count})",
        "contactDeleted": "{name}を削除しました",
        "errorMessage": "エラー: {error}",
        "photoGalleryTitle": "フォトギャラリー ({count})",
        "currentLocation": "現在地",
        "getCurrentGPS": "現在のGPS座標を取得",
        "getLocation": "位置を取得",
        "latitude": "緯度",
        "longitude": "経度",
        "altitude": "高度",
        "accuracy": "精度",
        "copyCoordinates": "座標をコピー"
      },
      'ar': {
        "@@locale": "ar",
        "appTitle": "تطبيق تجريبي",
        "welcome": "مرحباً",
        "hello": "مرحبا",
        "login": "تسجيل الدخول",
        "signup": "إنشاء حساب",
        "email": "البريد الإلكتروني",
        "password": "كلمة المرور",
        "username": "اسم المستخدم",
        "phone": "رقم الهاتف",
        "forgotPassword": "هل نسيت كلمة المرور؟",
        "home": "الرئيسية",
        "profile": "الملف الشخصي",
        "settings": "الإعدادات",
        "logout": "تسجيل الخروج",
        "save": "حفظ",
        "cancel": "إلغاء",
        "delete": "حذف",
        "edit": "تعديل",
        "search": "بحث",
        "loading": "جاري التحميل...",
        "error": "خطأ",
        "success": "نجح",
        "confirm": "تأكيد",
        "yes": "نعم",
        "no": "لا",
        "back": "رجوع",
        "next": "التالي",
        "skip": "تخطي",
        "done": "تم",
        "viewAll": "عرض الكل",
        "noDataFound": "لم يتم العثور على بيانات",
        "chatbot": "المساعد الذكي",
        "typeMessage": "اكتب رسالتك...",
        "thinking": "جاري التفكير...",
        "selectLanguage": "اختر اللغة",
        "welcomeDeveloper": "مرحباً بالمطور!",
        "startCodingMessage":
            "ابدأ بتطوير تطبيقك عن طريق تخصيص هذه الشاشة الرئيسية.",
        "photoGallery": "معرض الصور",
        "takePhoto": "التقط صورة",
        "pickImage": "اختر صورة",
        "viewPhotos": "عرض الصور ({count})",
        "calling": "الاتصال",
        "makeACall": "إجراء مكالمة",
        "quicklyDialNumber": "اتصل برقم هاتف بسرعة",
        "startCall": "بدء المكالمة",
        "contacts": "جهات الاتصال",
        "pickContact": "اختر جهة اتصال",
        "savedContacts": "محفوظ ({count})",
        "call": "اتصال",
        "copy": "نسخ",
        "aiAssistant": "المساعد الذكي",
        "chatWithAI": "الدردشة مع الذكاء الاصطناعي",
        "askQuestionsInstant": "اطرح الأسئلة واحصل على إجابات فورية",
        "photoCapturedSuccess": "تم التقاط الصورة بنجاح!",
        "imageAddedGallery": "تمت إضافة الصورة من المعرض!",
        "deletePhoto": "حذف الصورة",
        "deletePhotoConfirm": "هل أنت متأكد من حذف هذه الصورة؟",
        "photoDeleted": "تم حذف الصورة",
        "callError": "خطأ في المكالمة: {error}",
        "enterPhoneNumber": "أدخل رقم الهاتف",
        "phoneNumberHint": "+966 55 123 4567",
        "contactSelected": "تم اختيار جهة الاتصال: {name}",
        "numberCopied": "تم نسخ {number}!",
        "contactAlreadySaved": "جهة الاتصال محفوظة بالفعل!",
        "contactSaved": "تم حفظ {name}!",
        "savedContactsTitle": "جهات الاتصال المحفوظة ({count})",
        "contactDeleted": "تم حذف {name}",
        "errorMessage": "خطأ: {error}",
        "photoGalleryTitle": "معرض الصور ({count})",
        "currentLocation": "الموقع الحالي",
        "getCurrentGPS": "احصل على إحداثيات GPS الحالية",
        "getLocation": "احصل على الموقع",
        "latitude": "خط العرض",
        "longitude": "خط الطول",
        "altitude": "الارتفاع",
        "accuracy": "الدقة",
        "copyCoordinates": "نسخ الإحداثيات"
      },
    };

    return translations[languageCode] ?? en;
  }

  // Generate locale provider helper
  static String generateLocaleProvider(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
''';
  }

  // Generate language selection widget
  static String generateLanguageSelector(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:$projectName/core/providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  static const Map<String, String> languages = {
    'en': '🇬🇧 English',
    'es': '🇪🇸 Español',
    'fr': '🇫🇷 Français',
    'de': '🇩🇪 Deutsch',
    'it': '🇮🇹 Italiano',
    'pt': '🇵🇹 Português',
    'ru': '🇷🇺 Русский',
    'zh': '🇨🇳 中文',
    'ja': '🇯🇵 日本語',
    'ar': '🇸🇦 العربية',
    'hi': '🇮🇳 हिन्दी',
    'bn': '🇮🇳 বাংলা',
    'te': '🇮🇳 తెలుగు',
    'mr': '🇮🇳 मराठी',
    'ta': '🇮🇳 தமிழ்',
    'gu': '🇮🇳 ગુજરાતી',
    'kn': '🇮🇳 ಕನ್ನಡ',
    'ml': '🇮🇳 മലയാളം',
    'pa': '🇮🇳 ਪੰਜਾਬੀ',
    'or': '🇮🇳 ଓଡ଼ିଆ',
  };

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale.languageCode;

    return AlertDialog(
      title: const Text('Select Language'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final entry = languages.entries.elementAt(index);
            final isSelected = currentLocale == entry.key;

            return ListTile(
              leading: Text(
                entry.value.split(' ').first,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(entry.value.split(' ').skip(1).join(' ')),
              trailing: isSelected
                  ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                  : null,
              selected: isSelected,
              onTap: () {
                localeProvider.setLocale(Locale(entry.key));
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelector(),
    );
  }
}
''';
  }

  // Generate README for localization
  static String generateLocalizationReadme() {
    return '''
# Localization Guide

This app supports multiple languages using Flutter's internationalization (l10n).

## Supported Languages

### International Languages
- 🇬🇧 English (en)
- 🇪🇸 Spanish (es)
- 🇫🇷 French (fr)
- 🇩🇪 German (de)
- 🇮🇹 Italian (it)
- 🇵🇹 Portuguese (pt)
- 🇷🇺 Russian (ru)
- 🇨🇳 Chinese (zh)
- 🇯🇵 Japanese (ja)
- 🇸🇦 Arabic (ar)

### Indian Languages
- 🇮🇳 Hindi (hi)
- 🇮🇳 Bengali (bn)
- 🇮🇳 Telugu (te)
- 🇮🇳 Marathi (mr)
- 🇮🇳 Tamil (ta)
- 🇮🇳 Gujarati (gu)
- 🇮🇳 Kannada (kn)
- 🇮🇳 Malayalam (ml)
- 🇮🇳 Punjabi (pa)
- 🇮🇳 Odia (or)

## Setup Instructions

### 1. Add Dependencies

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
  provider: ^6.0.0
  shared_preferences: ^2.0.0

flutter:
  generate: true
```

### 2. Create l10n.yaml

Create `l10n.yaml` in your project root:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
synthetic-package: false
output-class: AppLocalizations
```

### 3. Create ARB Files

Create folder `lib/l10n/` and add ARB files:
- `app_en.arb` (template)
- `app_es.arb`, `app_fr.arb`, etc. for other languages

### 4. Generate Localization Files

Run this command:

```bash
flutter gen-l10n
```

This will generate the localization files in `.dart_tool/flutter_gen/gen_l10n/`.

### 5. Setup Main App

Update your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'core/providers/locale_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'My App',
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('de'), // German
        Locale('it'), // Italian
        Locale('pt'), // Portuguese
        Locale('ru'), // Russian
        Locale('zh'), // Chinese
        Locale('ja'), // Japanese
        Locale('ar'), // Arabic
        Locale('hi'), // Hindi
        Locale('bn'), // Bengali
        Locale('te'), // Telugu
        Locale('mr'), // Marathi
        Locale('ta'), // Tamil
        Locale('gu'), // Gujarati
        Locale('kn'), // Kannada
        Locale('ml'), // Malayalam
        Locale('pa'), // Punjabi
        Locale('or'), // Odia
      ],
      home: const HomeScreen(),
    );
  }
}
```

## Usage

### In Code

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Use in widgets
Text(AppLocalizations.of(context)!.welcome)
Text(AppLocalizations.of(context)!.login)
Text(AppLocalizations.of(context)!.chatbot)

// Or with a shorter syntax
final l10n = AppLocalizations.of(context)!;
Text(l10n.hello)
Text(l10n.settings)
```

### Change Language

Use the `LanguageSelector` widget:

```dart
import 'package:your_app/widgets/language_selector.dart';

// In your settings screen or anywhere
ElevatedButton(
  onPressed: () => LanguageSelector.show(context),
  child: Text('Change Language'),
)

// Or use the widget directly
IconButton(
  icon: const Icon(Icons.language),
  onPressed: () => LanguageSelector.show(context),
)
```

### Access Current Locale

```dart
import 'package:provider/provider.dart';
import 'package:your_app/core/providers/locale_provider.dart';

// Get current locale
final currentLocale = Provider.of<LocaleProvider>(context).locale;

// Change locale programmatically
Provider.of<LocaleProvider>(context, listen: false)
    .setLocale(Locale('es'));
```

## File Structure

```
lib/
├── l10n/
│   ├── app_en.arb
│   ├── app_es.arb
│   ├── app_fr.arb
│   ├── app_de.arb
│   ├── app_hi.arb
│   └── ... (other language files)
├── core/
│   └── providers/
│       └── locale_provider.dart
├── widgets/
│   └── language_selector.dart
└── main.dart

l10n.yaml (in project root)
```

## Adding New Translations

1. Open the English template file `lib/l10n/app_en.arb`
2. Add new keys with descriptions:

```json
{
  "newKey": "New Text",
  "@newKey": {
    "description": "Description of this text"
  }
}
```

3. Add translations to other language files
4. Run `flutter gen-l10n` to regenerate
5. Use in code: `AppLocalizations.of(context)!.newKey`

## Pluralization Example

For texts that need pluralization:

```json
{
  "itemCount": "{count, plural, =0{No items} =1{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Number of items",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

Usage:
```dart
Text(AppLocalizations.of(context)!.itemCount(5))
```

## Parameters Example

For texts with parameters:

```json
{
  "greeting": "Hello {name}!",
  "@greeting": {
    "description": "Greeting with name",
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  }
}
```

Usage:
```dart
Text(AppLocalizations.of(context)!.greeting('John'))
```

## Testing

Test different languages:

```dart
// In your tests
testWidgets('Test localization', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('es'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: YourWidget(),
    ),
  );
  
  // Verify Spanish text appears
  expect(find.text('Hola'), findsOneWidget);
});
```

## Best Practices

1. **Always use localization keys** - Never hardcode strings in UI
2. **Keep keys descriptive** - Use clear, meaningful key names
3. **Add descriptions** - Help translators understand context
4. **Test all languages** - Especially RTL languages like Arabic
5. **Handle long text** - Some translations may be longer
6. **Use parameters** - For dynamic content within translations
7. **Regenerate after changes** - Run `flutter gen-l10n` after ARB updates

## RTL Support

For Arabic and other RTL languages, Flutter automatically handles text direction. Ensure your layouts work with both LTR and RTL:

```dart
// Use these for proper RTL support
Directionality.of(context)
TextDirection.ltr
TextDirection.rtl

// Avoid hardcoded left/right, use start/end instead
EdgeInsets.symmetric(horizontal: 16) // Good
EdgeInsets.only(left: 16) // Avoid
```

## Troubleshooting

**Problem**: Generated files not found  
**Solution**: Run `flutter gen-l10n` or `flutter pub get`

**Problem**: Locale not changing  
**Solution**: Check LocaleProvider is properly set up with Provider

**Problem**: Missing translations  
**Solution**: Ensure all ARB files have the same keys

**Problem**: Build errors after adding new language  
**Solution**: Add the locale to `supportedLocales` in MaterialApp

## Resources

- [Flutter Internationalization Guide](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ARB File Format](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification)
- [Intl Package](https://pub.dev/packages/intl)

## Contributing Translations

To contribute translations:

1. Fork the repository
2. Add/update ARB files in `lib/l10n/`
3. Test the translations
4. Submit a pull request

Ensure translations are:
- Accurate and natural
- Culturally appropriate
- Consistent with app tone
- Tested on actual devices
''';
  }
}
