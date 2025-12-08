# Système de Réservation d'Hôtel

Une application web complète de gestion hôtelière développée avec Java EE, JSP, et Hibernate, permettant aux clients de réserver des chambres et aux administrateurs de gérer l'établissement.Cette application est destiné au restaurant qui veulent une plateforme de reservation en ligne pour leur client.

## Description

Le projet est un système de réservation d'hôtel qui offre deux interfaces distinctes :
- **Interface Client** : Permet de rechercher, consulter et réserver des chambres
- **Interface Administration** : Permet de gérer les chambres, clients et réservations

## Architecture

### Stack Technique
- **Backend** : Java EE avec Servlets et JSP
- **Framework ORM** : Hibernate 6.4.4
- **Base de données** : MySQL 8.0
- **Frontend** : JSP avec Bootstrap 5 et Bootstrap Icons
- **Build Tool** : Maven
- **Serveur** : Tomcat (compatible Jakarta EE 10)

### Architecture en Couches
```
┌─────────────────────────────────────┐
│           Présentation (JSP)        │
├─────────────────────────────────────┤
│         Contrôleurs (Servlets)      │
├─────────────────────────────────────┤
│           Modèle (JPA Entities)     │
├─────────────────────────────────────┤
│            DAO (Hibernate)          │
├─────────────────────────────────────┤
│         Base de données (MySQL)     │
└─────────────────────────────────────┘
```
## Ecrans(images)
- **Ecran client** : 
<img width="960" height="442" alt="Capture d&#39;écran 2025-12-08 002013" src="https://github.com/user-attachments/assets/e0a26551-430b-4803-8a8f-091c5811ebe7" />
<img width="960" height="436" alt="Capture d&#39;écran 2025-12-08 002333" src="https://github.com/user-attachments/assets/41264ced-742c-4245-bb7c-577d687de19a" />
<img width="960" height="439" alt="Capture d&#39;écran 2025-12-08 000037" src="https://github.com/user-attachments/assets/3d1399ef-2283-4949-a641-f2775d03104f" />
<img width="960" height="448" alt="Capture d&#39;écran 2025-12-07 235727" src="https://github.com/user-attachments/assets/bc11ac01-cfb8-404d-a854-38b15bb29da0" />
- **Ecran Admin**
<img width="959" height="446" alt="Capture d&#39;écran 2025-12-08 000451" src="https://github.com/user-attachments/assets/6ca9021c-590b-44d8-bae1-35d7997f4dbb" />
<img width="959" height="443" alt="Capture d&#39;écran 2025-12-08 000302" src="https://github.com/user-attachments/assets/335ed13c-3d1b-47a4-8b9f-081472de5a25" />
<img width="960" height="447" alt="Capture d&#39;écran 2025-12-08 000333" src="https://github.com/user-attachments/assets/618b35f4-2a64-49f6-88e0-d1c332511e3e" />

## Structure du Projet

```
src/
├── main/
│   ├── java/com/gestionhotel/
│   │   ├── dao/                    # Accès aux données
│   │   │   ├── ChambreDao.java
│   │   │   ├── ReservationDao.java
│   │   │   ├── UtilisateurDao.java
│   │   │   └── JpaUtil.java
│   │   ├── model/                  # Entités JPA
│   │   │   ├── Chambre.java
│   │   │   ├── Reservation.java
│   │   │   └── Utilisateur.java
│   │   └── servlets/               # Contrôleurs
│   │       ├── Admin*Servlet.java  # Servlets admin
│   │       ├── *Servlet.java       # Servlets clients
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── layout/             # Fragments JSP partagés
│       │   │   ├── client_header.jspf
│       │   │   └── client_footer.jspf
│       │   └── web.xml
│       ├── admin/                  # Pages admin
│       ├── authentication/         # Authentification
│       ├── rooms/                  # Consultation chambres
│       ├── reservation/            # Gestion réservations
│       └── index.jsp               # Page d'accueil
└── resources/
    └── META-INF/
        └── persistence.xml        # Configuration Hibernate
```

##  Fonctionnalités

### Interface Client
- **Accueil** : Page d'accueil avec présentation de l'hôtel
- **Recherche de chambres** : Filtrage par type, capacité et dates
- **Détails chambre** : Affichage complet avec photos et réservation
- **Réservation** : Formulaire avec création automatique de compte client
- **Authentification** : Login/Logout avec gestion de session
- **Profil client** : Consultation et modification des informations
- **Mes réservations** : Historique et annulation des réservations

### Interface Administration
- **Tableau de bord** : Vue d'ensemble des statistiques
- **Gestion des chambres** : CRUD complet avec photos
- **Gestion des clients** : Consultation et modification
- **Gestion des réservations** : Validation, annulation, suivi
- **Profil administrateur** : Gestion du compte admin

## Configuration

### Base de données
```sql
-- Configuration MySQL
Hôte : localhost:3306
Base : gestion_hotel
-- 
Utilisateur : hotel_user 
Mot de passe : Hotel@2025
```
### Commandes pour créer la base et les tables

- 1) Créer la base de données
CREATE DATABASE IF NOT EXISTS gestion_hotel
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE gestion_hotel;

- 2) Créer un utilisateur MySQL dédié
CREATE USER IF NOT EXISTS 'hotel_user'@'localhost'
  IDENTIFIED BY 'Hotel@2025';
GRANT ALL PRIVILEGES ON gestion_hotel.* TO 'hotel_user'@'localhost';
FLUSH PRIVILEGES;

- NB : Si vous changez l'utilisateur ou le mot de passe, mettez à jour la configuration dans `src/main/resources/META-INF/persistence.xml`.

- 3) Table utilisateur
DROP TABLE IF EXISTS utilisateur;
CREATE TABLE utilisateur (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(100)      NOT NULL,
    email         VARCHAR(150)      NOT NULL UNIQUE,
    telephone     VARCHAR(30),
    mot_de_passe  VARCHAR(255)      NOT NULL,
    role          VARCHAR(20)       NOT NULL  -- 'ADMIN' ou 'CLIENT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

- 4) Table chambre
DROP TABLE IF EXISTS chambre;
CREATE TABLE chambre (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    numero        VARCHAR(20)       NOT NULL,
    type          VARCHAR(20)       NOT NULL, -- SIMPLE, DOUBLE, SUITE...
    prix_nuit     DECIMAL(10,2)     NOT NULL,
    capacite      INT               NOT NULL,
    description   TEXT,
    statut        VARCHAR(20)       NOT NULL, -- DISPONIBLE, OCCUPEE, INDISPONIBLE
    photo_path    VARCHAR(255),              -- chemin/nom du fichier uploadé
    CONSTRAINT uk_chambre_numero UNIQUE (numero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

- 5) Table reservation
DROP TABLE IF EXISTS reservation;
CREATE TABLE reservation (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_client     BIGINT           NOT NULL,
    id_chambre    BIGINT           NOT NULL,
    date_debut    DATE             NOT NULL,
    date_fin      DATE             NOT NULL,
    nb_personnes  INT              NOT NULL,
    commentaire   TEXT,
    duree         INT,                      -- nb de nuits (on pourra aussi le calculer)
    statut        VARCHAR(20)      NOT NULL, -- EN_ATTENTE, CONFIRMEE, ANNULEE, TERMINEE
    CONSTRAINT fk_reservation_client
        FOREIGN KEY (id_client) REFERENCES utilisateur(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_reservation_chambre
        FOREIGN KEY (id_chambre) REFERENCES chambre(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

- 6) Insérer un admin par défaut (mot de passe **haché** avec SHA-256)

```sql
INSERT INTO utilisateur (nom, email, telephone, mot_de_passe, role)
VALUES (
  'Admin Hôtel',
  'admin@hotel.com',
  '00000000',
  SHA2('Admin@2025', 256), -- mot de passe en clair : Admin@2025
  'ADMIN'
);
```
### Configuration Hibernate
- **Dialecte** : MySQLDialect
- **Mode de création** : `none` (schéma existant)
- **Affichage SQL** : Activé pour le débogage
- **Transaction** : RESOURCE_LOCAL

### Dépendances principales
- Jakarta EE Web API 10.0.0
- Hibernate Core 6.4.4.Final
- MySQL Connector 8.0.33
- JUnit 3.8.1 (tests)

## Déploiement / Exécution du projet

### Prérequis
1. **Java** : JDK 17 ou supérieur
2. **Maven** : 3.6+
3. **MySQL** : 8.0+
4. **Serveur** : Tomcat 10+ (compatible Jakarta EE)

### Étapes détaillées

1. **Créer la base de données et les tables**

   Dans MySQL (client, phpMyAdmin, etc.) :

   ```sql
   -- 1) Créer la base et l'utilisateur
   CREATE DATABASE IF NOT EXISTS gestion_hotel
     CHARACTER SET utf8mb4
     COLLATE utf8mb4_unicode_ci;

   CREATE USER IF NOT EXISTS 'hotel_user'@'localhost'
     IDENTIFIED BY 'Hotel@2025';
   GRANT ALL PRIVILEGES ON gestion_hotel.* TO 'hotel_user'@'localhost';
   FLUSH PRIVILEGES;

   USE gestion_hotel;

   -- 2) Créer les tables (utilisateur, chambre, reservation)
   -- Voir les commandes détaillées plus haut dans cette section.
   ```

2. **(Optionnel, si vous aviez déjà des utilisateurs en clair)** : migrer les mots de passe existants en SHA-256

   Si votre base contient déjà des utilisateurs dont le mot de passe était stocké en clair, exécutez **une seule fois** :

   ```sql
   USE gestion_hotel;

   UPDATE utilisateur
   SET mot_de_passe = SHA2(mot_de_passe, 256);
   ```

3. **Créer un compte administrateur par défaut**

   Si aucun admin n'existe encore, vous pouvez créer un administrateur avec un mot de passe haché SHA-256 :

   ```sql
   USE gestion_hotel;

   INSERT INTO utilisateur (nom, email, telephone, mot_de_passe, role)
   VALUES (
     'Admin Hôtel',
     'admin@hotel.com',
     '00000000',
     SHA2('Admin@2025', 256), -- mot de passe en clair : Admin@2025
     'ADMIN'
   );
   ```

4. **Compilation et packaging Maven**

   Dans le dossier du projet :

   ```bash
   mvn clean package
   ```

5. **Déploiement sur Tomcat**

   Copier le fichier WAR généré vers le dossier `webapps` de Tomcat :

   ```bash
   cp target/reservation_hotel.war $TOMCAT_HOME/webapps/
   ```

6. **Démarrer Tomcat**

   ```bash
   $TOMCAT_HOME/bin/startup.sh
   ```

### Accès à l'application
- **URL principale** : `http://localhost:8080/reservation_hotel/`
- **Interface admin** : `http://localhost:8080/reservation_hotel/admin/dashboard`

### Comptes par défaut
- **Administrateur** : `admin@hotel.com` / `Admin@2025` (créé via le script SQL ci-dessus)
- **Clients** : Créés automatiquement lors des réservations (mot de passe haché en SHA-256 côté serveur)

## Sécurité

### Authentification
- Gestion de session avec attribut `user` en session
- Contrôle d'accès aux pages administratives (rôle `ADMIN` requis)
- Hachage des mots de passe côté serveur avec SHA-256 (`PasswordUtil`)

### Validation
- Validation côté serveur des formulaires
- Protection contre les injections SQL (via Hibernate)
- Nettoyage des entrées utilisateur

## Design et UX

### Technologies Frontend
- **Bootstrap 5** : Framework CSS responsive
- **Bootstrap Icons** : Icônes modernes
- **JSP Fragments** : Réutilisation des layouts

### Caractéristiques
- Interface responsive pour mobile et desktop
- Navigation cohérente avec header/footer partagés
- Messages d'erreur et de confirmation
- Affichage dynamique selon l'état de connexion

## Flux de Réservation

1. **Recherche** : Client sélectionne des critères
2. **Consultation** : Détails de la chambre avec photos
3. **Réservation** : Formulaire avec création de compte
4. **Confirmation** : Email de confirmation (à implémenter)
5. **Gestion** : Suivi et annulation via le profil

## Modèle de Données

### Entités principales
- **Utilisateur** : Clients et administrateurs
- **Chambre** : Types, prix, capacités, photos
- **Reservation** : Liens utilisateur-chambre avec dates et statuts

### Relations
- Un utilisateur peut avoir plusieurs réservations
- Une chambre peut avoir plusieurs réservations
- Gestion des conflits de dates (à améliorer)

## Améliorations Futures

### Court terme
- **Hachage des mots de passe** : Utiliser BCrypt
- **Emails de confirmation** : Service de notification
- **Validation avancée** : Vérification des conflits de dates
- **Upload de photos** : Gestion des fichiers

### Moyen terme
- **Paiement en ligne** : Intégration Stripe/PayPal
- **Recherche avancée** : Filtres multiples et géolocalisation
- **API REST** : Pour application mobile
- **Internationalisation** : Support multilingue

### Long terme
- **Microservices** : Découpler les fonctionnalités
- **React/Vue.js** : Frontend moderne
- **Docker** : Conteneurisation
- **Tests automatisés** : Unitaires et d'intégration

## Notes de Développement

### Points techniques importants
- Utilisation de JPA avec Hibernate pour la persistance
- Pattern DAO pour la séparation des responsabilités
- Fragments JSP pour la réutilisation des layouts
- Gestion manuelle des transactions EntityManager

### Particularités
- Configuration compatible Jakarta EE 10
- Utilisation de BigDecimal pour les montants (FCFA)
- Gestion des dates avec LocalDate
- Support des blobs pour les images
