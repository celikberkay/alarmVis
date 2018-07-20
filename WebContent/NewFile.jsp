<%@page import="javax.*"%>
<%@page import="Alarm.AlarmsConnection"%>
<%@page import="Alarm.CameraConnection"%>
<%@page import="org.omg.PortableInterceptor.ForwardRequest"%>

<%@ page import="java.io.*" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  
<html>
 <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>HTR</title>
  <head>
      <body>            
            
<%
   
   //receiving data from database

   AlarmsConnection bg=new AlarmsConnection();
   bg.connect();
   CameraConnection ccn=new CameraConnection();
   ccn.connect();
   
	%>	
	<% response.setIntHeader("Refresh", 20); %> 

   
     
       
     
        
        
   
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7exxOeNfs2MJYTqGKkzh_20E3gBhFHCI"></script>
    <script>
      // In the following example, markers appear when the user clicks on the map.
      // Each marker is labeled with a single alphabetical character.
      var labels = '123456789';
      var labelIndex = 0;
      var labels_cam = '123456789';
      var labelIndex_cam = 0;
      var labels_s = '123456789';
      var labelIndex_s = 0;
      
     // window.alert("MAP CONTAINS "+(<%=bg.getCount()%>) + " MARKER"+ "\n CLICK OK TO DISPLAY");
      <% double[] xkoordinat=bg.getLat();%>
      <% double[] ykoordinat=bg.getLng();%>
      <% double[] camera_x=ccn.getLat();%>
      <% double[] camera_y=ccn.getLng();%>
      var image = {
              url: 'https://media.giphy.com/media/3o7TKCY8qT6LmzZ9zq/giphy.gif',              
              size: new google.maps.Size(50, 50)

            };
      var static_loc = {
              url: 'http://i64.tinypic.com/drchn4.png',              
              size: new google.maps.Size(50, 50)

            };
      var cam_image = {
              url: 'https://media.giphy.com/media/l41YruVHoE2PKn6HS/giphy.gif',              
              size: new google.maps.Size(40, 40)

            };
      var contentString = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<h1 id="firstHeading" class="firstHeading"><div align="center">Camera</h1>'+ '</div>'+
      '<div id="bodyContent">'+
      '<iframe width="500" height="500" src="http://192.168.1.1:8080/jsfs.html">'+
'</iframe>'+ 
      '</div>'+
      '</div>';
      var infowindow = new google.maps.InfoWindow({
          content: contentString,
          maxWidth: 500,
          maxHeight: 500
          
        });
      
      function initialize() {
    	  var latlngg= { lat:40.086 , lng:33.025};
    	  { 
      	    var map = new google.maps.Map(document.getElementById('map'), {
                  zoom: 19,
                  center: latlngg
                }); 
        }
    	  
    	 <% for ( int i=0; i <bg.getCount(); i++) { %>
		 	 
    	 var latlng_loc= { lat:<%=xkoordinat[i]%> , lng:<%=ykoordinat[i]%>}; 
    
              addMarker(latlng_loc, map);
 
     
    	  <%}%>
    	  <% for ( int i=0; i <ccn.getCount(); i++) { %>
		 	 
     	 var latlng_cam= { lat:<%=camera_x[i]%> , lng:<%=camera_y[i]%>}; 
         
               addCamMarker(latlng_cam, map);
     
     	  <%}%>
     	  
      }
      
      
      function addMarker_static(location, map) {
          // Add the marker at the clicked location, and add the next-available label
          // from the array of alphabetical characters.
          var marker = new google.maps.Marker({
            position: location,
            label: labels_s[labelIndex_s++ % labels.length],
            icon: static_loc,
            map: map
            
          });
        }
      // Adds a marker to the map.
      function addMarker(location, map) {
        // add the next-available label
        // from the array of alphabetical characters.
        var marker = new google.maps.Marker({
          position: location,
          label: labels[labelIndex++ % labels.length],
          animation:google.maps.Animation.DROP,
          map: map,
          icon: image
          
        });  
        
        marker.addListener("click", function() {          	marker.setMap(null);  addMarker_static(location,map);             });
        
        
        map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
      }
      function addCamMarker(location, map) {
          // add the next-available label
          // from the array of alphabetical characters.
          var marker = new google.maps.Marker({
            position: location,
            label: labels_cam[labelIndex_cam++ % labels.length],
            animation:google.maps.Animation.DROP,
            map: map,
            icon: cam_image
            
          });
          marker.addListener('click', function() {
              infowindow.open(map, marker);
            });
          
          map.setMapTypeId(google.maps.MapTypeId.SATELLITE);
        }
      function addMarkerSS(location, map) {
          // Add the marker at the clicked location, and add the next-available label
          // from the array of alphabetical characters.
          var marker = new google.maps.Marker({
            position: location,
            label: labels_s[labelIndex_s++ % labels.length],
            map: map
          });
        }

      google.maps.event.addDomListener(window, 'load', initialize);
      
   
    </script>

  <body>
    <div id="map"></div>
    <div id="capture"></div>
  </body>



        <body>
  </head>
</html>


    