@echo ----------
@echo This script is depreciated and is left for experimental and debug purposes only.
@echo Please use cb2xc2j.bat instead.
@echo ----------
@echo Experiment file. More usage example than a production script.
@echo Imports COBOL copybook and creates out.xc2j file - cobol2j data file definition.
@echo Works only when copybook file is in the same directory as this file.
REM Usage: copybook.bat <copybook.cpy>
java -jar lib\cb2xml.jar %1 > %1.xml
java -cp lib\xalan.jar;lib\serializer.jar;lib\xml-apis.jar;lib\xercesImpl.jar org.apache.xalan.xslt.Process -IN %1.xml -XSL cb2xml2cobol2j.xsl -OUT %1.xc2j
