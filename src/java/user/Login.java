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
        return user.UserRepository.getUserRepositoryInstance().getUser(username, password, role);
    }

}
