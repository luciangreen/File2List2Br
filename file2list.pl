%% file2list.pl

%% converts a file to a list in filelist.txt

%%:-include('mergetexttobrdict.pl').
:-include('la_strings').

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).


file2list1(Files) :- 
%%Files=["fileout_txt.aa","fileout_txt.ab"],
findall(_,(member(File1,Files),file2list(File1)),_).


file2list(File1) :- 	prep(File1,List1),
	
	string_concat(File1,"list.txt",File2),
	(open_s(File2,write,Stream),
	write(Stream,List1),
	close(Stream)),
 	!.

truncate(List1,M,String0) :-
	((number(M),length(String0,M),
	append(String0,_,List1))->true;
	String0=List1),!.
	
prep(File1,List) :-
	SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",

	phrase_from_file_s(string(String00), File1)),
	
	split_string(String00,SepandPad,SepandPad,List),

	length(List,Length1),write("Number of words in file: "), writeln(Length1),
	sort(List,List2),
%%writeln([list2,List2]),
	length(List2,Length2),write("Number of unique words in file: "), writeln(Length2)
	
,!.
