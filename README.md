<div id="banner"><a href="" id="bannerLeft">![](images/ebcdic.png)</a> 

<div class="clear">

* * *

</div>

</div>

<div id="breadcrumbs">

<div class="xleft">Last Published: 2009-01-18</div>

<div class="clear">

* * *

</div>

</div>

<div id="leftColumn">

<div id="navcolumn">

##### Start

*   **Manual 1.5**
*   [Manual 1.4](manual-1.4.html)
*   [Downloads](http://sourceforge.net/project/platformdownload.php?group_id=156330)
*   [Forum](http://sourceforge.net/forum/forum.php?forum_id=524917)
*   [Tracker](http://sourceforge.net/tracker/?group_id=156330)

##### Project Documentation

*   [Project Information](project-info.html)
*   [Project Reports](project-reports.html)

[![SourceForge.net](http://sflogo.sourceforge.net/sflogo.php?group_id=156330&type=2)](http://www.sourceforge.net "SourceForge.net") </div>

</div>

<div id="bodyColumn">

<div id="contentBox"><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<div class="section">

## <a name="Introduction"></a>Introduction

There are still mainframes, vms and as400s arround us plugged into a power. The aim of the project is to facilitate reading their data files stored in EBCDIC or PC format and give you possibility to do with them what you want.

cobol2j is a java library written to read original EBCDIC data file which comes from COBOL or RPG system. It also reads files already converted from EBCDIC to ASCII. The advantage of cobol2j is that it reads data types like: numeric fields ( signed and unsigned ), packed decimals, packed date and text fields. Those fields come from ancient 70s times when people saved work and paper. Paper? Yes, data came to 70s-puters on a paper and it was reasonable to pack two digits on one byte in BCD format to save it.

My first cobol2j application was a programatic interface to another system. Another application was to present some AS/400 data on the web page. cobol2j gives you mainframe data as Java Bean. Then you can create pdf, excel file, generate sql statements to import data to a database or just connect to database with JDBC and push in all you read with cobol2j.

</div>

<div class="section">

## <a name="Installation_and_system_requirements"></a>Installation and system requirements

Unzip cobol2j zip content to any location i.e. on your Desktop. For your reference the absolute path will be on English MS Windows: C:\Documents and Settings\username\Desktop\cobol2j-1.5 ( but it doesn't really matter :)

The only requirement is Java Runtime Environment (JRE **5** as a minimum) installed on your system. Most new pc comes with Java already. Please check your java with following instruction:

Open "Command prompt" or any other terminal window and type:

<div class="source">

<pre>java -version</pre>

</div>

You should see something similar to this:

<div class="source">

<pre>C:\Documents and Settings\username\Desktop\cobol2j-1.3>java -version
java version "1.5.0_11"
Java(TM) 2 Runtime Environment, Standard Edition (build 1.5.0_11-b03)
Java HotSpot(TM) Client VM (build 1.5.0_11-b03, mixed mode)
</pre>

</div>

</div>

<div class="section">

## <a name="Short_background"></a>Short background

<div class="section">

### <a name="Things_you_need_to_know_about_your_data"></a>Things you need to know about your data

#### 1\. Data file encoding - optional if you have already an ASCII file

There are many code pages in both EBCDIC and ASCII world and you should know source and destination code pages for your data. This point is optional when you use native EBCDIC to ASCII export facilities that comes with EBCDIC machines ).

#### 2\. Data structure - mandatory

Reading EBCDIC text-only file requires EBCDIC to ASCII conversion tables and knowledge of codepages only. It is relatively easy operation and it is even available on some web pages as online web converters. cobol2j challenge is to read flat data files with record structure ( very often more than one record structure in one file! ) : text, numeric, date, packed decimals, zoned, signed and unsigned fields, etc. This require you to know data structure because such source files are binary files and simple text conversion will not do the job here. The knowledge of data structure is required even if your in-house EBCDIC to ASCII conversion is already done. Simple knowledge of data structure is enought. There is no need of any special file but can be very usefull.

</div>

<div class="section">

### <a name="Two_types_of_input_data:"></a>Two types of input data:

#### original EBCDIC

Fresh untuched binary data without conversion errors is very welcome input data for cobol2j. It requires to choose right EBCDIC to ASCII conversion table and to define a data structure.

#### ASCII data file

You have a file that is already preprocessed with some external tools. There are also environments where cobol or RPG data are processed in ASCII format. Baby/36 is an example. In that case the fist part of the job is already done and the only thing you should need to do is to define the data structure of the file.

Some data files may have conversion errors. It is quite common that you have a file converted from EBCDIC to ASCII in the way like it was a text file only. cobol2j provides some auto-correction facilities and let you read some bad files with 0% data loss. Here are two cases when input files are in error:

##### Case 1 - wrong code page

The file was converted with wrong table. Then it can be read by cobol2j but text fields will have some bad characters.

##### Case 2 - Binary data file converted as it is text file

The file was converted as it was text-only file. It still can be read by cobol2j. Text fields will be ok. Non-packed signed and unsigned numeric fields are corrected with automatic failover machanism. Packed decimal and date fields will be corupted. No way to recover original values except you know applied conversion tables. Failover not supported now.

##### Case 3 - Conversion added some record separator

Some external tools could added one ot more bytes at the end of every record. You can tell it to cobol2j defining value of "newLineSize" attribute in FileFormat tag

</div>

</div>

<div class="section">

## <a name="Command_line_users_steps"></a>Command line user's steps

The following steps should convert your proprietary data into xml or excel ( also proprietary :) format using build-in example cobol2j's classes arranged in DOS *.bat scripts. The scripts are very basic and requires minimal effort to translate into *nix scripts. For repeatable, stable and well definied conversions we recommend to use cobol2j API directly in your own program. See next section "API user steps"

Before you can issue a command you need to open a terminal or command line window and change the directory with cobol2j. It will be our sandbox. So please also copy there all files you want to process. It will be C:\Documents and Settings\username\Desktop\cobol2j-1.3 in our case. The folder has been created in section "Installation and system requirements" on your Windows desktop.

To get there: Click menu "Start" -> "Run" and type cmd in the "Open" field. Black command line window will open.

<div class="source">

<pre>C:\Documents and Settings\username\> cd Desktop\cobol2j-1.3
C:\Documents and Settings\username\Desktop\cobol2j-1.3>
    </pre>

</div>

<div class="section">

### <a name="a1._Create_file_format_xc2j_xml_document"></a>1\. Create file format (xc2j) xml document

#### With cobol copybook

Thanks to cb2xml - another sf.net project adopted into cobol2j - you can create xc2j file format without any serious knowledge about xml if you have cobol copybook file.

Cobol copybook file looks similar to that:

<div class="source">

<pre>01  PATIENT-TREATMENTS.
       05  PATIENT-NAME                PIC X(30).
       05  PATIENT-SS-NUMBER           PIC 9(9).
       05  NUMBER-OF-TREATMENTS        PIC 99 COMP-3.
       05  TREATMENT-HISTORY OCCURS 0 TO 50 TIMES
              DEPENDING ON NUMBER-OF-TREATMENTS
              INDEXED BY TREATMENT-POINTER.
           10  TREATMENT-DATE.
               15  TREATMENT-DAY        PIC 99.
               15  TREATMENT-MONTH      PIC 99.
               15  TREATMENT-YEAR       PIC 9(4).
           10  TREATING-PHYSICIAN       PIC X(30).
           10  TREATMENT-CODE           PIC 99.
                </pre>

</div>

If you have such a file ( say: example.cpy ) then you can create xc2j xml file with following command:

<div class="source">

<pre>> cb2xc2j.bat example.cpy
                </pre>

</div>

It will produce example.cpy.xc2j file required for your data conversion.

##### Important `cb2xc2j` defaults

You should consider to tune up those parameters if your data don't come directly from mainframe. I.e. it is preprocessed already.

*   Cp037 table as opposite to ASCII
*   0 bytes between records
*   Big endianess of comp-1 and comp-2 data fields as opposite to little for PC data

#### From scratch

You may not have an access to cobol copybook for many reasons but you still have a knowledge about data structure in another form. Then you have to prepare your definition in xc2j file manually in a text or xml editor. The xml schema is in [FileFormat.xsd](http://cobol2j.cvs.sourceforge.net/*checkout*/cobol2j/cobol2j/src/xml/FileFormat.xsd) file. Here is an example xc2j structure definition file obtained by processing above copybook: [example.cpy.xc2j](./example.cpy.xc2j)

![](images/schema1.5.png)

<table class="bodyTable">

<tbody>

<tr class="a">

<th>Cobol type</th>

<th>RPG type</th>

<th>Java type</th>

<th>cobol2j type definition</th>

<th>Remarks</th>

</tr>

<tr class="b">

<td>Character ( text )  
PIC X(30).</td>

<td>Character (A) or blank</td>

<td>java.lang.String</td>

<td>X</td>

<td>just text</td>

</tr>

<tr class="a">

<td>COMP-1</td>

<td>Float (F)</td>

<td>java.lang.Float</td>

<td>1</td>

<td>4-byte floating-point  
big endian ( mainframe data )</td>

</tr>

<tr class="b">

<td>COMP-1</td>

<td>Float (F)</td>

<td>java.lang.Float</td>

<td>7</td>

<td>4-byte floating-point  
little endian ( PC data )</td>

</tr>

<tr class="a">

<td>COMP-2</td>

<td>Double (F)</td>

<td>java.lang.Double</td>

<td>2</td>

<td>8-byte floating-point  
big endian ( mainframe data )</td>

</tr>

<tr class="b">

<td>COMP-2</td>

<td>Double (F)</td>

<td>java.lang.Double</td>

<td>8</td>

<td>8-byte floating-point  
little endian ( PC data )</td>

</tr>

<tr class="a">

<td>COMP-3  
PACKED DECIMAL  
PIC S9(5)V99 COMP-3</td>

<td>Numeric - Packed decimal (P)</td>

<td>java.math.BigDecimal</td>

<td>3</td>

</tr>

<tr class="b">

<td>Zoned decimal  
PIC S9(5)V99</td>

<td>Numeric - Zoned format (S)</td>

<td>java.math.BigDecimal</td>

<td>9</td>

</tr>

<tr class="a">

<td>COMP, COMP-4, BINARY  
PIC S9(4) COMP  
PIC S9(9) BINARY  
USAGE IS INDEX</td>

<td>Numeric - Integer format(I)  
Numeric - Unsigned format (U)</td>

<td>java.math.BigDecimal</td>

<td>B</td>

</tr>

<tr class="b">

<td>DATE and/or TIME  
PIC 9(7) COMP-3</td>

<td>Date (D)  
Time (T)  
Timestamp (Z)</td>

<td>supported via COMP-3 type</td>

</tr>

<tr class="a">

<td>Double-byte character (DBCS)  
PIC G(n)</td>

<td>Graphic (G)</td>

<td>not supported yet</td>

</tr>

<tr class="b">

<td>Special "types"</td>

</tr>

<tr class="a">

<td>any</td>

<td>any</td>

<td>byte[]</td>

<td>T</td>

<td>returns data "as is" in binary format  
"transparent"</td>

</tr>

<tr class="b">

<td>any</td>

<td>any</td>

<td>java.lang.String</td>

<td>H</td>

<td>this let you see data as text hexadecimal  
for debug purpose</td>

</tr>

</tbody>

</table>

</div>

<div class="section">

### <a name="a2._Preliminary_dat_file_processing"></a>2\. Preliminary dat file processing

#### Time for a dessert ( or a real job :)

Copy your dat file to the same directory you created on your desktop ( say: example.dat ) and issue a command:

<div class="source">

<pre>> dat2xml.bat example.cpy.xc2j example.dat
or
> dat2xls.bat example.cpy.xc2j example.dat
                </pre>

</div>

It should create example.dat.xml or example.dat.xls file ready to use or ... will fail if data definition in xc2j file doesn't mach data file structure.

We cannot go deep into records structure because it is your job. We can help with common problems about some metainformation like:

##### Ensure or experiment with conversion table

Try to view the dat file using type ( Windows ), tail or cat ( *nix ) command. If it looks like this site graphic banner at the top of this site - it is EBCDIC file and requires that "ConversionTBL" atribute of FileFormat be set to "net.sf.cobol2j.tables.EBCDIC_037_TO_ISO_8859_1" what is the default.

If you recognize some characters then it means it is already ASCII file and "ConversionTBL" atribute of FileFormat should be set to "net.sf.cobol2j.tables.NO_CONVERSION"

##### Possible end of record byte(s) in ASCII dat file

Try to calculate if dat file size divided by record size gives integer. If not then experiment to set "newLineSize" to 1 or even 2

If it doesn't help then hexdump your dat file an dtry to tune up xc2j file to mach data structure.

##### adjust example.xc2j ... and try again ...

</div>

</div>

<div class="section">

## <a name="API_users_steps"></a>API user's steps

The section is not yet ready.

Some inspiration for API usage can be an example package with [Dat2xls.java](http://cobol2j.cvs.sourceforge.net/*checkout*/cobol2j/cobol2j/src/java/net/sf/cobol2j/examples/Dat2xls.java) and [Dat2xml.java](http://cobol2j.cvs.sourceforge.net/*checkout*/cobol2j/cobol2j/src/java/net/sf/cobol2j/examples/Dat2xml.java)

</div>

</div>

</div>

<div class="clear">

* * *

</div>

<div id="footer">

<div class="xright">© 2009</div>

<div class="clear">

* * *

</div>

</div>
