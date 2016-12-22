package db;

/**
 *
 * @author Morteza List of all functions that this class serves: doLogin
 * doRegister
 *
 */
public class Responsibility
{

    boolean state = false;
    //LinkedList<User> users = new LinkedList<>();

    public Responsibility()
    {
        /*
         User u1 = new User();
         u1.setUsername("admin");
         u1.setPassword("admin");
         users.add(u1);
        
         User u2 = new User();
         u2.setUsername("admin2");
         u2.setPassword("admin2");       
         users.add(u2);
         */
    }

    public Person doLogin(String username, String password, String role)
    {
        switch (role)
        {
            case "driver":
                Driver d = ODBClass.getInstance().readDriver(username);
                if (d == null)
                {
                    return null;
                } else
                {
                    if (d.getPassword().equals(password))
                    {
                        return d;
                    } else
                    {
                        return null;
                    }
                }
            case "passenger":
                User p = ODBClass.getInstance().readUser(username);
                if (p == null)
                {
                    return null;
                } else
                {
                    if (p.getPassword().equals(password))
                    {
                        return p;
                    } else
                    {
                        return null;
                    }
                }
            case "manager":
                Manager m = ODBClass.getInstance().readManager(username);
                if (m == null)
                {
                    return null;
                } else
                {
                    if (m.getPassword().equals(password))
                    {
                        return m;
                    } else
                    {
                        return null;
                    }
                }
        }
        return null;
    }

    public boolean doRegister(String name, String username, String password, String role)
    {
        if(name == null | username == null | password == null | role == null)
        {
            return false;
        }
        else if( username.length()<4 | password.length()<4)
        {
             return false;
        }
        switch (role)
        {
            case "driver":
            {
                Driver d = ODBClass.getInstance().readDriver(username);
                if (d == null)
                {
                    ODBClass.getInstance().insertDriver(name, username, password, 1, 2);
                    return true;
                }
                else
                {
                    return false;
                }
            }
            case "passenger":
                User p = ODBClass.getInstance().readUser(username);
                if (p == null)
                {
                   ODBClass.getInstance().insertUser(name, username, password);
                   return true;
                } else
                {
                    return false;
                }
            case "manager":
                Manager m = ODBClass.getInstance().readManager(username);
                if (m == null)
                {
                   ODBClass.getInstance().insertManager(name, username, password);
                   return true;
                } else
                {
                    return false;
                }
        }
        return false;
    }
}
