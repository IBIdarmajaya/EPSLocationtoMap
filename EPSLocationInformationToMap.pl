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
	
	<title>Layers Control Tutorial - Leaflet</title>

	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.4/dist/leaflet.css" integrity="sha512-puBpdR0798OZvTTbP4A8Ix/l+A4dHDD0DGqYW6RQ+9jxkRFclaxxQb/SJAWZfWAkuyeQUytO7+7N4QKrDh+drA==" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.3.4/dist/leaflet.js" integrity="sha512-nMMmRyTVoLYqjP9hrbed9S+FzjZHW5gY1TWCHA5ckwXZBadntCNs8kEqAWdrb9O7rxbCaA4lKTIWjDXZxflOcA==" crossorigin=""></script>


	<style>
		html, body {
			height: 100%;
			margin: 0;
		}
		#map {
			width: 1000px;
			height: 800px;
		}
	</style>

	
</head>
<body>

<div id=\'map\'></div>

<script>
	var thepoints = L.layerGroup();

';
          
 



   my $mapfooter1 = 'var mbAttr = \'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, \' +
			\'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, \' +
			\'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>\',
		mbUrl = \'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw\';

	var grayscale   = L.tileLayer(mbUrl, {id: \'mapbox.light\', attribution: mbAttr}),
		streets  = L.tileLayer(mbUrl, {id: \'mapbox.streets\',   attribution: mbAttr});

	var map = L.map(\'map\', {' ;

 my $mapfooter2 =' 		zoom: 10,
		layers: [streets,]
	});

	var baseLayers = {
		"Grayscale": grayscale,
		"Streets": streets
	};

	var overlays = {
		"Thepoints": thepoints
	};

	L.control.layers(baseLayers, overlays).addTo(map);
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

&pretty_print($judul."BTS.html" , $mapheader) ;

if  ($response->is_success) {
&pretty_print($judul."BTS.html", "L.marker([$decoded->{'lat'}, $decoded->{'lon'}]).bindPopup('$$MCC$MNC$CIcounter;accuracy $decoded->{'accuracy'} meters $decoded->{'address'}').addTo(thepoints);") ;
$centre = "center: [$decoded->{'lat'},$decoded->{'lon'}]," ;
}

&pretty_print($judul."BTS.html" , $mapfooter) ;



#########  penutupan  ###############

&pretty_print($judul."BTS.html" , $mapfooter1) ;
#		center: [35.7559646,51.2273134],

&pretty_print($judul."BTS.html" , $centre) ;

&pretty_print($judul."BTS.html" , $mapfooter2) ;



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