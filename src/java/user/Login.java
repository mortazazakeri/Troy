package user;

/**
 *
 * @author Morteza
 */
public class Login
{

    boolean state = false;
    //LinkedList<User> users = new LinkedList<>();

    public Login()
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

    public User doLogin(String username, String password, String role)
    {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        //return users.contains(user);
        if (role.equals("manager"))
        {
            for (User u : UserRepository.getUserRepositoryInstance().allManagers)
            {
                if (u.getUsername().equals(user.getUsername())
                        && u.getPassword().equals(user.getPassword()))
                {                   
                    return u;
                }
            }
        } else if (role.equals("driver"))
        {
            for (User u : UserRepository.getUserRepositoryInstance().allDrivers)
            {
                if (u.getUsername().equals(user.getUsername())
                        && u.getPassword().equals(user.getPassword()))
                {
                    return u;
                }
            }
        } else
        {
            for (User u
                    : UserRepository.getUserRepositoryInstance().allPassengers)
            {
                if (u.getUsername().equals(user.getUsername())
                        && u.getPassword().equals(user.getPassword()))
                {
                    return u;
                }
            }
        }
        return null;
    }

}
