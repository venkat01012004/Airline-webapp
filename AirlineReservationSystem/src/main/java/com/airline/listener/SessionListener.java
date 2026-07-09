package com.airline.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.logging.Logger;

/**
 * Listener that tracks the number of currently active HTTP sessions.
 * The active session count can be useful for simple admin diagnostics.
 */
@WebListener
public class SessionListener implements HttpSessionListener {

    private static final Logger LOGGER = Logger.getLogger(SessionListener.class.getName());
    private static final AtomicInteger ACTIVE_SESSIONS = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = ACTIVE_SESSIONS.incrementAndGet();
        LOGGER.info("Session created. Active sessions: " + count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int count = ACTIVE_SESSIONS.decrementAndGet();
        LOGGER.info("Session destroyed. Active sessions: " + count);
    }

    public static int getActiveSessionCount() {
        return ACTIVE_SESSIONS.get();
    }
}
