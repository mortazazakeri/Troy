/*
 */
package user;

/**
 *
 * @author Morteza
 */
public class Passenger extends User
{
    private String role = "passenger";
    
    public Passenger()
    {
        
    }
    
    public Passenger(String fn, String ln, String un, String pw, String role)
    {
        super(fn, ln, un,pw);
        this.role = role;
    }
    
    public Passenger(User u , String role)
    {
        super(u.getFirstname(),u.getLastname(),u.getUsername(),u.getPassword());
        this.role = role;
    }
    
    /**
     * @return the role
     */
    public String getRole()
    {
        return role;
    }
    
    /**
     * @param role the roll to set
     */
    public void setRole(String role)
    {
        this.role = role;
    }
}
