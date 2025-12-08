package com.gestionhotel.dao;

import com.gestionhotel.model.Utilisateur;
import com.gestionhotel.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UtilisateurDao {

    public Utilisateur findByEmailAndPassword(String email, String motDePasse) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String hashed = PasswordUtil.hashPassword(motDePasse);
            TypedQuery<Utilisateur> query = em.createQuery(
                    "SELECT u FROM Utilisateur u WHERE u.email = :email AND u.motDePasse = :mdp",
                    Utilisateur.class
            );
            query.setParameter("email", email);
            query.setParameter("mdp", hashed);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public Utilisateur findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery(
                    "SELECT u FROM Utilisateur u WHERE u.email = :email",
                    Utilisateur.class
            );
            query.setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void saveOrUpdate(Utilisateur utilisateur) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (utilisateur.getId() == null) {
                em.persist(utilisateur);
            } else {
                em.merge(utilisateur);
            }
            em.getTransaction().commit();
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Utilisateur> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Utilisateur> query = em.createQuery("SELECT u FROM Utilisateur u ORDER BY u.nom", Utilisateur.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Utilisateur findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Utilisateur.class, id);
        } finally {
            em.close();
        }
    }
}
