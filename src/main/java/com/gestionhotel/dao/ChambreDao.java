package com.gestionhotel.dao;

import com.gestionhotel.model.Chambre;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;
import java.math.BigDecimal;

public class ChambreDao {

    public List<Chambre> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Chambre> query = em.createQuery("SELECT c FROM Chambre c ORDER BY c.numero", Chambre.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Chambre> search(String type, Integer capaciteMin, BigDecimal prixMax) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            StringBuilder jpql = new StringBuilder("SELECT c FROM Chambre c WHERE 1=1");
            if (type != null && type.trim().length() > 0) {
                jpql.append(" AND c.type = :type");
            }
            if (capaciteMin != null) {
                jpql.append(" AND c.capacite >= :capacite");
            }
            if (prixMax != null) {
                jpql.append(" AND c.prixNuit <= :prixMax");
            }
            jpql.append(" ORDER BY c.prixNuit ASC, c.numero ASC");

            TypedQuery<Chambre> query = em.createQuery(jpql.toString(), Chambre.class);
            if (type != null && type.trim().length() > 0) {
                query.setParameter("type", type);
            }
            if (capaciteMin != null) {
                query.setParameter("capacite", capaciteMin);
            }
            if (prixMax != null) {
                query.setParameter("prixMax", prixMax);
            }
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Chambre findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Chambre.class, id);
        } finally {
            em.close();
        }
    }

    public void saveOrUpdate(Chambre chambre) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (chambre.getId() == null) {
                em.persist(chambre);
            } else {
                em.merge(chambre);
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

    public void deleteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Chambre chambre = em.find(Chambre.class, id);
            if (chambre != null) {
                em.remove(chambre);
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
}
