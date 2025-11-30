package com.gestionhotel.dao;

import com.gestionhotel.model.Reservation;
import com.gestionhotel.model.Utilisateur;
import jakarta.persistence.EntityManager;

import java.util.List;

public class ReservationDao {

    public void save(Reservation reservation) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (reservation.getId() == null) {
                em.persist(reservation);
            } else {
                em.merge(reservation);
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

    public Reservation findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Reservation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Reservation> findByClient(Utilisateur client) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Reservation r JOIN FETCH r.chambre WHERE r.client = :client ORDER BY r.dateDebut DESC", Reservation.class)
                    .setParameter("client", client)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reservation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT r FROM Reservation r JOIN FETCH r.chambre JOIN FETCH r.client ORDER BY r.dateDebut DESC", Reservation.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
