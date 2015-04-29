require 'FileUtils'

#step 1: make directories, one for each pdf.
#      directory names are PDF filenames less the .pdf extension.
#      move PDFs into the appropriate directories.
#detailed notes, first block: 
#(1) dir variable contains a relative path, as we wanted to use to generalize this script.
#(2) mkdir_p: -p option required because we're creating a subdirectory.
#(3) cp: allows pdfs to remain in the pdfs/ yet get ~copied~ to the created directory.  
dir = Dir["./pdfs/*.pdf"]
dir.each do |pdf|
	dirname = File.basename(pdf, ".pdf")
	FileUtils.mkdir_p("results/#{dirname}")
	FileUtils.cp pdf, "results/#{dirname}"
end

#step 2: create contents file listing only the DSpace "bitstream."
#detailed notes, block 2:
#(1) For the dir variable, could only get the **ABSOLUTE PATH** to work;
#    consequently the dir variable will need to be edited everytime the script is used.
#(2) this cycles through the subdirectories.
#(3) backticks are used as a blocking operation, sending ls to the shell.
#(4) ls results are piped to grep (matching).
#(5) grep does an invert match with -v, matching everything ~not~ "contents."
#(6) Finally all is output to a file named "contents."
#(7) When the block ends, the pwd is the subdirectory.
dir = Dir["/Users/theodore/Documents/uwl/som/working-dir/results/*"]
dir.each do |subdir|
	        Dir.chdir("#{subdir}")
`ls | grep -v contents > contents`
end

#step 2.1: change back to directory /Users/theodore/Documents/uwl/som/som-mar2015/
#See step 2.7 above for an explanation why this is necessary.
#Uses an **ABSOLUTE PATH** that will need to be edited everytime the script is used. 
Dir.chdir("/Users/theodore/Documents/uwl/som/working-dir")

#step 3: transform spreadsheet-based XML to DSpace-ready XML.
#This step sends commands to the shell using backticks. 
#step 3a. invoke the Saxon XSLT processor using java -jar.
#step 3b. enter source XML file (-s: ). Recommended: use absolute path.**ABSOLUTE PATH**.
#step 3c. enter path to the transform (-xsl: ). Recommended: use **ABSOLUTE PATH**.
`java -jar /usr/local/bin/SaxonHE9-5-6J/saxon9he.jar -s:/Users/theodore/Documents/uwl/som/working-dir/som-programs.xml -xsl:/Users/theodore/Documents/uwl/som/working-dir/excelXML2dspaceXML_v1_1.xsl` 
