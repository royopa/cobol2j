java -jar lib/cb2xml.jar $1 > $1.xml
java -cp lib/xalan.jar:lib/serializer.jar:lib/xml-apis.jar:lib/xercesImpl.jar org.apache.xalan.xslt.Process -IN $1.xml -XSL cb2xml2cobol2j.xsl -OUT $1.xc2j
