-- versie 20230426
function handle(eventData)
    local jsonModelScratch = [[
      {
        "r": {
          "m": {
            "getWlzIndicatieVoorIndicatieID": "#W"
          }
        },
        "W": {
          "m": { "grondslag": "#G", "geindiceerdZorgzwaartepakket": "#GZ", "beperking": "#B", "stoornis": "#S", "stoornisScore": "#SS", "wzd": "#WZD", "client": "#C" },
          "f": ["wlzindicatieID", "bsn", "besluitnummer", "soortWlzindicatie", "afgiftedatum", "ingangsdatum", "einddatum", "meerzorg", "commentaar"],
          "p": {
            "wlzindicatieID": "$$ReplaceWithRecordID$$"
          }
        },
        "G": {
          "f" : ["id", "grondslag", "volgorde", "wlzindicatieID"]
        },
        "GZ": {
          "f" : ["id", "zzpCode", "ingangsdatum", "einddatum", "voorkeurClient", "instellingVoorkeur", "financiering", "commentaar", "wlzindicatieID"]
        },
        "B": {
          "m": {"beperkingScores":  "#BS"},
          "f": ["id", "categorie", "duur", "commentaar", "wlzindicatieID"]
        },
        "S": {
          "f": ["id", "grondslag", "diagnoseCodelijst", "diagnoseSubCodelijst", "ziektebeeldStoornis", "prognose", "commentaar", "wlzindicatieID"]
        },
        "SS": {
          "f": ["id", "stoornisVraag", "stoornisScore", "commentaar", "wlzindicatieID"]
        },
        "WZD": {
          "f": ["wzdVerklaring", "ingangsdatum", "einddatum"]
        },
        "BS": {
          "f": ["id", "beperkingVraag", "beperkingScore", "commentaar", "beperkingID"]
        },
        "C": {
            "m": {"contactPersoon": "#CP", "contactGegevens": "#CG"},
            "f": ["id", "bsn", "geheimeClient", "geboorteDatum", "geboortedatumGebruik", "geslacht", "burgerlijkeStaat", "geslachtsnaam", "voorvoegselGeslachtsnaam", "partnernaam", "voorvoegselPartnernaam", "voornamen", "roepnaam", "voorletters", "naamGebruik", "leefeenheid", "agbcodeHuisarts", "communicatieVorm", "taal", "commentaar"]
        },
        "CP": {
            "m": {"contactGegevens": "#CG"},
            "f": ["id", "relatieNummer", "volgorde", "soortRelatie", "organisatieNaam", "voornamen", "roepnaam", "voorletters", "geslachtsnaam", "voorvoegselGeslachtsnaam","partnernaam","voorvoegselPartnernaam","naamGebruik","geslacht","geboorteDatum","geboortedatumGebruik","ingangsdatum","einddatum","clientID"]
        },
        "CG": {
            "m": {"adres": "#A", "telefoon":  "#T", "email": "#E"},
            "f": ["id", "clientID", "contactPersoonID"]
        },
        "A": {
            "f": ["id", "adresSoort", "straatnaam", "huisnummer", "huisletter", "huisnummerToevoeging", "postcode", "plaatsnaam", "landCode", "aanduidingWoonadres", "ingangsdatum", "einddatum", "contactGegevenID"]
        },
        "T": {
            "f": ["telefoonnummer", "landnummer", "ingangsdatum", "einddatum", "contactGegevenID"]
        },
        "E": {
            "f": ["emailadres", "ingangsdatum", "einddatum", "contactGegevenID"]
        } 
      }]]

    local jsonModel = jsonModelScratch:gsub("%$%$ReplaceWithRecordID%$%$", eventData.wlzindicatieID)
    local modelPath = "/tst/netwerkmodel/v1/graphql"

    if not headlessAuthorization(eventData.clientID, eventData.redirectID, eventData.audience, jsonModel, modelPath) then
        error("lua headless authorization")
    end
end
