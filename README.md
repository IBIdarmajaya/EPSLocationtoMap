# EPSLocationtoMap 
decode EPSLocationInformation to the Decimal and render it to Map

THe Output Sh interface (please refer to 3GPP TS 29.328 and TS 29.329) contains the EPSLocationInformation
that presented with encoded in Base64 format.  
Unlike common decode from Base64 format that ussually displayed directly in ASCII format, this decoding need to be presented in Hexa Bytes Format.
and the final Format would be in Decimal Format of MCC MNC ECGI and Map also generated in HTML format.

# Prerequisite 
1.in order to request the ECGI/LTE Cell database in towards Unwiredlabs.com (OpenCellId) , user need to sign up to get the Token.
Without token user can only avail the Decimal format but not get any Map Generated.

2.PERL script with few library is used, which is very easy to get and install from CPAN (if you familiar with PERL module).


# How To Use

perl EPSLocationInformationToMap.pl [E-UTRANCellGlobalId] [Token] -> can get Decimal and Map in HTML if token is correct
  
perl EPSLocationInformationToMap.pl [E-UTRANCellGlobalId] [Token] -> can get Decimal Only without Map in HTML if token is incorrect

# MAP

The Point where E-NodeB located is not visible with immediate effect when user first time open the HTML, user need to click the 'Layers' in up-right corners and  click 'Thepoints' and then Voiiilaaa, Bazingaaaa, you can see the point in the map there.
