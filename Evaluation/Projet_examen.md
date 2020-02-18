```python
# 1 - Ecrire une fonction python r_names() qui admet pour entrer une de ces chaînes de caractères et qui retourne une liste de nom de colonnes.
# Les espaces, les « ‘ » et les « . » doivent être remplacé par des « _ ».
#Les « é » et « è » doivent être remplacé par des « e ».
#Les « , », « ) » et « ( » doivent être supprimées.

from re import sub

elus ='																																		'
elus+='code (insee)	mode de scrutin	numliste	code (nuance de la liste)	numéro du candidat dans la liste	tour	nom	prénom	sexe	Date de naissance	code (profession)	libellé profession	nationalité'

def r_names(elus):
    x=elus.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,)]','',x1)
    x3=x2.split() # le x3 est le resultat des noms de colonnes en liste
    #x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(elus))

x3=r_names(elus)

def parse_dates(x3):
    for i in range (0, len(x3)):
        if x3[i][0:4]=='Date':
            return x3[i]

print(parse_dates(x3))
```

    ['code_insee', 'mode_de_scrutin', 'numliste', 'code_nuance_de_la_liste', 'numero_du_candidat_dans_la_liste', 'tour', 'nom', 'prenom', 'sexe', 'Date_de_naissance', 'code_profession', 'libelle_profession', 'nationalite']
    Date_de_naissance



```python
population='	'
population+='Code insée	Population légale'
from re import sub

def r_names(population):
    x=population.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,)]','',x1)
    x3=x2.split() # le x3 est le resultat des noms de colonnes en liste
    #x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(population))

categorie='								'
categorie+='Code	Nb d\'emplois	Artisans, commerçants, chefs d\'entreprise	Cadres et professions intellectuelles supérieures	Professions intermédaires	Employés	Ouvriers	'

#from re import sub

def r_names(categorie):
    x=categorie.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,\')]','',x1)
    x3=x2.split()# le x3 est le resultat des noms de colonnes en liste
    x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(categorie))

departements='			'
departements+='id	region_code	code	name	nom normalisé'

def r_names(departements):
    x=departements.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,\')]','',x1)
    x3=x2.split()# le x3 est le resultat des noms de colonnes en liste
    x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(departements))

population='	'
population+='Code insée	Population légale'

def r_names(population):
    x=population.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,\')]','',x1)
    x3=x2.split()# le x3 est le resultat des noms de colonnes en liste
    x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(population))

nuanceier='		'
nuancier='code	libellé	ordre	définition_'

def r_names(nuancier):
    x=nuancier.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,\')]','',x1)
    x3=x2.split()# le x3 est le resultat des noms de colonnes en liste
    x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(nuancier))

villes='			'
villes+='id	departement_code	code_insee	zip_code	name'

def r_names(villes):
    x=villes.replace(' ','_')
    x1=sub('[é,è]','e',x)
    x2=sub('[(,\')]','',x1)
    x3=x2.split()# le x3 est le resultat des noms de colonnes en liste
    x4='\n'.join(x3) # j'ai fait un join pour avoir un resultat propre
    return x3
print(r_names(villes))


```

    ['Code_insee', 'Population_legale']
    ['Code', 'Nb_demplois', 'Artisanse_commerçantse_chefs_dentreprise', 'Cadres_et_professions_intellectuelles_superieures', 'Professions_intermedaires', 'Employes', 'Ouvriers']
    ['id', 'region_code', 'code', 'name', 'nom_normalise']
    ['Code_insee', 'Population_legale']
    ['code', 'libelle', 'ordre', 'definition_']
    ['id', 'departement_code', 'code_insee', 'zip_code', 'name']



```python
import pandas as pd
from sqlalchemy import create_engine 
#import time
#import pymysql

engine = create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

def chargement(population):
    name_papulation=['Code_insee', 'Population_legale']
    df=pd.read_excel('/home/ines/Documents/Projet_examen/population2017.xlsx', skiprows= 0, header=1, set='\t', names=r_names(population))
    df.to_sql('population', con =engine, if_exists='append', index= False)
    return df
print(chargement(population))
```

          Code_insee  Population_legale
    0          01001                776
    1          01002                248
    2          01004              14035
    3          01005               1689
    4          01006                111
    ...          ...                ...
    34965      97613                  0
    34966      97614                  0
    34967      97615                  0
    34968      97616                  0
    34969      97617                  0
    
    [34970 rows x 2 columns]



```python
#elus
import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

link = '/home/ines/Documents/Projet_examen/elus_mun2014.xlsx'

df = pd.read_excel(link, skiprows=0, header=1, names=r_names(elus))
print(df)

df.to_sql('elus', con = engine, if_exists='replace', index = False)
```

           code_insee mode_de_scrutin  numliste code_nuance_de_la_liste  \
    0            1001     Majoritaire       NaN                     NaN   
    1            1001     Majoritaire       NaN                     NaN   
    2            1001     Majoritaire       NaN                     NaN   
    3            1001     Majoritaire       NaN                     NaN   
    4            1001     Majoritaire       NaN                     NaN   
    ...           ...             ...       ...                     ...   
    525141        NaN           Liste       4.0                    LDIV   
    525142        NaN           Liste       2.0                    LDIV   
    525143        NaN           Liste       1.0                    LDIV   
    525144        NaN           Liste       4.0                    LDIV   
    525145        NaN           Liste       2.0                    LDIV   
    
            numero_du_candidat_dans_la_liste  tour             nom         prenom  \
    0                                    NaN     1           TEPPE           Noël   
    1                                    NaN     1          BERAUD          Zélie   
    2                                    NaN     1         MARGUIN      Jean Paul   
    3                                    NaN     1       DESVAQUET         Nadine   
    4                                    NaN     1  EVALET-TAPONAT           Line   
    ...                                  ...   ...             ...            ...   
    525141                               1.0     2         DIAINON          André   
    525142                              11.0     2         DEBAOUE        Georges   
    525143                               1.0     2          CHAGUI          Fredy   
    525144                               2.0     2         MEREATU  Suzanne Poawé   
    525145                               4.0     2    THAVOAVIANON          Sonia   
    
           sexe Date_de_naissance  code_profession  \
    0         M        1942-06-17               61   
    1         F        1980-03-26               10   
    2         M        1950-06-24               58   
    3         F        1961-08-22               14   
    4         F        1967-07-22               50   
    ...     ...               ...              ...   
    525141    M        1962-01-28               15   
    525142    M        1980-09-14               20   
    525143    M        1971-10-13                6   
    525144    F        1967-06-29                5   
    525145    F        1981-03-01               14   
    
                            libelle_profession nationalite  
    0                   Retraité salarié privé           F  
    1                                  Artisan           F  
    2                        Retraité agricole           F  
    3            Agent technique et technicien           F  
    4       Cadre sup. (entreprises publiques)           F  
    ...                                    ...         ...  
    525141                        Contremaitre           F  
    525142             Employé (secteur privé)           F  
    525143          Administrateur de sociétés           F  
    525144          Industriel-Chef entreprise           F  
    525145       Agent technique et technicien           F  
    
    [525146 rows x 13 columns]



```python
#categorie

import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

link = '/home/ines/Documents/Projet_examen/categorie_professionelle.xlsx'

df = pd.read_excel(link, skiprows=0, header=1, names=r_names(categorie))
print(df)

df.to_sql('categorie', con = engine, if_exists='replace', index = False)
```

            Code  Nb_demplois  Artisanse_commerçantse_chefs_dentreprise  \
    0      01001           92                                        20   
    1      01002           14                                         0   
    2      01004         7504                                       392   
    3      01005          301                                        51   
    4      01006            6                                         0   
    ...      ...          ...                                       ...   
    34965  97613            0                                         0   
    34966  97614            0                                         0   
    34967  97615            0                                         0   
    34968  97616            0                                         0   
    34969  97617            0                                         0   
    
           Cadres_et_professions_intellectuelles_superieures  \
    0                                                      5   
    1                                                      0   
    2                                                    882   
    3                                                     26   
    4                                                      0   
    ...                                                  ...   
    34965                                                  0   
    34966                                                  0   
    34967                                                  0   
    34968                                                  0   
    34969                                                  0   
    
           Professions_intermedaires  Employes  Ouvriers  
    0                             23        15        25  
    1                              5         5         5  
    2                           2192      2277      1681  
    3                             85        77        39  
    4                              0         0         0  
    ...                          ...       ...       ...  
    34965                          0         0         0  
    34966                          0         0         0  
    34967                          0         0         0  
    34968                          0         0         0  
    34969                          0         0         0  
    
    [34970 rows x 7 columns]



```python
# ville
import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

link = '/home/ines/Documents/Projet_examen/cities.xlsx'

df = pd.read_excel(link, skiprows=0, header=1, names=r_names(villes))
print(df)

df.to_sql('villes', con = engine, if_exists='replace', index = False)
```

              id departement_code code_insee  zip_code                     name
    0          1                1       1001    1400.0  L'Abergement-Clémenciat
    1          2                1       1002    1640.0    L'Abergement-de-Varey
    2          3                1       1004    1500.0        Ambérieu-en-Bugey
    3          4                1       1005    1330.0      Ambérieux-en-Dombes
    4          5                1       1006    1300.0                  Ambléon
    ...      ...              ...        ...       ...                      ...
    35848  35849              988        NaN   98831.0                    Touho
    35849  35850              988        NaN   98833.0                      Voh
    35850  35851              988        NaN   98834.0                     Yaté
    35851  35852              988        NaN   98818.0                  Kouaoua
    35852  35853              989        NaN       NaN        Île de Clipperton
    
    [35853 rows x 5 columns]



```python
#nuancier

import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

link = '/home/ines/Documents/Projet_examen/codes_nuances.xlsx'

df = pd.read_excel(link, skiprows=0, header=1, names=r_names(nuancier))
print(df)

df.to_sql('nuancier', con = engine, if_exists='replace', index = False)
```

        code                                  libelle  ordre  \
    0   LEXG                     Liste Extrême gauche      1   
    1    LFG                    Liste Front de Gauche      2   
    2    LPG                 Liste du Parti de Gauche      3   
    3   LCOM       Liste du Parti communiste français      4   
    4   LSOC                         Liste Socialiste      5   
    5    LUG                 Liste Union de la Gauche      6   
    6   LDVG                      Liste Divers gauche      7   
    7   LVEC          Liste Europe-Ecologie-Les Verts      8   
    8   LDIV                             Liste Divers      9   
    9   LMDM                              Liste Modem     10   
    10   LUC                    Liste Union du Centre     11   
    11  LUDI   Liste Union Démocrates et Indépendants     12   
    12  LUMP  Liste Union pour un Mouvement Populaire     13   
    13   LUD                 Liste Union de la Droite     14   
    14  LDVD                      Liste Divers droite     15   
    15   LFN                     Liste Front National     16   
    16  LEXD                     Liste Extrême droite     17   
    
                                              definition_  
    0   Liste d'extrême-gauche : Parti Anarchiste Révo...  
    1   Listes investies par le Parti de Gauche et le ...  
    2                            Liste du Parti de Gauche  
    3                  Liste du Parti Communiste Français  
    4                           Liste du Parti Socialiste  
    5   Liste d'Union des partis de gauche : Pour être...  
    6   Liste Parti Radical de Gauche, Mouvement Répub...  
    7                     Liste Europe-Ecologie-Les Verts  
    8   Liste Chasse Pêche Nature Tradition, Parti bla...  
    9                        Liste du Mouvement Démocrate  
    10  Liste d'union du centre : Pour être nuancée LU...  
    11  Parti Radical, Nouveau-Centre, Parti Libéral D...  
    12      Liste de l'Union pour un Mouvement Populaire.  
    13  Liste d'Union des partis de Droite : Pour être...  
    14  Liste Alliance Royale, Parti Chrétien Démocrat...  
    15                            Liste du Front National  
    16  Listes Mouvement National Républicain, Nissa R...  



```python
# departements

import pandas as pd
import sqlalchemy

engine = sqlalchemy.create_engine("mysql+pymysql://RNE_user:RNE_password@localhost/RNE")

link = '/home/ines/Documents/Projet_examen/departments.xlsx'

df = pd.read_excel(link, skiprows=0, header=1, names=r_names(departements))
print(df)

df.to_sql('departements', con = engine, if_exists='replace', index = False)
```

          id region_code code                                         name  \
    0      1          84    1                                          Ain   
    1      2          32    2                                        Aisne   
    2      3          84    3                                       Allier   
    3      4          93    4                      Alpes-de-Haute-Provence   
    4      5          93    5                                 Hautes-Alpes   
    ..   ...         ...  ...                                          ...   
    104  105         COM  984  Terres australes et antarctiques françaises   
    105  106         COM  986                             Wallis et Futuna   
    106  107         COM  987                          Polynésie française   
    107  108         COM  988                           Nouvelle-Calédonie   
    108  109         COM  989                            Île de Clipperton   
    
                                       nom_normalise  
    0                                            ain  
    1                                          aisne  
    2                                         allier  
    3                        alpes de haute provence  
    4                                   hautes alpes  
    ..                                           ...  
    104  terres australes et antarctiques francaises  
    105                             wallis et futuna  
    106                          polynesie francaise  
    107                           nouvelle caledonie  
    108                            ile de clipperton  
    
    [109 rows x 5 columns]



```python
from re import sub

f=open('/home/ines/Téléchargements/Projet_examen/Libellé des colonnes.txt','r')
s=f.read()
a=s.split()
x=[]
def r_name (s):
    N1=sub('[\#].,','_',s)
    #x.append(N1)
    #N2=sub('é,è','e',s)
    #x.append(N2)
    #N3=sub('(,)','',s)
    return N1
print (r_name(s))
```

    # Elus municipaux :																																		
    code (insee)	mode de scrutin	numliste	code (nuance de la liste)	numéro du candidat dans la liste	tour	nom	prénom	sexe	Date de naissance	code (profession)	libellé profession	nationalité
    
    																						
    # Nuanceier plolitique :		
    code	libellé	ordre	définition_
    
    
    # Liste des villes :			
    id	departement_code	code_insee	zip_code	name
    
    # Référentiel géographique : France par commune								
    Code	Nb d'emplois	Artisans, commerçants, chefs d'entreprise	Cadres et professions intellectuelles supérieures	Professions intermédaires	Employés	Ouvriers	
    
    
    # Population France par commune	
    Code insée	Population légale
    
    # Liste départements :			
    id	region_code	code	name	nom normalisé
    

