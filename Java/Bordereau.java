package org.centrale.projet.objet.generationordredemission;

import java.sql.*;
import java.util.Scanner;

/**
 * @author Otmane
 */

/**
 * Class Bordereau 
 * permet la génération d'un bordereau de livraison
 */
public class Bordereau {

    public static void main(String[] args) {
        //Récupération de l'id de l'ordre
        int id_ordre = 0;
        Scanner sc = new Scanner(System.in);
        id_ordre = sc.nextInt();
        
        try {
            // Connection à la base de donnée
            Class.forName("org.postgresql.Driver");
            Connection connect = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BOFURI_DATABASE", "admin","0630199901");
            
            // Requête à éxecuter dans la base pour récuppérer les données de bordereau
            String query = "SELECT DISTINCT ordre_mission.id_ordre, entreprise.nom as entreprise, adresse_depot as depot, CONCAT(chauffeur.nom,' ', chauffeur.prenom) as chauffeur, commande_en_ordre.date_livraison_ordre, \n" +
                            "adresse_quai as quai_chargement, date_chargement, produit.nom as produit, comporte.quantite\n" +
                            "FROM ordre_mission INNER JOIN quai_chargement ON (ordre_mission.id_quai=quai_chargement.id_quai)\n" +
                            "INNER JOIN commande_en_ordre ON (ordre_mission.id_ordre=commande_en_ordre.id_ordre)\n" +
                            "INNER JOIN chauffeur ON (ordre_mission.id_chauffeur = chauffeur.id_chauffeur)\n" +
                            "INNER JOIN commande ON (commande.id_commande = commande_en_ordre.id_commande)\n" +
                            "INNER JOIN livree_a ON (commande.id_commande = livree_a.id_commande)\n" +
                            "INNER JOIN depot ON (livree_a.id_depot = depot.id_depot)\n" +
                            "INNER JOIN entreprise ON (commande.id_entreprise = entreprise.id_entreprise)\n" +
                            "INNER JOIN comporte ON (comporte.id_commande = commande.id_commande )\n" +
                            "INNER JOIN produit ON (comporte.id_produit = produit.id_produit)\n" +
                            "WHERE ordre_mission.id_ordre = ?";
            PreparedStatement stmt = connect.prepareStatement(query);
            stmt.setInt(1, id_ordre);;
            ResultSet res = stmt.executeQuery();
            
            while (res.next()){
            System.out.println("Chauffeur : "+ res.getString("chauffeur"));
            System.out.println("Date de chargement : "+ res.getString("date_chargement"));
            System.out.println("Quai de Chargement : "+ res.getString("quai_chargement"));
            break;
            }
            
            // iterer sur toutes les commandes dans l'ordre
            System.out.println("Nom    "+"Adresse                            "+ "Date Livraison     "+"Nom Produit "+"Quantité Livrée");
            while (res.next()) {
                System.out.println(res.getString("entreprise")+" "+res.getString("depot")+" "+res.getString("date_livraison_ordre")+" "+res.getString("produit")+"       "+res.getString("quantite"));
            }
            stmt.close();
            connect.close() ;
        } catch(java.lang.ClassNotFoundException e) {
            System.err.println("ClassNotFoundException : " + e.getMessage()) ;
        } catch(SQLException ex) {
            System.err.println("SQLException : " + ex.getMessage());
        }
         
    }
}
