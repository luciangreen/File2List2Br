# File2List2Br

Automates high distinctions for large files.

* file2list.pl - generates files that are lists of breasonings (words that earn high distinctions) from files
* list2br.pl - converts a list of words to breasonings
- shows last 10 assignments with breasoning count
- asks if the user wants 128k breasonings (4000 breasonings or 50 As * 80 breasonings, * 4 for 100%, * 2 for student and to do lecturer's work, * 2 for University and an industry seen-as version * 2 for the student and their friend) or another value for an assignment
- seamlessly tries next list, warning if past end of database, and giving error if database has been finished

# Getting Started

Please read the following instructions on how to install the project on your computer for automating high distinctions for large files.

# Prerequisites

Install List Prolog Interpreter Repository (https://github.com/luciangreen/listprologinterpreter).

Install Text to Breasonings Repository (https://github.com/luciangreen/Text-to-Breasonings).


# Installation from List Prolog Package Manager (LPPM)

* Optionally, you can install from LPPM by installing <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine, downloading the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>,
```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
```
loading LPPM with `['lppm'].` then installing the package by running `lppm_install("luciangreen","File2List2Br").`.

# Installing and Running File2List2Br

* Download the repositories above and save them in a single folder.
* Save a large file in Terminal as a text file.
* Split the file `split -b 4000000 file.txt`.
* Load `file2list1` by entering `['file2list.pl'].` and run with the command e.g. `file2list1(["fileout_txt.aa","fileout_txt.ab"]).` where the file names are the split files from the previous step.  Don't close the window.
* In `list_db.txt`, enter the file names of the files generated by `file2list1` and their breasoning counts output from `file2list1`, e.g.
```
[["t-tmp.txt",12],["a-tmp.txt",2]]
```
* NB. You can use BBEdit to delete parts of the output and replace with `\t (tab)` so that the breasoning count can be separated from the unique breasonings in Excel, and then use replacements in BBEdit to format the list.  You can use `reverse(Input,Output).` in swipl to reverse lists.  Be careful that the filenames correspond to the correct breasoning count.
* In the File2List2Br folder, in SWI-Prolog, enter:
```
['../Text-to-Breasonings/text_to_breasonings.pl'].
```
* Load `list2br.pl` by entering `['list2br.pl'].` and run with the command `list2br.`.
```
Number of breasoning databases: 2
Number of previous assignments: 1
10 Previous Assignments and Breasoning Counts
[Comment,0]
0 of 14 breasonings (0%) used.
Enter the subject and assignment number: 
```
* Enter the university or school subject and the info about the assignment.
```
Enter <Return> for 128k breasonings in this assignment, or the number of breasonings:
```
* Press `Return` for 128000 breasonings, assuming there are enough in the database (if you would like to given the reasons above) or enter another value.
```
Number of words in dictionary: 11746
Number of unique breasonings in dictionary: 662
Number of words to breason out in file: 1
Number of unique words in file: 1
Number of unique breathsonings in dictionary: 364
true.
```
* You will be asked to breason out new words.
* You can delete this info in the `assignment_db.txt` database later to e.g. redo or increase the breasoning number and redo.

### Caution:

follow instructions in <a href="https://github.com/luciangreen/listprologinterpreter/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details

