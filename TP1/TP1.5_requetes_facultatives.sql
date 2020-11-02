/*1. Nom des fournisseurs qui proposent le produit ”brique” mais pas le produit ”parpaing” ;*/
select nomf from produit  where nomp='brique'AND nomp<>'parpaing';
/*2.Nom et coût moyen des produits proposés par au moins deux fournisseurs ;*/
SELECT nomp, avg (cout)from produit group by nomp having count(nomf)>=2;
/*3.Nom des produits et de leurs fournisseurs qui sont proposés par ces mêmes fournisseurs à des
coûts supérieurs à leurs coûts moyens.*/
/*creation d'une vue de moyenne_produit*/
create view moyenne_produit as
select nomp, avg(cout) as cout_moyen from produit GROUP BY nomp;

/*selection dans la jonction des deux tables*/
select nomp,nomf from produit natural join moyenne_produit where cout>cout_moyen;

/*4.Nom des produits dont le prix est > au coût moyen de tous les produits ;*/
select nomp from produit natural join moyenne_produit where cout>cout_moyen;

/*5.Nom des fournisseurs qui proposent tous les produits commandés par Jean (à l’instant de
l’exécution de la requête) ;*/



