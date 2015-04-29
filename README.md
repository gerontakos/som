PROCEDURE
PDF COLLECTIONS INTO DSPACE
University Of Washington Libraries
Written by Theo Gerontakos
April 24, 2015

This procedure describes how to get a pdf collection into DSpace. To upload other format collections beside PDFs, this procedure can be altered (the scripts would also have to be altered). This would not be terribly difficult; if you would like assistance, Theo in University Libraries/CaMS is the person to talk to.

Operating system: Unix or Linux or Mac (or Windows with a bash shell)

Shell: bash

Required software: oXygen XML Editor, Ruby programming language processor, Saxon XSLT processor, Java (a Java Runtime Environment, “JRE,” works fine; JDK includes the JRE, so that’s fine too). Java and Ruby are invoked from the command line so they will need to be accessible via $PATH (that’s an environment variable).

1. Digital Project Manager: create your PDFs with simple numerical filenames, starting with 1.pdf, 2.pdf, 3.pdf..., and store them in a folder "pdfs."


2. Digital Project Manager: create a spreadsheet with exactly one row per pdf. Each row must contain a cell referencing the pdf file described in that row; the value will be exactly the same as the filename: 1.pdf, 2.pdf, 3.pdf, etc. Describe only one resource per row. Also, although you can use any column headings that make sense to you, it is best to use column headings that correspond to DSpace Dublin Core properties. If that is not done at this stage, it will be done by the data processor in step 6.


3. Data Processor: create a working directory on a workstation with the software listed above. Name it “working-dir” (you can name it anything you like, but in this procedure we’ll refer to it as “working-dir”).


4. Move your "pdfs" directory and your Excel spreadsheet into the “working-dir“ directory.


5. Convert the .xlsx spreadsheet to the older .xls format. (Recommended: use MS Excel. We found Open Office introduces corruption during this conversion. However, we have not tested MS Excel’s capability to handle this conversion accurately.) (Do this only if you are using oXygen to convert the spreadsheet to XML, which can only convert .xls files, not xlsx; if you have another method you prefer to convert the .xlsx to XML, you can skip to step 6, then convert to XML with you preferred method, then skip step 7 and move on to step 8.) 


6. Change or edit the column headings to DSpace Dublin Core as in the following examples: the column of values intended for DSpace's dc.title.alternative" property should be headed "title.alternative;" the column of values intended for DSpace's "dc.description.abstract" should be headed "description.abstract;" the column intended for DSpace's property "dc.contributor" (i.e. a property without a qualifier) should be headed "contributor,” etc. If you don’t know what to do here, you can work with Theo or staff in Digital Initiatives (Anne Graham) on a mapping of your column headings to DSpace properties.


7. Open oXygen; import the spreadsheet:
--File > Import > MS Excel File.
—select your "sheet;" hopefully everything is on Sheet 1.
--click "First row contains field names.”
--leave checked "Import formatted data (as displayed in Excel).”
--click "Customize.”
--root should remain "root;" row should remain "row."
--if necessary, change the "XML Name" for the elements to correspond with DSpace Dublin Core, as described in step 5 above. 
--get rid of any unnamed “Heading” elements; if these exist, you’ll have to fuss with the spreadsheet to get rid of them; something in the spreadsheet indicated to oXygen that empty columns are “live” and have value. Good luck!
--select OK then, on the resulting screen, "Import.”
--select “Cancel” to make the Import dialogue go away.
--save to your XML file in your “working-dir” directory.


8. Data Processor: load the xslt script “excelXML2dspaceXML_v1_1.xsl" into the “working-dir“ directory. —> There will need to be some changes to the XSLT script to accommodate your project. At present work with Theo on this. In short, the main changes: the second template needs xsl:when conditional statements to provide and special processing rules particular nodes. At present everything is accepted as-is with column headings turned into attribute values. In the case of the School of Music Programs, “date” values were in the following format: m/d/yyyy. This needed to be changed to ISO format, so special xsl:when conditional statements were required.

9. Data Processor: load the ruby script "pdfs_dspace_V1_1.rb" into the “working-dir“ directory. —> There will need to be some edits to the ruby script to accommodate your project. At present work with Theo on this. In short: all absolute paths should be edited. These should be easy to spot in the script nearby comments that contain the phrase “**ABSOLUTE PATH**.”


10. Data Processor: run the ruby script at the command line as follows: "ruby pdfs_dspace_[version#].rb" which, at present, would look like this: ruby pdfs_dspace_v1_1.rb


11. Data Processor: check the results; there should be: (a) in one containing directory named “results,” one sub-directory for each file, named according to the pdf file name minus the .pdf extension, as follows: 1, 2, 3, 4, 5…; in each such sub-directory there should be three files: (i) the corresponding pdf with its simple numerical filename; (ii) a dublin_core.xml file containing XML metadata describing only the accompanying pdf file using correct DSpace elements and attributes; (iii) a file named "contents" (no file extension) listing the pdf being uploaded.


12. If all passes quality assurance review, move your “working-dir” directory (with all subdirectories containing your files) to the upload location provided to you by Digital Initiatives.


13. ITS should be notified that files are prepared to be uploaded. Sample message: “To Whom It May Concern at ITS: We have 172,346 directories ready for DSpace upload. Location: \[electronicLocation]\working-dir. Upload into Collection: [target DSpace collection name], [target DSpace collection uri].”


14. You will be notified that either the upload failed and you need to edit your files somehow or, preferably, your collection has successfully uploaded.


15. Once loaded in DSpace, check the files to make sure the PDFs and metadata loaded accurately. If so, you're done; if not, troubleshoot and repair until done.