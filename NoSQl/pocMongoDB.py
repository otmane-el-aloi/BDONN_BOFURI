from pprint import pprint
from pymongo import MongoClient
import pymongo

# Fiches des collaborateurs
fiche1 = {
    "nomCollaborateur": "DUMOND",
    "prenomCollaborateur": "Alice",
    "nomClient": "REY",
    "prenomClient": "Jacques",
    "societe": "My Fruit Company",
    "tel": "+33 6 65 89 56 34",
    "email":"Jacques.Rey@fruitcompany.com",
    "resultat": "Attente avis"
}

fiche2 = {
    "nomCollaborateur": "DUMOND",
    "prenomCollaborateur": "Alice",
    "nomClient": "PROUST",
    "prenomClient": "Adeline",
    "societe": "Les fruits de là bas",
    "tel": "+33 4 98 12 22 11",
    "email":"adproust@gmail.com",
    "resultat": "Attente de devis de notre part"
}

fiche3 = {
    "nomCollaborateur": "LELIEVRE",
    "prenomCollaborateur": "Pascal",
    "nomClient": "DIMITRIEVSKI",
    "prenomClient": "Vladimir",
    "societe": "Primeur & co",
    "date": "12/03/2019",
    "email":"primerandco@gmail.com",
    "resultat": "A relancer"
}

fiche4 = {
    "nomCollaborateur": "LELIEVRE",
    "prenomCollaborateur": "Pascal",
    "nomClient": "NICOLS",
    "prenomClient": "Peter",
    "societe": "Com’Pote",
    "date": "21/04/2019",
    "email":"com.pote@macompote.com",
    "resultat": "Prêt pour un essai"
}

fiche5 = {
    "nomCollaborateur": "DUPOND",
    "prenomCollaborateur": "Laetitia",
    "nomClient": "TOUGERON",
    "prenomClient": "Nathalie",
    "societe": "TOUGERON & Fille",
    "date": "4/05/2019",
    "tel":"06 12 85 45 76",
    "resultat": "Devrait passer commande prochainement"
}

fiche6 = {
    "nomCollaborateur": "DUPOND",
    "prenomCollaborateur": "Laetitia",
    "nomClient": "MARKOVA",
    "prenomClient": "Alexandra",
    "societe": "Primeur & co",
    "date": "4/05/2019",
    "tel": "06 87 81 20 74",
    "resultat": "A recontacter en fin d’année"
}



CONNECTION_URL= "mongodb://127.0.0.1:27017/"
FICHES =[ fiche1, fiche2, fiche3, fiche4, fiche5, fiche6]


def connect(connection_url):
    client = MongoClient(connection_url)
    db = client["ficheCollaborateur"]
    fiches = db["fiches"]
    return fiches


if __name__ == "__main__":

    # Connection à la base de donnée:
    fiche = connect(CONNECTION_URL)

    # # Insertion des fiches:
    # fiche.insert_many(FICHES)

    # Le nombre total de fiches:
    print("Nombre de documents: ", fiche.count_documents({}))

    # Nombre de fiches de chaque collaborateur:
    print("Nombre  de fiches de Alice DUMOND",
        fiche.count_documents({"nomCollaborateur": "DUMOND", "prenomCollaborateur": "Alice"}))

    print("Nombre de fiches de Pascal LELIEVRE",
        fiche.count_documents({"nomCollaborateur": "LELIEVRE", "prenomCollaborateur": "Pascal"}))

    print("Nombre de fiches de Laetitia DUPOND",
        fiche.count_documents({"nomCollaborateur": "DUPOND", "prenomCollaborateur":"Laetitia"}))


    # Fiche de Jacques REY:
    ficheClient = fiche.find({"nomClient": {'$regex':'\s*(?i)rey\s*'}, "prenomClient": {"$regex":"\s*(?i)Jacques\s*"}})
    print("Fiche de Jaques REY: ")
    for f in ficheClient:
        pprint(f)

    # Fiche d'entreprise "Primeur & co"
    ficheClient = fiche.find({"societe": {"$regex":"\s*(?i)primeur\s*&\s*(?i)co"}})
    print("Fiche de la société Primeur & co: ")
    for f in ficheClient:
        pprint(f)