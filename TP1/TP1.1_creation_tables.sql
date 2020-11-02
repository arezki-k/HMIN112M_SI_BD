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