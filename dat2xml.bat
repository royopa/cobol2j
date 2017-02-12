REM Usage: dat2xml.bat <xc2j-file> <datafile>

java -cp .;lib\xalan.jar;lib\serializer.jar;lib\xml-apis.jar;lib\cb2xml2cobol2j.jar;lib\commons-logging-1.1.1.jar;lib\xercesImpl.jar;lib\cobol2j-1.5.4.jar;lib\cb2xml.jar;lib\jaxb-impl-2.1.13.jar;lib\jaxb-api-2.2.jar net.sf.cobol2j.examples.Dat2xml %1 < %2 > %2.xml
