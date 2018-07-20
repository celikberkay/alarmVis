
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class AlarmsConnection {
	double[] lat=new double[1000];
	double[] lng=new double[1000];
	int count=0;
	public int getCount() {
		return count;
	}
	
 
	public double[] getLat() {
		return lat;
	}
	public double[] getLng() {
		return lng;
	}
	
	  public void connect()
	  {
		  Connection c = null;
          Statement stmt = null;
      
      try {
    	  
      Class.forName("org.postgresql.Driver");
      c = DriverManager.getConnection("jdbc:postgresql://localhost:5433/vays_db","postgres", "1");
      c.setAutoCommit(false);
     // System.out.println("Opened database successfully");

      stmt = c.createStatement();
      ResultSet rs = stmt.executeQuery( "SELECT * FROM \"alarmLogs\" ORDER BY id DESC LIMIT '4'");
      
      
      while ( rs.next() ) {
      lat[count]= rs.getDouble("xkoordinat");
      lng[count]=rs.getDouble("ykoordinat");
      
      System.out.println( "lat=" + lat[count] );
      System.out.println("lng="+lng[count]);
         
       count++ ;

        }
        rs.close();
        stmt.close();
        c.close();
      } catch ( Exception e ) {
        System.err.print( e.getClass().getName()+": "+ e.getMessage() );
        System.exit(0);
      }
      System.out.println(count);
      
    
	     
}
}