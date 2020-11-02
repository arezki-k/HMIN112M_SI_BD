
------------------------------FOURNISSEUR-------------------------------------

insert into fournisseur values ('Abounayan', '92190 Meudon');
insert into fournisseur values ('Cima','75010 Paris');
insert into fournisseur values ('Preblocs','92230 Genevilliers');
insert into fournisseur values ('Samaco','75116 Paris');
--------------------------------PRODUIT----------------------------------------------

insert into produit values ('sable','Abounayan',300);
insert into produit values ('brique','Abounayan',1500);
insert into produit values ('parpaing','Abounayan',1150);
insert into produit values ('tuile','Preblocs',1150);
insert into produit values ('parpaing','Preblocs',1200);
insert into produit values ('parpaing','Samaco',1150);
insert into produit values ('ciment','Samaco',125);
insert into produit values ('brique','Samaco',1200);
insert into produit values ('brique','Cima',1000);

------------------------------CLIENT------------------------------------------------

insert into client values ('jean','75006 Paris',-12000);
insert into client values ('paul','75003 Paris',0);
insert into client values ('vincent','94200 Ivry',3000);
insert into client values ('pierre','92400 Courbevoie',7000);

-----------------------------COMMANDE--------------------------------------------

insert into commande values (1,'jean','brique','Abounayan',5);
insert into commande values (2,'jean','ciment','Samaco',1);
insert into commande values (3,'paul','brique','Samaco',3);
insert into commande values (4,'paul','parpaing','Samaco',9);
insert into commande values (5,'vincent','parpaing','Preblocs',7);

