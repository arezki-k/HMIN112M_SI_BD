
                                /*requetes de consultation*/
/*affichage du contenu*/
select * from fournisseur;
select * from PRODUIT;
select * from COMMANDE;
select * from CLIENT;
/*clinet avec solde <0 */
select nomc from CLIENT where solde<0;
/*produit brique ou produit parppaings*/
select nomf from produit where nomp="brique" or nomp="parpaing";
/*  Nom et adresse des clients dont le nom commence par un ”J” (attention à la casse de la police
de caractères)*/
select nomc, adrsc from CLIENT where nomc like 'j%';
/*Nom et adresse des clients ayant commandé du produit ”brique”, la quantité commandée étant
comprise entre 5 et 10*/
 select nomc, adrsc from client NATURAL JOIN commande WHERE nomp='brique' AND Qte BETWEEN 5 AND 10;


/*Nom et coût moyen des articles proposés par les fournisseurs */
select nomf, avg(cout) from produit GROUP BY nomf;



