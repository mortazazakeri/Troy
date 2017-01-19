/*
 Request for trip
 */
package trip;

/**
 *
 * @author Morteza
 */
public class TripRequest
{

    /**
     * @return the startNodeName
     */
    public String getStartNodeName() {
        return startNodeName;
    }

    /**
     * @param startNodeName the startNodeName to set
     */
    public void setStartNodeName(String startNodeName) {
        this.startNodeName = startNodeName;
    }

    /**
     * @return the destinationNodeName
     */
    public String getDestinationNodeName() {
        return destinationNodeName;
    }

    /**
     * @param destinationNodeName the destinationNodeName to set
     */
    public void setDestinationNodeName(String destinationNodeName) {
        this.destinationNodeName = destinationNodeName;
    }

    private int requestId;
    private int startNode;
    private int destinationNode;
    private String passengerUsername;
    private String aliasName;
    private String driverUsername;
    private String status; //e.g. accept, reject or waiting

    private String startNodeName;
    private String destinationNodeName;
    
    public TripRequest()
    {

    }

    public TripRequest(int id, int startNode, int destinationNode, String passengerUsername, String aliasName, String driverUsername, String status)
    {
        this.requestId = id;
        this.startNode = startNode;
        this.destinationNode = destinationNode;
        this.passengerUsername = passengerUsername;
        this.aliasName = aliasName;
        this.driverUsername = driverUsername;
        this.status = status; //e.g. accept, reject or waiting
        
        this.startNodeName = (String)db.ODBClass.getInstance().readNode(startNode).getName();
        this.destinationNodeName = (String)db.ODBClass.getInstance().readNode(destinationNode).getName();
        
    }

    /**
     * @return the requestId
     */
    public int getRequestId()
    {
        return requestId;
    }

    /**
     * @param requestId the requestId to set
     */
    public void setRequestId(int requestId)
    {
        this.requestId = requestId;
    }

    /**
     * @return the startNode
     */
    public int getStartNode()
    {
        return startNode;
    }

    /**
     * @param startNode the startNode to set
     */
    public void setStartNode(int startNode)
    {
        this.startNode = startNode;
    }

    /**
     * @return the destinationNode
     */
    public int getDestinationNode()
    {
        return destinationNode;
    }

    /**
     * @param destinationNode the destinationNode to set
     */
    public void setDestinationNode(int destinationNode)
    {
        this.destinationNode = destinationNode;
    }

    /**
     * @return the passengerUsername
     */
    public String getPassengerUsername()
    {
        return passengerUsername;
    }

    /**
     * @param passengerUsername the passengerUsername to set
     */
    public void setPassengerUsername(String passengerUsername)
    {
        this.passengerUsername = passengerUsername;
    }

    /**
     * @return the aliasName
     */
    public String getAliasName()
    {
        return aliasName;
    }

    /**
     * @param aliasName the aliasName to set
     */
    public void setAliasName(String aliasName)
    {
        this.aliasName = aliasName;
    }

    /**
     * @return the driverUsername
     */
    public String getDriverUsername()
    {
        return driverUsername;
    }

    /**
     * @param driverUsername the driverUsername to set
     */
    public void setDriverUsername(String driverUsername)
    {
        this.driverUsername = driverUsername;
    }

    /**
     * @return the status
     */
    public String getStatus()
    {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status)
    {
        this.status = status;
    }
}
