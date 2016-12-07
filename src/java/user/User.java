package user;

/**
 *
 * @author Morteza
 */
public class User
{

    protected String firstname;
    protected String lastname;
    protected String username;
    protected String password;

    public User()
    {
        
    }
    public User(String fn, String ln, String un, String pw)
    {
        this.firstname = fn;
        this.lastname = ln;
        this.username = un;
        this.password = pw;
    }
    
    /**
     * @return the username
     */
    public String getUsername()
    {
        return username;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username)
    {
        this.username = username;
    }

    /**
     * @return the password
     */
    public String getPassword()
    {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password)
    {
        this.password = password;
    }

    /**
     * @return the firstname
     */
    public String getFirstname()
    {
        return firstname;
    }

    /**
     * @param firstname the firstname to set
     */
    public void setFirstname(String firstname)
    {
        this.firstname = firstname;
    }

    /**
     * @return the lastname
     */
    public String getLastname()
    {
        return lastname;
    }

    /**
     * @param lastname the lastname to set
     */
    public void setLastname(String lastname)
    {
        this.lastname = lastname;
    }

}
