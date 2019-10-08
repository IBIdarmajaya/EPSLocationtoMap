# EPSLocationtoMap S
decode EPSLocationInformation to the Decimal and render it to Map

THe Output Sh interface (please refer to 3GPP TS 29.328 and TS 32.329) contains the EPSLocationInformation
that presented with encoded to Base64.  
Unlike common decode that displayed directly in ASCII format, this decoding need to be presented in Hexa Bytes Format.
and the final Format would be in Decimal Format of MCC MNC ECGI and Map also generated in Decimal format.

# Prerequisite 
1.in order to request the ECGI/LTE Cell database in towards Unwiredlabs.com (OpenCellId) , user need to sign up to get the Token.
Without token user can only avail the Decimal format but not get any Map Generated.
2.PERL script with few library is used that easily to get from CPAN.


#How To Use
perl EPSLocationInformationToMap.pl <E-UTRANCellGlobalId> <Unwiredlabs> -> can get Decimal and Map in HTML if token is correct
perl EPSLocationInformationToMap.pl <E-UTRANCellGlobalId> <Unwiredlabs> -> can get Decimal Only without Map in HTML if token is incorrect

