
                /*Requêtes de définition et de mises à jour*/
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
