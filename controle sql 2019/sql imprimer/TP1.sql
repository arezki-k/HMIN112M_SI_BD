drop table CLIENT cascade constraint;
drop table COMMANDE cascade constraint;
drop table PRODUIT cascade constraint;
drop table fournisseur cascade constraint;

create table fournisseur
(nomf varchar (20),
adrsf varchar(100),
constraint fournisseur_pk primary key (nomf));

create table PRODUIT
(nomp varchar (20),
nomf varchar (20),
cout FLOAT,
constraint PRODUIT_pk primary key(nomp, nomf));

create table COMMANDE 
(ncom int,
nomc varchar(20),
nomp varchar(20),
nomf varchar(20),
qte int,
constraint COMMANDE_pk primary  key (ncom),
constraint COMMANDE_fk1 foreign key (nomp, nomf) references PRODUIT (nomp, nomf));

create table CLIENT
(nomc varchar(20),
adrsc varchar(100),
solde FLOAT,
constraint CLIENT_pk primary key (nomc));


/*parie 2*/
                                /*contraintes*/
alter table PRODUIT add constraint cout_produit
            CHECK(cout>0);
alter table PRODUIT add constraint PRODUIT_fk1 foreign key (nomf) references fournisseur (nomf);

alter table COMMANDE add constraint qte_commende
            CHECK (qte>0);
alter table COMMANDE add constraint COMMANDE_fk2 foreign key (nomc) references CLIENT(nomc);

/*partie 3*/


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
/*  Nom et adresse des clients dont le nom commence par un �J� (attention � la casse de la police
de caract�res)*/
select nomc, adrsc from CLIENT where nomc like 'j%';
/*Nom et adresse des clients ayant command� du produit �brique�, la quantit� command�e �tant
comprise entre 5 et 10*/
 select nomc, adrsc from client NATURAL JOIN commande WHERE nomp='brique' AND Qte BETWEEN 5 AND 10;


/*Nom et co�t moyen des articles propos�s par les fournisseurs */
select nomf, avg(cout) from produit GROUP BY nomf;



/*partie 4*/

                /*Requ�tes de d�finition et de mises � jour*/
insert into COMMANDE (ncom, nomc, nomp, nomf, qte ) VALUES
(6,'paul', 'ciment', 'Samaco','12');
insert into COMMANDE (ncom, nomc, nomp, nomf, qte ) VALUES
(7,'pierre','parpaing','Abounayan','8');
/******/
update client SET adrsc='Toulon'
where nomc='jean'; 
/*****/
update produit set cout=cout+cout*0.15
where nomf='Samaco';
/**/
update fournisseur set nomf='Technal'
where nomf='Samaco';
update fournisseur set adrsf='69005 Lyon'
where nomf='Technal';

/*partie 5*/

/*1. Nom des fournisseurs qui proposent le produit �brique� mais pas le produit �parpaing� ;*/
select nomf from produit  where nomp='brique'AND nomp<>'parpaing';
/*2.Nom et co�t moyen des produits propos�s par au moins deux fournisseurs ;*/
SELECT nomp, avg (cout)from produit group by nomp having count(nomf)>=2;
/*3.Nom des produits et de leurs fournisseurs qui sont propos�s par ces m�mes fournisseurs � des
co�ts sup�rieurs � leurs co�ts moyens.*/
/*creation d'une vue de moyenne_produit*/
create view moyenne_produit as
select nomp, avg(cout) as cout_moyen from produit GROUP BY nomp;

/*selection dans la jonction des deux tables*/
select nomp,nomf from produit natural join moyenne_produit where cout>cout_moyen;

/*4.Nom des produits dont le prix est > au co�t moyen de tous les produits ;*/
select nomp from produit natural join moyenne_produit where cout>cout_moyen;

/*5.Nom des fournisseurs qui proposent tous les produits command�s par Jean (� l�instant de
l�ex�cution de la requ�te) ;*/



