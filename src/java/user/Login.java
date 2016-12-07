
package user;

import java.util.LinkedList;
import org.apache.jasper.tagplugins.jstl.ForEach;

/**
 *
 * @author Morteza
 */
public class Login 
{
    boolean state = false;
    LinkedList<User> users = new LinkedList<>();
    
    public Login()
    {
        User u1 = new User();
        u1.setUsername("admin");
        u1.setPassword("admin");
        users.add(u1);
        
        User u2 = new User();
        u2.setUsername("admin2");
        u2.setPassword("admin2");       
        users.add(u2);
    }
    
    public boolean doLogin(String username, String password)
    {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        
        //return users.contains(user);
        
       for(User u: users)
       {
           if(u.getUsername().equals(user.getUsername())
                   && u.getPassword().equals(user.getPassword()))
           {
               return true;
           }
       }
       return false;
    }
    
}
