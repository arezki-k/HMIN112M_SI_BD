/*Sur la table DEPT rajouter la contrainte dept pk
 définissant n dept comme clé primaire.*/
ALTER TABLE DEPT ADD CONSTRAINT dept_pk PRIMARY KEY(n_dept);

/*Sur la table EMP rajouter les contraintes suivantes :*/
/*1. emp pk définissant num comme clé primaire,*/
ALTER TABLE EMP ADD CONSTRAINT EMP_PK PRIMARY KEY(num);


/*2. nom u définissant nom comme nom unique,*/
/*changement du nom de martin en martin1 pour qu'il y ai qu'un seul martin dans la liste*/
UPDATE emp set nom='martin1' where num = 16712;
ALTER TABLE emp ADD CONSTRAINT nom_u unique(nom);


/*3. responsable définissant n sup comme Foreign key référençant num (CI intra table)*/
ALTER TABLE emp ADD CONSTRAINT responsable Foreign KEY (n_sup) references emp(num);

/*4.dept définissant n dept comme Foreign key référençant n dept de la table DEPT (CI inter
table)*/
/*ajout dept 100 dans la table dept car inexistant*/
INSERT INTO dept VALUES (100, null, null);
ALTER TABLE emp ADD CONSTRAINT dept_fk FOREIGN KEY (n_dept) references dept(n_dept);

/*5.commission définissant un controle tel que seuls les employés dont la fonction est commercial
aient une commission comm non nulle (null).*/
/*ajout commission = 0 pour baraq*/
update emp set comm=0 where num=24832;
ALTER TABLE Emp ADD CONSTRAINT commission 
    CHECK ((comm IS NOT NULL AND FONCTION='commercial' ) 
    or (comm is null and fonction != 'commercial'));
    /*affichage des contraintes*/
/*test des contraintes*/
    /*avec un num deja existant*/
INSERT INTO EMP VALUES
	('gael',24832,'commercial', 16712,'10-SEP-08',1500,NULL,30);
    /*commercial sans commission*/
INSERT INTO EMP VALUES
	('sofiane',99832,'commercial', 16712,'10-SEP-08',1500,NULL,30);
    /*!= commercial avec commission*/
INSERT INTO EMP VALUES
	('sofiane',99832,'ingenieur', 16712,'10-SEP-08',1500,5000,30);
/*afficher une contraintes en particulier*/
 select * from user_constraints where constraint_name='RESPONSABLE';
/*desactivation constraintes*/
alter table emp disable constraint commission;
/*creation de n_uplets transgressant la contraintes commission*/
INSERT INTO EMP VALUES
	('sofiane',99832,'ingenieur', 16712,'10-SEP-08',1500,5000,30);
INSERT INTO EMP VALUES
	('jhonny',49832,'commercial', 16712,'10-SEP-08',1500,null,30);
    /*teste de retablissement*/
    alter table emp enable constraint commission;
/*ERREUR a la ligne 1 :
ORA-02293: impossible de valider (E20160010237.COMMISSION) - violation d'une contrainte de controle
*/











