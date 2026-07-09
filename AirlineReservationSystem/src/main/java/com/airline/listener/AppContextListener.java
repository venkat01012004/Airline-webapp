package com.airline.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.logging.Logger;

/**
 * Application-wide lifecycle listener.
 * Logs when the Airline Reservation System web application starts up and
 * shuts down. The DBConnection utility class initializes the JDBC driver
 * lazily on first use, so no explicit connection pool setup is required here.
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    private static final Logger LOGGER = Logger.getLogger(AppContextListener.class.getName());

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        LOGGER.info("=========================================================");
        LOGGER.info(" Airline Reservation System - Application Starting Up");
        LOGGER.info("=========================================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LOGGER.info("=========================================================");
        LOGGER.info(" Airline Reservation System - Application Shutting Down");
        LOGGER.info("=========================================================");
    }
}
