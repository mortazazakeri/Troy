/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trip;

import java.util.LinkedList;
import java.util.List;
import java.util.function.Predicate;

/**
 *
 * @author Morteza
 */
public class TripRequestManager
{

    public static int requestIdCounter = 0;
    private LinkedList<TripRequest> tripRequestsList = new LinkedList<>();
    private TripRequestManager tripRequestManager = null;

    private TripRequestManager()
    {

    }

    public TripRequestManager getTripRequsetManagerInstance()
    {
        if (tripRequestManager == null)
        {
            tripRequestManager = new TripRequestManager();
        }
        return tripRequestManager;
    }

    public boolean addTripRequest(int startNode, int destinationNode, String passengerUsername, String aliasName, String driverUsername, String status)
    {
        try
        {
            requestIdCounter++;
            TripRequest tr = new TripRequest(requestIdCounter, startNode, destinationNode, passengerUsername, aliasName, driverUsername, status);
            tripRequestsList.add(tr);
            return true;
        } catch (Exception e)
        {
            return false;
        }
    }
    
    public boolean deleteTripRequset(int tripRequestId)
    {

        Predicate<TripRequest> filterByID = tr->tr.getRequestId()== tripRequestId;      
        return tripRequestsList.removeIf(filterByID);

    }
    
    public TripRequest updateTripRequestStatus(int tripRequestId, String newStatus)
    {
         
         for(TripRequest tr: tripRequestsList)
         {
             if(tr.getRequestId()== tripRequestId)
             {
                 tripRequestsList.get(tripRequestsList.indexOf(tr)).setStatus(newStatus);                      
                 return  tripRequestsList.get(tripRequestsList.indexOf(tr));
             }
         }
         return null;
    }
    
    public TripRequest  getTripRequestOfPessenger(String passengerUsername)
    {
        for(TripRequest tr: tripRequestsList)
         {
             if(tr.getPassengerUsername().equals(passengerUsername))
             {                     
                 return  tripRequestsList.get(tripRequestsList.indexOf(tr));
             }
         }
         return null;
        
    }
    
    public List<TripRequest>  getAllTripRequests(String passengerUsername)
    {
        return tripRequestsList;        
    }
    
    public List<TripRequest>  getAllWaitingTripRequests(String passengerUsername)
    {
        LinkedList<TripRequest> waitingTripRequests = new LinkedList<>();
        for(TripRequest tr: tripRequestsList)
         {
             if(tr.getStatus().equals("waiting"))
             {                     
                 waitingTripRequests.add(tr);
             }
         }
        return waitingTripRequests;        
    }
}
