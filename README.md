PROCEDURE
PDF COLLECTIONS INTO DSPACE
Written by Theo Gerontakos
April 24, 2015

This procedure describes how to get a pdf collection into DSpace. To upload other format collections beside PDFs, this 
procedure can be altered (the scripts would also have to be altered). This would not be terribly difficult; if you would 
like assistance, Theo in CaMS is the person to talk to.

Operating system: Unix or Linux or Mac (of Windows with a bash shell)
Shell: bash
Required software: oXygen XML Editor, Ruby programming language processor, Saxon XSLT processor.

1. Digital Project Manager: create your PDFs with simple numerical filenames, starting with 1.pdf, 2.pdf, 3.pdf..., and 
store them in a folder "pdfs."

2. Digital Project Manager: create a spreadsheet with exactly one row per pdf. Each row must contain a cell referencing 
the pdf file described in that row; the value will be exactly the same as the filename: 1.pdf, 2.pdf, 3.pdf, etc. 

Describe only one resource per row. Also, although you can use any column headings that make sense to you, it is best to 
use column headings that correspond to DSpace Dublin Core properties. If that is not done at this stage, it must be done 
by the data processor in step 5.

3. Data Processor: create a working directory on a workstation with a Ruby processor, oXygen XML Editor, and an XSLT 
processor. Name it according to the project name; we'll call that directory "projectName" in this procedure.

You can move you "pdfs" directory and your Excel spreadsheet into the "projectName" directory.
 
4. Convert the .xlsx spreadsheet to the older .xls format.

5. Change or edit the column headings to DSpace Dublin Core as follows: the column of values intended for DSpace's 
"dc.title.alternative" property should be headed "title.alternative;" the column of values intended for DSpace's 
"dc.description.abstract" should be headed "description.abstract;" the column intended for DSpace's property 
"dc.contributor" (i.e. a property wthout a qualifer) should be headed "contributor."

6. Open oXygen; import the speadsheet:
--File > Import > MS Excel File
--Select your "sheet;" hopefully everything is on Sheet 1
--click "First row contains field names"
--leave checked "Import formatted data (as displayed in Excel)
--Click "Customize"
--root can remain "root;" row can remain "row."
--if necessary, change the "XML Name" for the elements to correspond with DSpace Dublin Core, as described in step 5 above. 
--Select OK then, on the resulting screen, "Import"
--save to your XML file in your "projectName" directory.

7. Data Processor: copy the xslt script 
"diginit$/SchoolofMusicPrograms/Theo_files_2015/scripts_final/excelXML2dspaceXML_[version#].xsl" into the "projectName" 
directory.

There will probably need to be some changes to the XSLT script to accommodate your project. At present work with Theo on this.

8. Data Processor: copy the ruby script 
"diginit$/SchoolofMusicPrograms/Theo_files_2015/scripts_final/pdfs_dspace_[version#].rb" into the "projectName" 
directory.

There will probably need to be some edits to the ruby script to accommodate your project. At present work with theo on this.

9. Data Processor: run the ruby script at the command line as follows: "ruby pdfs_dspace_[version#].rb"

10. Data Processor: check the results; there should be:
--one directory for each file, named according to the pdf file name minus the .pdf extension, as follows: 1, 2, 3, 4, 5...
--in that directory:
    --the corresponding pdf with its simple numerical filename
    --a dublin_core.xml with metadata decribing only the accompanying pdf file and with correct DSpace elements and attributes
    --a file named "contents" (no file extension) listing the pdf being uploaded.

11. If all passes quality assurance review, move your "projectName" directory (with all subdirectories containing your 
files) to \DSpaceImport$. 

12. ITS (Anjanette) should be notified that files are prepared to be uploaded. 
sample message: 
To Whom It May Concern at ITS: 
We have 172,346 directories ready for DSpce upload. 
Location: \DSpaceImport\projectName
Upload into: 
[target DSpace collection name]
[target DSpace collection uri]

13. You will be notified that either the upload failed and you need to edit your files somehow or, preferably, your 
collection has successfully uploaded.

15. Once loaded in DSpace, check the files to make sure the PDFs and metadata loaded accurately. If so, you're done; if 
not, troubleshoot and repair until done.
