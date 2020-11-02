/*1. Donner les nom, fonction et date d’embauche de tous les employ´es*/
SELECT NOM, FONCTION, EMBAUCHE 
FROM emp;
/*2. Donner les numéros,
 nom et salaire des employés dont le salaire est <= 2000 euros,*/
 SELECT NUM, NOM ,SALAIRE 
 FROM emp 
 WHERE SALAIRE <= 2000;
/*3. Donner la liste des employ´es 
ayant une commission, class´ee par commission d´ecroissante,*/
SELECT NOM, COMM
FROM emp
WHERE COMM IS NOT NULL AND COMM != 0
ORDER BY comm DESC;
/*4. Donner le nom des personnes embauchees depuis janvier 1991,
*/
SELECT NOM 
FROM emp
WHERE EMBAUCHE > '01-jan-91';

/*5. Donner pour chaque employee son nom et son lieu de travail,*/
SELECT emp.NOM, LIEU
FROM emp, dept 
WHERE emp.n_dept = dept.n_dept;

/*6. Donner pour chaque employ´e le nom de son sup´erieur hi´erarchique,*/
CREATE TABLE NOM_employee AS SELECT NOM, NUM, N_SUP
FROM emp;

CREATE TABLE NOM_SUP AS SELECT NOM as NOM_S, NUM AS NUM_S FROM emp;

SELECT NOM, NOM_S 
FROM NOM_employee NATURAL JOIN NOM_SUP 
WHERE N_SUP = NUM_S;


/*7. Quels sont les employ´es ayant la mˆeme fonction que ”CODD” ?*/
SELECT NOM
FROM emp
WHERE FONCTION=(SELECT FONCTION FROM emp WHERE NOM='CODD');

/*8. Quels sont les employ´es gagnant plus que tous 
les employ´es du d´epartement 30 ?*/
SELECT NOM 
FROM emp
WHERE SALAIRE > (SELECT SALAIRE FROM emp WHERE N_DEPT = 30);

/*9. Quels sont les employ´es ne travaillant pas dans le mˆeme d´epartement 
que leur sup´erieur hi´erarchique ? */

CREATE TABLE NOM_employe_dept AS SELECT NOM, NUM, N_SUP, N_DEPT
FROM emp;

CREATE TABLE NOM_SUP_dept AS 
SELECT NOM as NOM_S, NUM AS NUM_S, N_DEPT AS N_DEPT_S FROM emp;
/*creation table superieur*/
create table superieur as select * from  nom_employe_dept natural join nom_sup_dept where n_sup = num_s;
select nom from superieur where n_dept != n_dept_s;


/*10. Quels sont les employ´es travaillant dans un d´epartement 
qui a proc´ed´e `a des embauches depuis le d´ebut de l’ann´ee 98,*/

SELECT NOM 
FROM emp
WHERE N_DEPT = (SELECT N_DEPT FROM emp WHERE EMBAUCHE > '01-jan-98');

/*11. Donner le nom, la fonction et le salaire de l’employ´e (ou des employ´es) 
ayant le salaire le plus elev´e,*/
SELECT NOM, FONCTION, SALAIRE
FROM emp
WHERE SALAIRE = (SELECT max(SALAIRE) FROM emp);

/*12. Donner le total des salaires, le nombre de salari´es, 
ainsi que le salaire minimal, moyen et maximal pour l’ensemble des 
salari´es de chaque d´epartement */
SELECT SUM(salaire), COUNT(NOM), MAX(SALAIRE), AVG(salaire), MIN(SALAIRE), N_DEPT
FROM emp
GROUP BY N_DEPT;

/*13. Donner le ou les d´epartements ayant le plus d’employ´es,*/
SELECT N_DEPT,COUNT(*)
FROM emp
GROUP BY N_DEPT
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM emp
                   GROUP BY N_DEPT) ;


/*14. Donner les d´epartements qui ne poss`edent pas d’employ´es exer¸cant
 la fonction d’ing´enieur,*/
 SELECT N_DEPT
 FROM emp
 WHERE FONCTION != 'ingenieur'
 GROUP BY N_DEPT;




/*15. Donner les d´epartements poss´edant des employ´es exer¸cant l’ensemble des fonctions r´ef´erenc´ees
au sein de la soci´et´e.
*/
