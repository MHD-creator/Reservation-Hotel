# Système de Réservation d'Hôtel

Une application web complète de gestion hôtelière développée avec Java EE, JSP, et Hibernate, permettant aux clients de réserver des chambres et aux administrateurs de gérer l'établissement.

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
### Commandes pour creer les tables dans la base donnée
- 1 Créer la base de données
CREATE DATABASE IF NOT EXISTS gestion_hotel
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE gestion_hotel;

- 2) Créer un utilisateur MySQL dédié
CREATE USER IF NOT EXISTS 'hotel_user'@'localhost'
  IDENTIFIED BY 'Hotel@2025';
GRANT ALL PRIVILEGES ON gestion_hotel.* TO 'hotel_user'@'localhost';
FLUSH PRIVILEGES;
 - NB : Dans le cas ou vou decederez de changer le user et le mdp, vous pouvez recorriger la configuration dans le fichier persistence.xml
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

- 6) Insérer un admin par défaut
INSERT INTO utilisateur (nom, email, telephone, mot_de_passe, role)
VALUES ('Admin Hôtel', 'admin@hotel.com', '00000000', 'admin', 'ADMIN');
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

## Déploiement

### Prérequis
1. **Java** : JDK 17 ou supérieur
2. **Maven** : 3.6+
3. **MySQL** : 8.0+
4. **Serveur** : Tomcat 10+ (compatible Jakarta EE)

### Étapes de déploiement

1. **Configuration de la base de données**
   ```sql
   CREATE DATABASE gestion_hotel;
   -- Exécuter le script SQL fourni pour créer les tables
   ```

2. **Compilation et packaging**
   ```bash
   mvn clean package
   ```

3. **Déploiement**
   ```bash
   # Copier le WAR vers le répertoire webapps de Tomcat
   cp target/reservation_hotel.war $TOMCAT_HOME/webapps/
   ```

4. **Démarrage**
   ```bash
   # Démarrer Tomcat
   $TOMCAT_HOME/bin/startup.sh
   ```

### Accès à l'application
- **URL principale** : `http://localhost:8080/reservation_hotel/`
- **Interface admin** : `http://localhost:8080/reservation_hotel/admin/dashboard`

### Comptes par défaut
- **Administrateur** : `admin@hotel.com` / `admin123`
- **Clients** : Créés automatiquement lors des réservations

## Sécurité

### Authentification
- Gestion de session avec attributs `user` et `isClient`
- Contrôle d'accès aux pages administratives
- Hachage des mots de passe (à implémenter)

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
