/*1. Donner toutes les informations sur les tables sur lesquelles vous avez des droits*/
select table_name from dba_tables;

/*2. Donner le nombre d’attributs de la table EMP*/
select count(column_name) from user_tab_columns/*ou cols*/ where table_name = 'EMP';



/*3. Donner la liste des contraintes (avec leur statut) créées au cours du TP précédent*/
select constraint_name, table_name, status from user_constraints;
/*4. Donner les informations sur les contraintes de type clé primaire que vous aviez créées au cours
de ce TP*/
select constraint_name, table_name, status, constraint_type from user_constraints;
select constraint_name, table_name, status from user_constraints where constraint_type='P';
select * from user_constraints where constraint_type='P';



/*5. Utilisez à bon escient la table USER TAB COLUMNS de manière à avoir un maximum d’infor-
mations sur une table donnée (partageant des similarités avec la commande desc de SQL*Plus).*/



/*DONNER LES DROITS DE LECTURE A Y*/
GRANT SELECT ON EMP TO Y;
grant select on emp to e20150000418;
grant update on dept to y;
grant select on dept to y;
grant insert on dept to y;
insert into y.dept values (14, 'recherche', 'Montpellier')
select * from y.dept;

/*donner les droits de modification a Y*/
grant update on dept to Y;

/*verifier l'accord des privilèges*/
select grantee, table_name, grantor from user_tab_privs_made;
update y.emp 

insert into e20150000418.dept values(34,'Recherche','montpellier');

/*creer vu*/
/*revoke*/
revoke select on emp from y;
select * from user_tab_privs;
revoke update on dept from y;
/*verifier les privilege*/
select * from user_tab_privs;

/*creer une vue*/
create view privilege as select * from y.dept;
/*on perd les droits d'accés a la vue crée;
on garde le droit d'accés a la table crée*/
select * from privilege;
/*selection dans les memes lignes
pas de bug entre les utilisateurs*/
select * from y.emp;
select * from y.dept;

commit; /*validation*/
rollback;;/*annulation*/
/*deadlock*/
/*constatation: bug au niveau des modifications
modif sauvegardé: les pemieres modifs
solution: de faire un commit a chaque modif*/




