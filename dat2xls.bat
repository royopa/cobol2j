REM Usage: dat2xml.bat <xc2j-file> <datafile>

java -cp .;lib\commons-logging-1.1.1.jar;lib\commons-lang-2.4.jar;lib\xercesImpl.jar;lib\cobol2j-1.5.4.jar;lib\cb2xml.jar;lib\poi-3.1-FINAL.jar;lib\jaxb-impl-2.1.13.jar;lib\jaxb-api-2.2.jar net.sf.cobol2j.examples.Dat2xls %1 < %2 > %2.xls
