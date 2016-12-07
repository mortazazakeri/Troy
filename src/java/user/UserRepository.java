/*
 */
package user;

import java.util.LinkedList;

/**
 *
 * @author Morteza
 */
public class UserRepository
{

    private static UserRepository userRepositoryInstance = null;

    public LinkedList<Passenger> allPassengers = new LinkedList<>();
    public LinkedList<Driver> allDrivers = new LinkedList<>();
    public LinkedList<Manager> allManagers = new LinkedList<>();

    private UserRepository()
    {
        User x;
        //defualt manager:
        x = new Manager();
        x.setFirstname("Galileo");
        x.setLastname("Galile");
        x.setUsername("admin");
        x.setPassword("admin");
        ((Manager) x).setRole("manager");
        allManagers.add((Manager) x);

        //defualt driver
        x = new Driver();
        x.setFirstname("Mohsen");
        x.setLastname("Amirian");
        x.setUsername("driver1");
        x.setPassword("driver1");
        ((Driver) x).setRole("driver");
        allDrivers.add(((Driver) x));

        //default passenger
        x = new Passenger();
        x.setFirstname("Morteza");
        x.setLastname("Zakeri");
        x.setUsername("12345");
        x.setPassword("12345");
        ((Passenger) x).setRole("passenger");
        allPassengers.add(((Passenger) x));
    }

    public static UserRepository getUserRepositoryInstance()
    {
        if (userRepositoryInstance == null)
        {
            userRepositoryInstance = new UserRepository();
        }
        return userRepositoryInstance;
    }

    /**
     *
     * @param u
     * @param role
     * @return
     */
    public boolean insertUser(User u, String role)
    {
        if (u.getFirstname() == null || u.getLastname() == null
                || u.getUsername() == null || u.getPassword() == null
                || u.getUsername().length() < 5 || u.getPassword().length() < 5
                || role == null)
        {
            return false;
        } else
        {
            if (role.equals("driver"))
            {
                Driver d = new Driver(u, role);
                allDrivers.add(d);
            } else
            {
                Passenger p = new Passenger(u, role);
                allPassengers.add(p);
            }
            return true;
        }
    }

    public User getUser(String role)
    {
        return null;
    }

}
