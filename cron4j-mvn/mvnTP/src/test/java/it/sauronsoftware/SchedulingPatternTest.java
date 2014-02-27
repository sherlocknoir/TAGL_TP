package it.sauronsoftware;

import it.sauronsoftware.cron4j.SchedulingPattern;
import it.sauronsoftware.cron4j.InvalidPatternException;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

public class SchedulingPatternTest {

  @BeforeClass
  public static void testSetup() {
  }

  @AfterClass
  public static void testCleanup() {
    // Teardown for data used by the unit tests
  }

  @Test(expected = InvalidPatternException.class)
  public void testExceptionIsThrown() {
    SchedulingPattern sp = new SchedulingPattern("0 5 * *");
  }

  @Test
  public void testPattern() {
    String pattern;
    pattern="0 5 * * *|8 10 * * *|22 17 * * *";
    assertTrue(pattern + "is correct", SchedulingPattern.validate(pattern));
    pattern="0 5 * * *";
    assertTrue(pattern + "is correct", SchedulingPattern.validate(pattern));
  }
}
