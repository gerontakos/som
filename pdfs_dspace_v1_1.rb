require 'FileUtils'

#step 1: make directories, one for each pdf.
#      directory names are PDF filenames less the .pdf extension.
#      move PDFs into the appropriate directories

#below: 
#(1) dir variable contains a relative path, but it works OK here.
#mkdir_p: not sure the  
dir = Dir["./pdfsCopy/*.pdf"]
dir.each do |pdf|
	dirname = File.basename(pdf, ".pdf")
	FileUtils.mkdir_p("results/#{dirname}")
	FileUtils.cp pdf, "results/#{dirname}"
end

#puts Dir.pwd 

#step 2: create contents file; use backticks as a blocking operation
dir = Dir["/Users/theodore/Documents/uwl/som/som-apr2015/results/*"]
dir.each do |subdir|
	        Dir.chdir("#{subdir}")
`ls | grep -v contents > contents`
end
#in the above, we need to cd back to dir

#puts Dir.pwd

#step 2.1: change back to directory /Users/theodore/Documents/uwl/som/som-mar2015/
#Not sure why this is necessary since the 
Dir.chdir("/Users/theodore/Documents/uwl/som/som-apr2015")

#step 3: transform spreadsheet-based XML to DSpace-ready XML; use backticks
#      step 3a. invoke the Saxon XSLT processor using java -jar.
#      step 3b. enter the source XML file (-s: ). Recommended: use absolute path.
#      #step 3c. enter the path to the transform (-xsl: ). Recommended: use absolute path.
#      java -jar /usr/local/bin/SaxonHE9-5-6J/saxon9he.jar -s:/Users/theodore/Desktop/som_copy_prep/pdfs_copy/SOM_programMetadata4ResearchWorks_copy.xml -xsl:createXML_v0_7_2014-10-04_copy.xsl 
`java -jar /usr/local/bin/SaxonHE9-5-6J/saxon9he.jar -s:/Users/theodore/Documents/uwl/som/som-apr2015/som-programs-subset_repaired_edited.xml -xsl:/Users/theodore/Documents/uwl/som/som-apr2015/excelXML2dspaceXML_v1_0_COPY.xsl` 
