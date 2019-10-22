##########################################################################################################################################
#  Author   :  AHMAD RIFKY IDRUS
#  COMPANY  : PRIVATE
#  PROJECT  : Sh converter from EncodeBase 64  4G Only  render to map
#  INFO need to be noted:  legal disclaimer by http://www.ahmadrifky.com
#
##########################################################################################################################################



use MIME::Base64;
use LWP::UserAgent;
use HTTP::Request::Common;
use JSON qw( decode_json );




my $encoded = shift or die;
my $TokenMy = shift or die;    ###please sign up to https://unwiredlabs.com



print decode_base64( $encoded);
print "\n";


my $str = decode_base64( $encoded);
my $hex = unpack('H*', "$str"); 

 
my $len = length($hex); 
my $start = 6; 



#print "yiihiiiyyy $hex \n";
 
 @mcc = split("",$hex) ;
 # 10 32 54
 
 


 
  my $MCC = "$mcc[1]$mcc[0]$mcc[3]" ;
my $MNC = "$mcc[2]$mcc[5]$mcc[4]" ;

 $MNC =~ s/[a-zA_Z]//g ;

#print "mcc mnc $mcc[1]$mcc[0]$mcc[3]-$mcc[2]$mcc[5]$mcc[4] " ;
 
print " The ECGI DECIMAL $MCC  $MNC " ;

my $CIcounter = sprintf("%d", hex(  (substr($hex,6)    )    )); 
print $CIcounter ;
print "\n";

print "  GENERATING MAP  \n" ;





my $userAgent = LWP::UserAgent->new(agent => 'perl post', keep_alive => 1);

$ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;

my $mapheader = '<!DOCTYPE html>
<html>
<head>
	
	<title>http://www.ahmadrifky.com/ict-stuff</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css" integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ==" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js" integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==" crossorigin=""></script>


	
</head>
<body>



<div id="mapid" style="width: 600px; height: 400px;"></div>
<script>

	var mymap = L.map(\'mapid\').setView([-6.191952,106.897987], 13);

	L.tileLayer(\'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw\', {
		maxZoom: 18,
		attribution: \'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, \' +
			\'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, \' +
			\'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>\',
		id: \'mapbox.streets\'
	}).addTo(mymap);';
          
 



   my $mapfooter1 = 'var popup = L.popup();

	function onMapClick(e) {
		popup
			.setLatLng(e.latlng)
			.setContent("You clicked the map at " + e.latlng.toString())
			.openOn(mymap);
	}

	mymap.on(\'click\', onMapClick);

</script>



</body>
</html>
' ;



 

$message = "{
    \"token\": \"".$TokenMy."\",
    \"radio\": \"lte\",
    \"mcc\": ".$MCC.",
    \"mnc\": ".$MNC.",
    \"cells\": [{
        \"lac\": 1,
        \"cid\": ".$CIcounter.",
        \"psc\": 0
    }],
    \"address\": 1
}";


$response = $userAgent->request(POST 'https://ap1.unwiredlabs.com/v2/process.php',
Content_Type => 'application/json',
Content => $message);

print $response->error_as_HTML unless $response->is_success;

print $response->content;

my $decoded = decode_json($response->content);

print $decoded->{'lat'} ;
print $decoded->{'lon'} ;


my $judul = localtime ;


if  ($response->is_success) {
&pretty_print($judul."BTS.html",  &myMapHtml('-6.191952','106.897987','510011504005','500')) ;
}




#########  penutupan  ###############

#		center: [35.7559646,51.2273134],

#&pretty_print($judul."BTS.html" , $centre) ;




sub pretty_print {
    my ($filename, $text, $text_width) = @_;

    # Format $text to $text_width somehow.
chomp $filename;
    open my $prettyprint, '>>', "$filename"
        or die "Cannot open '$filename' for writing: $!\n";

    print $prettyprint "$text \n";

    close $prettyprint;

    return;
}

sub myMapHtml {
 my ($lat, $lon, $keterangan, $akurasi) = @_;
 
my $containsnya =  '<!DOCTYPE html>
<html>
<head>
	
	<title>http://www.ahmadrifky.com/ict-stuff</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css" integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ==" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js" integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==" crossorigin=""></script>


	
</head>
<body>



<div id="mapid" style="width: 600px; height: 400px;"></div>
<script>

	var mymap = L.map(\'mapid\').setView(['.$lat.', '.$lon.'], 13);

	L.tileLayer(\'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw\', {
		maxZoom: 18,
		attribution: \'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, \' +
			\'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, \' +
			\'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>\',
		id: \'mapbox.streets\'
	}).addTo(mymap);
	
	L.marker(['.$lat.', '.$lon.']).addTo(mymap).bindPopup('.$keterangan.').openPopup();
	L.circle(['.$lat.', '.$lon.'], '.$akurasi.', {color: \'red\', fillColor: \'#f03\', fillOpacity: \'0.5\'}).addTo(mymap).bindPopup('.$alamat.');
 var popup = L.popup();

	function onMapClick(e) {
		popup
			.setLatLng(e.latlng)
			.setContent("You clicked the map at " + e.latlng.toString())
			.openOn(mymap);
	}

	mymap.on(\'click\', onMapClick);

</script>



</body>
</html>';

return $containsnya ;

}
