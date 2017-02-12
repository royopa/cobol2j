REM Usage: xc2j2talend.bat <schema.xc2j>

java -cp lib\xalan.jar;lib\serializer.jar;lib\xml-apis.jar;lib\xercesImpl.jar org.apache.xalan.xslt.Process -IN %1 -XSL xc2j2talend.xsl -OUT nul