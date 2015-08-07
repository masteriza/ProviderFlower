package com.flower.dao;

import javax.servlet.ServletContextEvent;

/**
 * Created by user on 07.08.2015.
 */
public class NewServletListerner {
    public void contextInitialized(ServletContextEvent sce) {
        try {
            MyDAO myDAO = new MyDAO();
            sce.getServletContext().setAttribute("myDAO", myDAO); // Application scope attribute
        } catch (Exception ex) {
            throw new RuntimeException("Can't create connection pool", ex);
        }
    }

    public void contextDestroyed(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("myDAO", null);
    }
}
