REM Usage: dat2xml.bat <xc2j-file> <datafile>

java -cp .;lib\commons-logging-1.1.1.jar;lib\cobol2j-1.5.4.jar;lib\jaxb-impl-2.1.13.jar;lib\jaxb-api-2.2.jar net.sf.cobol2j.examples.Dat2csv %1 < %2 > %2.csv
