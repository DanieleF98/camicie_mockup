import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/utils.dart';

// COMMONS
const String camicieMockupLabel = 'Camicie Mockup';
const String loadingLabel = 'Caricamento in corso';
const String pleaseWaitAMinuteLabel = 'Per favore attendi un minuto';
const String genericErrorLabel = 'Errore';
const String anErrorHasOccurred = 'Si è verificato un errore';
const String textIsTooShortErrorLabel = 'Il testo inserito è troppo corto';
const String insertAtLeastOneCharacterLabel =
    'Inserisci almeno un carattere nel testo';
const String noPhotoSelected = 'Nessuna foto inserita';
const String totalAvailableAmountLabel = 'Camicie Disponibili';
const String homePageBaseText = 'Home page';
const String comingSoonLabel = 'Coming soon';
const String areYouSureYouWantToExitLabel = 'Sei sicuro di voler uscire?';
const String pressYesToContinueAndExitTheAppLabel =
    "Premi sì se vuoi continuare e uscire dall'applicazione";
const String yesLabel = 'Sì';
const String noLabel = 'No';
String getTotalAvailableAmountWithLabel(int totalAmount) =>
    '$totalAvailableAmountLabel: $totalAmount';

// HOME PAGE
const String classicModelLabel = 'Classico';
const String classicSlimModelLabel = 'Classico / Slim';
const String slimModelLabel = 'Slim';

// CHANGE HOME SCREEN TEXT DIALOG
const String doYouWantToChangeHomeScreenDialogQuestionLabel =
    'Vuoi cambiare il testo?';
const String confirmLabel = 'CONFERMA';
const String cancelLabel = 'ANNULLA';

// FIREBASE
const String notificationCollectionLabel = 'notification';
const String globalSettingsCollectionLabel = 'settings';
const String modelOfShirtCollectionLabel = 'modelOfShirt';
const String sizeModelCollectionLabel = 'sizeModel';
const String fabricCollectionLabel = 'fabric';
const String statsCollectionLabel = 'stats';
const String classicModelFirebaseLabel = 'classic';
const String classicSlimModelFirebaseLabel = 'classicSlim';
const String slimModelFirebaseLabel = 'slim';
const String imageBucketLabel = 'images';

String destinationForImages(String imageUrl) => 'images/$imageUrl';

// SIZES
const String slimSizeExtraExtraSlimLabel = 'XXS';
const String slimSizeExtraSlimLabel = 'XS';
const String slimSizeSlimLabel = 'S';
const String slimSizeMediumLabel = 'M';
const String slimSizeLargeLabel = 'L';
const String slimSizeExtraLargeLabel = 'XL';

// SIZE DETAIL SCREEN
const String addFabricFloatingButtonTooltip = 'Aggiungi Tessuto';
const String plusSymbolLabel = '+';
const String minusSymbolLabel = '-';

// FABRIC SCREEN
const String insertNameOfFabricLabel = 'Inserisci il nome del tessuto';
const String insertAtLeastOneItem =
    'Inserisci almeno un elemento nel totale (un numero maggiore di 0)';
const String sizeLabel = 'Taglia';
const String modelOfShirtEnumLabel = 'Modello';
const String insertTotalAmountOfFabricToAdd =
    'Seleziona la quantità totale di camicie da aggiungere:';
const String areYouSureYouWantToDeleteThisFabricLabel =
    'Sei sicuro di voler cancellare questo tessuto?';
const String byPressingConfirmYouWillDeleteTheFabricLabel =
    'Premendo il tasto conferma questo tessuto verrà eliminato per sempre';
const String chooseWhereToPickImageLabel = "Scegli dove prendere l'immagine";
const String byPressingOneOfTheButtonYouChooseTheScourceOfTheImageLabel =
    "Premendo su uno dei bottoni si può selezionare se prendere l'immagine dalla galleria e scattarne una nuova con la fotocamera"; // ignore: lines_longer_than_80_chars
const String cameraLabel = 'Camera';
const String galleryLabel = 'Galleria';

// QUANTITY PICKER DIALOG
const String editFabricLabel = 'Modifica tessuto';
const String editNotificationLabel = 'Modifica notifica';

String slimSizeIsLabel(int size) => '$sizeLabel: ${getSlimSizeFromInt(size)}';

String sizeIsLabel(int size) => '$sizeLabel: $size';

String modelIsLabel(ModelOfShirtEnum modelOfShirtEnum) =>
    '$modelOfShirtEnumLabel: ${getModelFromEnum(modelOfShirtEnum)}';

// NOTIFICATIONS SCREEN
const String areYouSureToDeleteThisNotificationLabel =
    'Sei sicuro di voler cancellare questa notifica?';
const String byPressingConfirmYouWillDeleteTheNotificationLabel =
    'Premendo il tasto conferma cancellerai la notifica per sempre';
const String areYouSureToDeleteAllNotificationsLabel =
    'Sei sicuro di voler cancellare tutte le notifiche?';
const String byPressingConfirmYouWillDeleteAllTheNotificationsLabel =
    'Premendo il tasto conferma cancellerai tutte le notifiche per sempre';
const String thereAreNoMoreNotificationsLabel =
    'Tutte le notifiche sono state completate';
const String totalMissingAmountLabel = 'Camicie mancanti';
String getTotalMissingAmountWithLabel(int totalAmount) =>
    '$totalMissingAmountLabel: $totalAmount';

// EXCEPTIONS
const String anErrorHasOccurredDuring = 'Si è verificato un errore durante';
String anErrorHasOccurredWithError(String error) =>
    '$anErrorHasOccurredDuring $error';
const String uploadOfThePhotoLabel = "l'upload della foto su cloud";
const String selectionOfThePhotoLabel = 'la selezione della foto';
const String retrievingGlobalSettingsLabel =
    'la raccolta delle impostazioni globali';
const String updatingGlobalSettingsLabel =
    "l'aggiornamento delle impostazioni globali";
const String changingThemeModeLabel = 'il cambiamento del tema';
const String changingHomeScreenText =
    'il cambiamento del testo della home page';
const String retrievingModelLabel = 'la raccolta dei modelli';
const String addingNewModelLabel = "l'aggiunta di un nuovo modello";
const String retrievingSizeLabel = 'la raccolta delle taglie';
const String addingNewSizeLabel = "l'aggiunta di una nuova taglia";
const String retrievingNotificationLabel = 'la raccolta delle notifiche';
const String updatingNotificationLabel = 'la modifica delle notifiche';
const String addingNewNotificationLabel = "l'aggiunta di una nuova notifica";
const String removingNotificationLabel = 'la rimozione di una notifica';
const String removingAllNotificationLabel =
    'la rimozione di tutte le notifiche';
const String retrievingFabricLabel = 'la raccolta dei tessuti';
const String updatingFabricLabel = "l'aggiornamento di un tessuto";
const String increasingFabricLabel = "l'aumento del numero dei tessuti";
const String reducingFabricLabel = 'la riduzione del numero dei tessuti';
const String addingNewFabricLabel = "l'aggiunta di un nuovo tessuto";
const String removingFabricLabel = 'la rimozione di un nuovo tessuto';
const String retrievingStatsLabel = 'la raccolta delle statistiche';
const String updatingStatsLabel = 'la modifica delle statistiche';
const String addingNewStatLabel = "l'aggiunta di una nuova statistica";
const String removingStatLabel = 'la rimozione di una statistica';
const String removingAllStatsLabel = 'la rimozione di tutte le statistiche';
