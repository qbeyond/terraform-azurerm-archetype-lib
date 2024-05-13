# vorläufieges Konzept für die Logick was mit den Policies umgesetzt werden soll
trigger: nsg erstellung 
if: orderntlich benamst  {
    dann: schau ob, (aus dem namen entnehmen) * deny da ist {
        wenn ja: cool! 
        wenn nein: schau ob letzte regel frei{
            wenn ja: modify ein deny ran 
            wenn nein: nette fehlermeldung ausdenken }
        } 
    }

# Tests
## Tests: NSG Erstellung 

NSG entspricht nicht Namenskonvention 
-> keine Policy schlägt an, Gruppe darf erstellt werden, regeln sind egal 

NSG entspricht Namenskonvention, NSG hat eine Regel mit <subnet_aus_namen, *, deny> 
-> Policy schlägt nicht an, erstellung wird erlaubt (weil alles richtig ist) 

NSG entspricht Namenskonvention, NSG hat keine Regel mit <subnet_aus_namen, *, deny>, die letzte Regel der NSG ist frei 
-> Policy schlägt an und (modify) erstellt auf niedrigster Prio die Regeln <subnet_aus_namen, *, deny> 
-> Logging: Regel <subnet_aus_namen, *, deny> wurde an niedrigster prioritär erstellt, überprüfe bei Bedarf welche speziefischen allows gesetzt werden müssen 

NSG entspricht Namenskonvention, NSG hat keine Regel mit <subnet_aus_namen, *, deny>, die letzte Regel der NSG ist belegt 
-> Policy schlägt an und verhindert Aufbau der NSG.  
-> Error: NSG kann nicht angelegt werden, weil keine <subnet_aus_namen, *, deny> Regel besteht. Erneut erstellen und niedrigste Prio freilassen oder die Regel <subnet_aus_namen, *, deny> hinzufügen 

## Tests: Subnet Erstellung 

Subnet hat die richtige NSG vermerkt 
-> Policy schlägt nicht an weil alles stimmt 

Subnet wird ohne vermerkte NSG erstellt 
-> Policy schlägt an, verhintert Subnet erstellung 
-> Error: Subnet kann nicht ohne NSG erstellt werden 

Subnet wird mit vermerkter NSG erstellt, die nicht der Namenskonvention entspricht 
-> Policy schlägt an, verhindert Subnet erstellung 
-> Error: Subnet kann nur mit NSG erstellt werden, welche der Namenskonvention entspricht und dadurch eine <subnet_aus_namen, *, deny> Regel hat. 