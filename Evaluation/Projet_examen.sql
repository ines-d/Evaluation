# 3-Créer une base de données « RNE »
create database RNE;
# 4-Y créer les tables destinées à accueillir les six fichiers 
use RNE;

create table elus (
	code_insee varchar(6),
    mode_de_scrutin varchar(14),
    numliste varchar(2),
    code_nuance_de_la_liste varchar(5),
    numero_du_candidat_dans_la_liste varchar(3),
    tour varchar(2),
    nom varchar(35),
    prenom varchar(40),
    sexe varchar(2),
    Date_de_naissance datetime,
    code_profession varchar(3),
    libelle_profession varchar(100),
    nationalite varchar(1));
    
select * from elus limit 10;
    
create table population (
	code_insee varchar(5),
    Population_legale int(7)
    );
    
create table nuancier (
	code varchar(5),
    libelle varchar(50),
    ordre varchar(2),
    definition varchar(200));
    
create table villes (
	id varchar(5),
    departement_code varchar(3),
    code_insee varchar(6),
    zip_code varchar(5),
    name varchar(50));


create table categorie (
	Code int(6),
    Nb_demplois int(6),
	Artisanse_commerçantse_chefs_dentreprise int(6),
    Cadres_et_professions_intellectuelles_superieures int(6),
	Professions_intermedaires int(6),
    Employes int(6),
    Ouvriers int(6));
    
select * from elus limit 10;

create table departements (
	id varchar (3),
    region_code varchar(3),
    code varchar(3),
	name varchar(100),
    nom_normalise varchar(100));
    
# 5-Ecrire la requête qui va créer un nouvelle utilisateur MySQL « RNE_user » avec pour
#mot de passe « RNE_pasword » et lui accorder tous les droits sur la base RNE. Utiliser
#cette utilisateur pour la suite.
	
SHOW variables like 'validate_password%'; # pour qu'il accepte le mot de passe 
set global validate_password_policy=LOW; # avant medium 
set global validate_password_length=6; # avant c'était 8
set global validate_password_number_count=0; # avant c'etait 1

create user 'RNE_user'@'localhost' identified by 'RNE_password';
grant all privileges on *.* to 'RNE_user'@'localhost';
flush privileges;


# 6-Les fichiers ayant la même structure, écrire une fonction chargement() pour alimenter
#la base « RNE » avec ces fichiers. Cette fonction utilisera les fonction r_names et
#parses_dates(). Elle aura pour entrer la chaîne de caractère contenant le nom des
#colonnes, le chemin d’accès vers le fichier et le nom de la table dans la quel écrire.
#Alimenter la base avec les fichiers.

select * from villes limit 100;
select * from categorie limit 100;
select * from elus limit 100;
select * from nuancier limit 100;
select * from departements limit 100;
select * from population limit 100;
select * from elus where code_profession=10;
select * from categorie where Nb_demplois=10;

# 8- Quel sont les parties politiques qui dans leur libellé comporte le terme « Union »

select libelle from nuancier 
where libelle like '%Union%';

# 9- Quels élus du département du « var » sont nais entre le mois de juin et aout ?

select nom, prenom, Date_de_naissance from elus
inner join villes on elus.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code
where departements.name ='var' and month(Date_de_naissance) between 06 and 08;

#10. Quel est l’âge moyen des élus homme au 01/01/2014 ? Celui des élus femme ?

select sexe, avg(timestampdiff(year,Date_de_naissance, '2014-01-01')) as age_moyen from elus
group by sexe;

#11. Afficher la population totale du département des « Bouches-du-Rhône »

select sum(Population_legale) as total , departements.name 
from population
inner join villes on population.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code
where departements.name = 'Bouches-du-Rhône'
group by  departements.name;

#12. Quel sont les 10 départements comptant le plus d’ouvriers.

create index ind_code_insee on elus(code_insee);


select departements.name, Ouvriers
from categorie 
inner join villes on categorie.Code=villes.code_insee
inner join departements on villes.departement_code=departements.code
group by departements.name, Ouvriers
order by Ouvriers desc limit 10;


#13. Afficher le nombre d’élus regrouper par nuance politique et par département.

create index index_libelle
on nuancier(code,libelle);

select count(nom) as nombre_elus
, nuancier.libelle 
from nuancier
inner join elus on nuancier.code=elus.code_nuance_de_la_liste
inner join villes on elus.code_insee = villes.code_insee
inner join departements on villes.departement_code=departements.code
group by libelle, departements.name;


#14. Afficher le nombre d’élus regroupé par nuance politique et par villes pour le département des « Bouches-du-Rhône ».

select count(nom) as  nbre_elus, villes.name  from nuancier 
inner join elus on nuancier.code=elus.code_nuance_de_la_liste
inner join villes on elus.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code
where departements.code='13'
group by villes.name;


#15. Afficher les 10 départements dans lesquelles il y a le plus d’élus femme, ainsi que le nombre d’élus femme correspondant.

select count(elus.nom) as nbre_elus_femme, departements.name from elus
inner join villes on elus.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code 
where sexe="F"
group by departements.name
order by nbre_elus_femme desc limit 10;

#16. Donner l’âge moyen des élus par départements au 01/01/2014. Les afficher par ordre décroissant. 

select avg(timestampdiff(year,'2014-01-01', Date_de_naissance)) as age_moyen, nom_normalise from elus 
inner join villes on elus.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code
group by nom_normalise
order by age_moyen desc
limit 10;
 
#17. Afficher les départements où l’âge moyen des élus est strictement inférieur à 54 ans.


select avg(timestampdiff(year,'2014-01-01', Date_de_naissance)) as age_moyen, nom_normalise from elus 
inner join villes on elus.code_insee=villes.code_insee
inner join departements on villes.departement_code=departements.code
group by nom_normalise
having age_moyen < 54;



    
	
	
    


