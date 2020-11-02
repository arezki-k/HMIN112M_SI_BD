drop table troupe cascade constraints;
drop table artiste cascade constraints;
drop table spectacle cascade constraints;
drop table seProduitDans cascade constraints;

prompt creation de tables

/*creation des tables*/

create table troupe(
    nomTr varchar (20) constraint troupe_pk primary key,
    domiciliation varchar (20)
);

create table artiste(
    nomA varchar (20),
    prenomA varchar (20),
    dateN date,
    genre varchar (1),
    nomTroupe varchar (20) ,
    constraint artiste_pk primary key(nomA, prenomA),
    constraint artiste_fk1  foreign key (nomTroupe) references troupe(nomTr),
    constraint genre_artiste check (genre in ('h','f')));

create table spectacle(
    codeS varchar (8) constraint spectacle_pk primary key,
    titre varchar (20),
    lieu varchar (20),
    ville varchar (12),
    dateS date,
    nomTroupe varchar (20),
    constraint spectacle_fk1  foreign key (nomTroupe) references troupe(nomTr));

create table seProduitDans(
    nomA varchar (20),
    prenomA varchar (20),
    codeS varchar (8),
    nomRole varchar (20),
    constraint seProduitDans_pk primary key (nomA, prenomA, codeS),
    constraint seProduitDans_fk1  foreign key (nomA, prenomA) references artiste(nomA, prenomA),
    /*constraint seProduitDans_fk2 (prenomA) foreign key references artiste(prenomA),*/
    constraint seProduitDans_fk2 foreign key (codeS) references spectacle(codeS));

set linesize 300;
col table_name for a30
prompt requetage:
prompt req 1 titre, ville et date de representation des spectacles
select titre, ville, dateS from spectacle;

prompt req 2 nom, prenom des actrices:
select nomA, prenomA from artiste where genre='f';

prompt req 3 nom, prenom, genre artiste appartenant a la troupe 'Royal de luxe'
select nomA, prenomA, genre from artiste where nomTroupe='Royal De Luxe';

prompt req 4 nombre de spectacle ayant eu lieu dans la ville de paris
select count(ville) from spectacle where ville='Paris';
/*pour plus de detail:
select ville, count(ville) from spectacle where ville='Paris' group by ville;
*/

prompt req 5 nom des troupes qui ne proposent aucun spectacle:
select nomtr from troupe minus(select nomtroupe as nomtr from spectacle);


prompt req 6 nombre de spectacle propse par chaque compagnie
select nomtroupe, count(nomtroupe) as nombre_spectacle from spectacle group by nomtroupe;


prompt req 7 compagnie qui a donne le plus grand nombre de spectacle
/*creation d'une vue avec le nombre de spectacle pour chaque compagnies s'etant produite*/
create view nombrespectacle as 
select nomtroupe, count(nomtroupe)as nombrespectacle from spectacle group by nomtroupe;
/*selection de la compagnie ayant le plus grand nombre de sepctacle*/
select nomtroupe, max(nombrespectacle)from nombrespectacle;
/*select max(nombrespectacle)from nombrespectacle;*/




prompt req 8 artiste (nom, prenom) qui ont joue dans tous les spectacles donne par la troupe
/*creation d'une vue spectacletheatre14*/
create view spectacleTheatre14 as
select * from spectacle natural join artiste where nomtroupe='Theatre 14';
select noma, prenoma from spectacleletheatre14;



prompt req 9 nom, prenom des artistes qui ont joue dans un spectacle le jour de leurs anniversaire
select noma, prenoma from spectacle natural join artiste where dayofyear(dateN)=dates;