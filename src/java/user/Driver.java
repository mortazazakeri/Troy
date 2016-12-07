/*
 */
package user;

/**
 *
 * @author Morteza
 */
public class Driver extends User
{

    private String role = "driver";
    private String licenseNumber; //e.g 95723088
    private String vehicleName; // e.g pride, samand, etc.

    public Driver()
    {
        
    }
    public Driver(String fn, String ln, String un, String pw, String role)
    {
        super(fn, ln, un,pw);
        this.role = role;
    }
    
    public Driver(User u , String role)
    {
        super(u.getFirstname(),u.getLastname(),u.getUsername(),u.getPassword());
        this.role = role;
    }
    
    /**
     * @return the licenseNumber
     */
    public String getLicenseNumber()
    {
        return licenseNumber;
    }

    /**
     * @param licenseNumber the licenseNumber to set
     */
    public void setLicenseNumber(String licenseNumber)
    {
        this.licenseNumber = licenseNumber;
    }

    /**
     * @return the vehicleName
     */
    public String getVehicleName()
    {
        return vehicleName;
    }

    /**
     * @param vehicleName the vehicleName to set
     */
    public void setVehicleName(String vehicleName)
    {
        this.vehicleName = vehicleName;
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

}
