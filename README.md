// 3) creation de l object vue

CREATE VIEW EmploiDeTemps AS
    SELECT DISTINCT T.jourCoursDate, C.codeCours
    FROM Cours C
        JOIN Typehoraire T
        ON C.codeCours= T.crsCodeCours
        JOIN Jourcours J
        ON J.dateJourCours=T.jourCoursDate
        JOIN Coursdeclasse cls
        ON  T.crsCodeCours=cls.crsCodeCours
        JOIN Classe Cl
        ON cl.specialiteNomSpec=cls.classSpecialiteNomspec
    ORDER BY T.jourCoursDate;
    
  





//// 4 )sript pour enregistrer le mot de passe
alter table etudiant add password varchar(50);
update etudiant set password = ora_hash(matricule) where matricule = valeur;

alter table enseignants add password varchar(50);
update enseignants set password = ora_hash(matricule) where matricule = valeur;





// 5 )  ecrire un sript  pour l emploi de temps

SET MARKUP HTML
ON SPOOL ON PREFORMAT OFF ENTMAP ON -
HEAD "<TITLE>emploi de temps</TITLE> -
<STYLE type='text/css'> -
<!-- BODY {background: #FFFFFF} --> -
</STYLE>" -
BODY "TEXT='#000000'" -
TABLE "WIDTH='90%' BORDER='5'"

COLUMN jourCoursDate HEADING 'JOURS'
COLUMN codeCours HEADING 'COURS' ENTMAP OFF

SPOOL TimeTable.html

SELECT DISTINCT T.jourCoursDate, C.codeCours
FROM Cours C
    JOIN Typehoraire T
        ON C.codeCours= T.crsCodeCours
    JOIN Jourcours J
        ON J.dateJourCours=T.jourCoursDate
    JOIN Coursdeclasse cls
        ON  T.crsCodeCours=cls.crsCodeCours
    JOIN Classe Cl
        ON cl.specialiteNomSpec=cls.classSpecialiteNomspec
    NATURAL JOIN ETUDIANT e
WHERE T.jourCoursDate IN ('lundi','mardi','mercredi','jeudi','vendredi','samedi')
    AND e.MATRICULE = (SELECT MATRICULE FROM Etudiant WHERE MATRICULE ='&matricule')
    AND e.password = (SELECT MATRICULE FROM Etudiant WHERE password = ('000'||' &password '||INSTR('&&', '0', 1, 4||' IUC'||)))

SPOOL OFF
