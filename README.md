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

SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON -
HEAD "<TITLE>Department Report</TITLE> -
<STYLE type='text/css'> -
<!-- BODY {background: #FFFFC6} --> -
</STYLE>" –
 BODY "TEXT='#FF00Ff'" –
 TABLE "WIDTH='90%' BORDER='5'"
SPOOL emploi.html
SELECT DISTINCT C.codeCours, T.jourCoursDate,T. TRANCHE,C.VOLUMEH FROM Cours C
JOIN Typehoraire T
ON C.codeCours= T.crsCodeCours
JOIN Jourcours J
ON J.dateJourCours=T.jourCoursDate
JOIN Coursdeclasse cls
ON T.crsCodeCours=cls.crsCodeCours
JOIN Classe Cl
ON cl.specialiteNomSpec=cls.classSpecialiteNomspec
 WHERE T.jourCoursDate
 IN ('lundi','mardi','mercredi','jeudi','vendredi','samedi') AND cls.classNiveauidNiveau=001 ;
SPOOL OFF
