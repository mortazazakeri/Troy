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
    private static TripRequestManager tripRequestManager = null;

    private TripRequestManager()
    {

    }

    public static TripRequestManager getTripRequsetManagerInstance()
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

        Predicate<TripRequest> filterByID = tr -> tr.getRequestId() == tripRequestId;
        return tripRequestsList.removeIf(filterByID);

    }

    public TripRequest updateTripRequestStatus(int tripRequestId, String newStatus)
    {

        for (TripRequest tr : tripRequestsList)
        {
            if (tr.getRequestId() == tripRequestId)
            {
                tripRequestsList.get(tripRequestsList.indexOf(tr)).setStatus(newStatus);
                if(newStatus.equals("accept"))
                {
                    saveTrip2DB(tr);
                }
                return tripRequestsList.get(tripRequestsList.indexOf(tr));
            }
        }
        return null;
    }
    
    public TripRequest updateTripRequestStatusAndDriver(int tripRequestId, String newStatus, String driverName)
    {

        for (TripRequest tr : tripRequestsList)
        {
            if (tr.getRequestId() == tripRequestId)
            {
                tripRequestsList.get(tripRequestsList.indexOf(tr)).setStatus(newStatus);
                tripRequestsList.get(tripRequestsList.indexOf(tr)).setDriverUsername(driverName);
                if(newStatus.equals("accept"))
                {
                    saveTrip2DB(tr);
                }
                return tripRequestsList.get(tripRequestsList.indexOf(tr));
            }
        }
        return null;
    }
    
    public TripRequest getTripRequestById(int id)
    {
         for (TripRequest tr : tripRequestsList)
        {
            if (tr.getRequestId() == id)
            {
                return tripRequestsList.get(tripRequestsList.indexOf(tr));
            }
        }
        return null;
    }
    

    public List<TripRequest> getTripRequestsOfPessenger(String passengerUsername)
    {
        LinkedList<TripRequest> passengerTripRequests = new LinkedList<>();
        for (TripRequest tr : tripRequestsList)
        {
            if (tr.getPassengerUsername().equals(passengerUsername))
            {
                passengerTripRequests.add(tr);
            }
        }
        return passengerTripRequests;

    }

    public List<TripRequest> getAllTripRequests()
    {
        return tripRequestsList;
    }

    public List<TripRequest> getAllWaitingTripRequests()
    {
        LinkedList<TripRequest> waitingTripRequests = new LinkedList<>();
        for (TripRequest tr : tripRequestsList)
        {
            if (tr.getStatus().equals("waiting"))
            {
                waitingTripRequests.add(tr);
            }
        }
        return waitingTripRequests;
    }

    public boolean saveTrip2DB(TripRequest tr)
    {
        try
        {
            db.ODBClass.getInstance().insertTrip(tr.getPassengerUsername(),
                    tr.getDriverUsername(), tr.getStartNode(), tr.getDestinationNode());
            return true;
        } catch (Exception e)
        {
            return false;
        }
    }

}
