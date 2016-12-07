/*
 */
package user;

/**
 *
 * @author Morteza
 */
public class Manager extends User
{
    private String role = "manager";
    private String permision = "1010101010";

    public Manager()
    {
        
    }
    
    public Manager(String fn, String ln, String un, String pw, String role)
    {
        super(fn, ln, un,pw);
        this.role = role;
    }
    
    public Manager(User u , String role)
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
     * @param role the role to set
     */
    public void setRole(String role)
    {
        this.role = role;
    }

    /**
     * @return the permision
     */
    public String getPermision()
    {
        return permision;
    }

    /**
     * @param permision the permision to set
     */
    public void setPermision(String permision)
    {
        this.permision = permision;
    }
}
