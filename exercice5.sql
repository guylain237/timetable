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
