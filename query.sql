SET search_path = vetDB;

-------------------------------------A VERFIFIER--------------------------------------------------------------
--1. Lister le numéro et nom des cliniques, leur adresse et leur gestionnaire, ordonnés par le numéro de clinique 
SELECT numClinique,rue,ville,province,codePostal, gestionnaire
FROM VETDB.Clinique
ORDER BY numClinique;
-------------------------------------A VERFIFIER--------------------------------------------------------------

--2. Lister les noms des animaux sans doublons dans toutes les cliniques 
SELECT DISTINCT nom
FROM VETDB.ANIMAL;

----------------------------A VERFIFIER---si le proprietaire a pas d'animal ? est ce que ca se peut?---------
--3. Lister les numéros et noms des propriétaires d’animaux ainsi que les détails de leurs animaux 
-- dans une clinique donnée (à vous de la choisir)
--Requete 3 par rapport a la Clinique C111
Select p.numProprietaire,prenom, nomFamille, numAnimal, nom, type, description,dateNaissance, dateInscription, estVivant 
FROM VETDB.Animal a NATURAL RIGHT OUTER JOIN VETDB.Proprietaire p 
WHERE p.numClinique='C111';
-------------------------------------A VERFIFIER--------------------------------------------------------------

--4. Lister l’ensemble des examens d’un animal donné
--Requete 4 pour animal A1 a la clinique C111
SELECT *
FROM VETDB.Examen
WHERE numAnimal='A1' AND numClinique='C111';

--Lister le détail des traitements d’un animal suite à un examen donné
--Requete 5 pour animal A1 a la clinique C111
SELECT *
FROM VETDB.TraitementPersonalise
WHERE numAnimal='A1' AND numClinique='C111' AND numExamen='EX1';

--6. Lister le salaire total des employés par clinique ordonné par numéro de clinique 
Select numClinique, SUM(salaireAnnuel)
FROM VETDB.Employe
GROUP BY numClinique
ORDER BY numclinique;

------------------------------------Ca ne fait pas apparaitre a pour une clinique donnee--------------------------------------------------------------
--7. Lister le nombre total d’animaux d’un type donné (chat) dans chaque
--clinique 
SELECT numClinique, COUNT(*) AS totalChat
FROM VETDB.ANIMAL
WHERE type='Chat'
GROUP BY numclinique
ORDER BY numClinique;
-------------------------------------A VERFIFIER--------------------------------------------------------------

--8. Lister le coût minimum, maximum et moyen des traitements
SELECT MIN(cout) AS coutMinimum, MAX(cout) AS coutMaximun, AVG(cout) AS moyenneTraitement
FROM VETDB.TRAITEMENT

--9. Quels sont les noms des employés de plus de 50 ans ordonnés par nom ? 
Select nomFamille, prenom
FROM VETDB.Employe
WHERE (dateNaissance<(current_date-interval '50 year'))
ORDER BY nomFamille

--10. Quels sont les propriétaires dont le nom contient « blay » ? 
Select *
FROM VETDB.Proprietaire
WHERE nomFamille LIKE '%blay%'

--11. Supprimez le vétérinaire « Jean Tremblay »
DELETE FROM VETDB.Employe
WHERE fonction='Veterinaire' AND prenom='Jean' AND nomFamille='Tremblay';

--12. Lister les détails des propriétaires qui ont un chat et un chien
(Select p.*
FROM VETDB.Proprietaire p NATURAL JOIN Animal a
Where type='Chien')
INTERSECT
(Select p.*
FROM VETDB.Proprietaire p NATURAL JOIN Animal a
Where type='Chat')

--13. Lister les détails des propriétaires qui ont un chat ou un chien 
(Select p.*
FROM VETDB.Proprietaire p NATURAL JOIN Animal a
Where type='Chien')
UNION
(Select p.*
FROM VETDB.Proprietaire p NATURAL JOIN Animal a
Where type='Chat')

--14. Lister les détails des propriétaires qui ont un chat mais pas de chien vacciné contre la grippe
--(la condition vacciné contre la grippe ne s’applique qu’au chien) 
--ici le traitement contre la grippe est 'T114'
(Select p.*
FROM VETDB.Proprietaire p NATURAL JOIN Animal a
Where type='Chat')
EXCEPT
(Select p.*
FROM VETDB.Proprietaire p, Animal a, TraitementPersonalise t
Where type='Chien' AND p.numProprietaire =  a.numProprietaire
AND p.numClinique = a.numClinique AND t.numAnimal=a.numAnimal AND
t.numClinique=a.NumClinique and numTraitement='T114')

-- 15. Lister tous les animaux d’une clinique donnée avec leurs traitements s’ils existent. Dans le cas
--contraire, affichez null. 
Select *
FROM Animal a NATURAL LEFT OUTER JOIN TraitementPersonalise t
WHERE numClinique='C111'


