## 🎲 **Bienvenue dans Le Fou Takuzu !**

Un projet qui consiste à développer une application Shiny avec un package R vous permettant de jouer au Takuzu dans une interface interactive.  
Le principe ? Remplir une grille de 0 et de 1 en respectant des règles de logique strictes. 


### 📜 Règles du jeu  

Chaque ligne et chaque colonne doivent contenir autant de 0 que de 1.  
Pas plus de deux chiffres identiques consécutifs.  
Deux lignes ou deux colonnes identiques sont interdites.  

---

### 💡 Fonctionnalités  

**Génération automatique** de grilles de Takuzu (8x8).  
**Vérification de solution** pour voir si la grille est correcte.  
**Mode interactif** avec une interface Shiny.  
**Résolution automatique** pour ceux qui veulent tricher un peu. 😜  
**Bibliothèque R** complète pour manipuler les grilles.  

---

### 🎮 Aperçu de l’application  

Voici à quoi cela ressemble en action :  

(ici ajouter une démo ou un screen de l'app)  

---

### 📦 Installation  

1️⃣ **Prérequis** :

Assurez-vous d’avoir R et les packages suivants installés :  
```r
install.packages(c("shiny", "bslib", "shinyjs"))
```

2️⃣**Cloner le projet ** :

```sh
git clone https://github.com/mgermain12/Takuzu.git
cd Takuzu
```

3️⃣ **Lancer l’application**:
```r
library(shiny)
library(shinyjs)
library(bslib)

source("niveau.R")
source("verification.R")
source("grille.R")

runApp("code.R")
```

---

### 📝 Informations  

Auteurs : Coralie ROMANI DE VINCI, Marine GERMAIN
                   
Contact : coralie.romani-de-vinci@etu.umontpellier.fr, marine.germain@etu.umontpellier.fr

---

### 🚀 **Prêt à relever le défi ? Clonez, jouez et amusez-vous !** 🎉  


