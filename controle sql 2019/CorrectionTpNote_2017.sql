drop table salle cascade constraints;
drop table module cascade constraints;
drop table seance cascade constraints;

prompt creation tables 
create table salle (
codeS varchar(8) constraint salle_pk primary key, 
batiment varchar(6), typeS varchar(6), capacite integer, 
videoproj varchar(1), numerique varchar(1), 
constraint typeS_dom check( typeS in ('sc','amphi','td','tp')),
constraint videoproj_dom check( videoproj in ('O','N')), 
constraint numerique_dom check( numerique in ('O','N')));

create table module (
codeM varchar(8) constraint module_pk primary key, 
intituleM varchar(30), 
niveau varchar(6), semestre varchar(4), 
nbreCredits integer, 
hcm float, 
htd float, 
htp float, 
constraint niveau_dom check( niveau in ('l1','l2','l3','m1','m2')), 
constraint semestre_dom check( semestre in ('sem1','sem2')));

create table seance (
codeS varchar(8), 
codeM varchar(8), 
dateSe date, 
creneauUn integer, 
nbreCreneaux integer,  
typeSe varchar(8), 
constraint seance_pk primary key(codeS, codeM, dateSe, creneauUn), 
constraint seance_fk1 foreign key(codeS) references salle(codeS), 
constraint seance_fk2 foreign key(codeM) references module(codeM), constraint dom_typeSe check (typeSe in ('cm','td','tp','cc','tp note','ecrit')));

prompt consultation tables 
set linesize 250
prompt REQ 1 ensemble des informations sur les modules de niveau m1
select * from module where niveau='m1';

prompt REQ 2 code de la salle et capacite des salles de td equipees de videoprojecteur
select codeS, capacite from salle where typeS='td' and videoproj = 'O'; 

prompt REQ 3 intitule de module des seances de cours qui ont eu lieu le 9 octobre 2017 
select distinct intituleM from module m, seance s where m.codeM = s.codeM and dateSe ='9-oct-17';


prompt REQ 4 donner le code et la capacite des salles qui accueillent des cours de modules de niveau m1 et dont la capacite est superieure a 200 places
select distinct s.codeS, capacite from salle s, module m, seance se where se.codeM = m.codeM and se.codeS = s.codeS and niveau ='m1' and capacite > 200;  

prompt REQ 5 donner pour chaque salle, le nombre de seances d''enseignement qui y ont ete dispensees
select codeS, count(*) as nombreSeances from seance group by codeS;

prompt REQ 6 Donner le code, le type et la capacité de la salle ou des salles qui ont accueilli le plus de séances
select s.codeS, typeS, capacite from salle s, seance se 
where s.codeS = se.codeS group by s.codeS, typeS, capacite 
having count(*) >= ALL (select count(*) from seance 
group by codeS);

prompt REQ 7  Donner les salles (code, type et batiment) utilisees uniquement pour des enseignements de M1
select s.codeS, typeS, batiment from salle s, seance se, module m where s.codeS = se.codeS and se.codeM = m.codeM and niveau ='m1'
minus 
select s.codeS, typeS, batiment from salle s, seance se, module m where s.codeS = se.codeS and se.codeM = m.codeM and niveau !='m1';

prompt REQ 9 Donner les salles (code) qui sont utilisées pour tous les niveaux de formation
prompt solution partitionnement
prompt donner les salles qui ont accueilli un nombre distinct de formations egal au nombre total de formation
select codeS, count(distinct niveau) as totalNiveau from seance se, module m where se.codeM = m.codeM group by codeS having count(distinct niveau) = (select count(distinct niveau) from module);

prompt solution difference
prompt donner les salles pour lesquelles il n existe pas de niveaux de formation qui ne les aient pas utilisees
create or replace view pasTous as
select codeS, niveau from salle, module
minus select codeS, niveau from seance se, module m where se.codeM = m.codeM;

select codeS from salle minus select codeS from pasTous;

prompt solution double not exists
select codeS from salle s 
where not exists (select * from module m1
where not exists (select * from seance se, module m2 where s.codeS = se.codeS and se.codeM = m2.codeM and m1.niveau = m2.niveau));
 
prompt jeu de tuples test  
prompt salle
insert into salle values ('16.46','16','td',40,'O','N');
insert into salle values ('16.50','16','td',40,'O','N');
insert into salle values ('1.06','1','td',42,'N','N');
insert into salle values ('5.03','5','amphi',275,'O','N');
insert into salle values ('6.01','6','amphi',null,'O','N');
insert into salle values ('5.08','5','td',40,'O','O');
insert into salle values ('5.05','5','td',32,'O','O');
insert into salle values ('5.07','5','td',36,'O','O');
insert into salle values ('5.09','5','td',36,'O','O');
insert into salle values ('5.10','5','td',40,'O','O');
insert into salle values ('5.12','5','td',40,'O','O');
insert into salle values ('10.01','10','sc',120,'O','N');
insert into salle values ('20.01','20','sc',120,'O','N');
insert into salle values ('20.02','20','sc',90,'O','N');
insert into salle values ('25.01','25','sc',120,'O','N');
insert into salle values ('12.01','12','sc',120,'O','N');
insert into salle values ('16.01','16','sc',120,'O','N');
insert into salle values ('tpBat6','6','tp',20,'N','O');

prompt module
insert into module values ('HLIN102','Du binaire au web','l1','sem1',5,10.5,15,24);
insert into module values ('HLIN202','Programmation imperative','l2','sem1',5,13.5,18,18);
insert into module values ('HLIN502','Langages Formels','l3','sem1',5,16.5,33,0);
insert into module values ('HLIN501','Algorithmique de Graphes','l3','sem1',5,15,18,16.5);
insert into module values ('HLIN509','Logique des Propositions','l3','sem1',5,16.5,24,9);
insert into module values ('HLIN511','SI et BD','l3','sem1',5,15,16.5,18);
insert into module values ('HMIN112M','Bases de Donnees','m1','sem1',5,16.5,18,15);
insert into module values ('HMIN328','Administration BD','m2','sem1',5,16.5,18,15);
insert into module values ('HMIN103','BD Avancees','m1','sem1',5,16.5,16.5,16.5);
insert into module values ('HMIN110','Interaction Homme-Machine','m1','sem1',5,16.5,16.5,16.5);
insert into module values ('HMIN111M','Programmation','m1','sem1',5,16.5,15,18);
insert into module values ('HMIN113M','Systeme','m1','sem1',5,19.5,0,30);
insert into module values ('HMIN114M','Prolegomenes','m1','sem1',5,12,13,0);
insert into module values ('HMIN115M','Technologies du Web','m1','sem1',5,9,10.5,30);  
insert into module values ('HMIN116','Reseaux','m1','sem1',5,18,15,16.5);  
insert into module values ('HMIN117M','Complexite Algorithmique','m1','sem1',5,16.5,33,0);  
insert into module values ('HMIN202','Architecture n-tier','m1','sem2',5,15,15,15); 
insert into module values ('HMIN204','Conduite de Projets','m1','sem2',5,25,9,6); 
insert into module values ('HMIN209','Web Semantique et Social','m1','sem2',5,18,15,16.5); 
insert into module values ('HMIN211','Structures de Donnees','m1','sem2',5,21,15,13.5);

prompt seance
insert into seance values ('10.01','HMIN112M','11-sep-17',1,1,'cm');
insert into seance values ('10.01','HLIN502','12-sep-17',1,1,'cm');
insert into seance values ('10.01','HLIN102','12-sep-17',2,1,'cm');
insert into seance values ('10.01','HLIN202','12-sep-17',3,1,'cm');
insert into seance values ('10.01','HMIN328','15-sep-17',4,1,'cm');
insert into seance values ('5.09','HMIN112M','11-sep-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','11-sep-17',2,1,'td');
insert into seance values ('5.10','HMIN112M','11-sep-17',3,1,'td');
insert into seance values ('10.01','HMIN112M','18-sep-17',1,1,'cm');
insert into seance values ('5.09','HMIN112M','18-sep-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','18-sep-17',2,2,'td');
insert into seance values ('5.03','HMIN112M','25-sep-17',1,1,'cm');
insert into seance values ('5.09','HMIN112M','25-sep-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','25-sep-17',2,2,'td');
insert into seance values ('5.03','HMIN112M','2-oct-17',1,1,'cm');
insert into seance values ('5.09','HMIN112M','2-oct-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','2-oct-17',2,2,'td');
insert into seance values ('5.03','HMIN112M','9-oct-17',1,1,'cm');
insert into seance values ('5.09','HMIN112M','9-oct-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','9-oct-17',2,2,'td');
insert into seance values ('5.03','HMIN112M','16-oct-17',1,1,'cm');
insert into seance values ('5.09','HMIN112M','16-oct-17',2,2,'td');
insert into seance values ('5.05','HMIN112M','16-oct-17',2,2,'td');
insert into seance values ('20.02','HMIN113M','12-sep-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','12-sep-17',2,2,'tp');
insert into seance values ('20.02','HMIN113M','19-sep-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','19-sep-17',2,2,'tp');
insert into seance values ('20.02','HMIN113M','26-sep-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','26-sep-17',2,2,'tp');
insert into seance values ('20.02','HMIN113M','3-oct-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','3-oct-17',2,2,'tp');
insert into seance values ('20.02','HMIN113M','10-oct-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','10-oct-17',2,2,'tp');
insert into seance values ('20.02','HMIN113M','17-oct-17',1,1,'cm');
insert into seance values ('tpBat6','HMIN113M','17-oct-17',2,2,'tp');
insert into seance values ('20.02','HMIN111M','15-sep-17',1,1,'cm');
insert into seance values ('5.05','HMIN111M','15-sep-17',2,1,'td');
insert into seance values ('5.07','HMIN111M','15-sep-17',3,1,'td');
insert into seance values ('20.02','HMIN111M','22-sep-17',1,1,'cm');
insert into seance values ('5.05','HMIN111M','22-sep-17',2,1,'td');
insert into seance values ('5.07','HMIN111M','22-sep-17',3,1,'td');
insert into seance values ('20.02','HMIN111M','29-sep-17',1,1,'cm');
insert into seance values ('5.05','HMIN111M','29-sep-17',2,1,'td');
insert into seance values ('5.07','HMIN111M','29-sep-17',3,1,'td');
insert into seance values ('20.02','HMIN111M','6-oct-17',1,1,'cm');
insert into seance values ('5.05','HMIN111M','6-oct-17',2,1,'td');
insert into seance values ('5.07','HMIN111M','6-oct-17',3,1,'td');
insert into seance values ('tpBat6','HMIN116','14-sep-17',4,4,'tp');
insert into seance values ('tpBat6','HMIN116','21-sep-17',4,4,'tp');
insert into seance values ('tpBat6','HMIN116','28-sep-17',4,4,'tp');
insert into seance values ('tpBat6','HMIN116','5-oct-17',4,4,'tp');
insert into seance values ('tpBat6','HMIN116','12-oct-17',4,4,'tp');
insert into seance values ('tpBat6','HMIN116','19-oct-17',4,3,'tp');
insert into seance values ('tpBat6','HMIN116','26-oct-17',4,3,'tp');
insert into seance values ('tpBat6','HMIN116','9-nov-17',4,3,'tp');
insert into seance values ('25.01','HMIN114M','4-sep-17',5,2,'cm');
insert into seance values ('25.01','HMIN114M','5-sep-17',2,2,'cm');
insert into seance values ('25.01','HMIN114M','5-sep-17',5,2,'cm');
insert into seance values ('25.01','HMIN114M','6-sep-17',2,1,'cm');
insert into seance values ('1.06','HMIN114M','6-sep-17',3,1,'td');
insert into seance values ('1.06','HMIN114M','6-sep-17',5,2,'td');
insert into seance values ('25.01','HMIN114M','7-sep-17',2,1,'cm');
insert into seance values ('1.06','HMIN114M','7-sep-17',3,1,'td');
insert into seance values ('1.06','HMIN114M','7-sep-17',5,2,'td');
insert into seance values ('1.06','HMIN114M','8-sep-17',2,2,'td');

commit;
