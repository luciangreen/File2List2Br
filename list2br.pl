%% list2br.pl

%% converts a list of words to br
%% - shows last 10 assignments with br count
%% - asks if want 128k or other for next br
%% - seamlessly tries next list, warning if exhausted

%%:-include('mergetexttobrdict.pl').

%%**** load:`['../Text-to-Breasonings/text_to_breasonings.pl'].`


%% this file

:-include('../listprologinterpreter/la_strings.pl').

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).


list2br :- 	prep_l2b(File_contents_list_term,File_contents_assignments_term1
	),
	
	br1_l2b(File_contents_list_term,File_contents_assignments_term1,File_contents_assignments_term2),
	term_to_atom(File_contents_assignments_term2,File_contents_assignments_atom),
	(open_s("assignment_db.txt",write,Stream),
	write(Stream,File_contents_assignments_atom),
	close(Stream)),
 	!.

	
prep_l2b(File_contents_list_term,File_contents_assignments_term) :-
	
phrase_from_file_s(string(File_contents_list2), "list_db.txt"),

string_codes(File_contents_list1,File_contents_list2),
atom_string(File_contents_list,File_contents_list1),

term_to_atom(File_contents_list_term,File_contents_list),

	length(File_contents_list_term,Length1),write("Number of breasoning databases: "), writeln(Length1),


phrase_from_file_s(string(File_contents_assignments2), "assignment_db.txt"),

string_codes(File_contents_assignments1,File_contents_assignments2),
atom_string(File_contents_assignments,File_contents_assignments1),

term_to_atom(File_contents_assignments_term,File_contents_assignments),

	length(File_contents_assignments_term,Length2),write("Number of previous assignments: "), writeln(Length2),

!.

sum(A,B) :-
A=[C|D],sum(C,D,0,B).
sum(A,[],B,C):-C is A+B,!.
sum(A,B,C,D):-B=[E|F],G is A+C,sum(E,F,G,D).

%%C is A+B.

br1_l2b(File_contents_list_term,File_contents_assignments_term1,File_contents_assignments_term2) :-
	length(File_contents_assignments_term1,Ass_length),
	(Ass_length=<10->New_ass=File_contents_assignments_term1;
	B is 10,length(New_ass,B),append(_,New_ass,File_contents_assignments_term1)),
	writeln("10 Previous Assignments and Breasoning Counts"),
	findall(_,(member(C,New_ass),writeln(C)),_),
	%%writeln(""),
	findall(E,(member(D,File_contents_assignments_term1),D=[_,E]),F), sum(F,G),
	findall(H,(member(I,File_contents_list_term),I=[_,H]),J), sum(J,K),
	L is round(100*(G/K)),
	
	write(G),write(" of "),write(K),write(" breasonings ("),write(L),writeln("%) used."),
	
	(repeat,write("Enter the subject and assignment number: "),
	read_string(user_input, "\n", "\r", _NC1, NC2)),
	
	(repeat,write("Enter <Return> for 128k breasonings in this assignment, or the number of breasonings: "),
	read_string(user_input, "\n", "\r", _NB1, NB2),split_string(NB2, "", " ", NB3),
NB3=[NB4],(NB4=""->NB5=128000;number_string(NB5,NB4))),
	
	append(File_contents_assignments_term1,[[NC2,NB5]],File_contents_assignments_term2),
	
	%%(File_contents_list_term=[]->(concat_list(["Error: Database is empty."],A),
   %%writeln(A),abort);
	(find_br1(File_contents_list_term,G,NB5,0,[],Text_term),
	% convert to string
	term_to_atom(Text_term,Text_atom),
	string_atom(Text_string,Text_atom),
	% t2b2

	%%writeln1(Text_string),
	
	texttobr2(u,u,Text_string,u,true,false,false,false,false,false),
	texttobr(u,u,Text_string,u))%%
.

%% if last list, give warning, count so far and text

%% ** if past, error
find_br1([],_Start,_Len_needed,_Len_so_far1,_Text1,_Text2) :-
	concat_list(["Error: Start is past end of database."],A),
   writeln(A),abort.
find_br1(File_contents_list_term,Start,Len_needed,Len_so_far1,Text1,Text2) :-

%%trace,

	File_contents_list_term=[[_Filename,Len]|Rest],
	Len_so_far2 is Len_so_far1+Len,
	(Len_so_far2 > Start -> 
		(
find_br2(File_contents_list_term,Start,Len_needed,Len_so_far1,Text1,Text2)
); %% Len_so_far2 < Start
(%%Len_so_far2 is Len_so_far1+Len,
Len_so_far3 is 0,%%Start2 is 0,Len_needed2 is Len_needed-B.
Start2 is Start-Len,
find_br1(Rest,Start2,Len_needed,Len_so_far3,Text1,Text2)))
.

%% find text from file
find_br2([],_Start,Len_needed,_Len_so_far1,Text,Text) :-
	concat_list(["Warning: End of database has been reached. ",Len_needed," breasonings remaining."],A), writeln(A).

find_br2(File_contents_list_term,Start,Len_needed,Len_so_far1,Text1,Text2) :-
	File_contents_list_term=[[Filename,Len]|Rest],

phrase_from_file_s(string(File_contents_newlist2), Filename),

string_codes(File_contents_newlist1,File_contents_newlist2),
atom_string(File_contents_newlist0,File_contents_newlist1),
downcase_atom(File_contents_newlist0,File_contents_newlist),

term_to_atom(File_contents_newlist_term,File_contents_newlist),
%%trace,

	Start_of_list is Start-Len_so_far1,
	Len_to_end_of_list is Len - Start_of_list,

(Len_needed=<Len_to_end_of_list->(%%trace,
C is Start_of_list%-1
,length(Texta,Len_needed),length(A,C),append(A,F,File_contents_newlist_term),append(Texta,_,F),append(Text1,Texta,Text2));
(

B is %%Len_needed
Len-Start,length(Texta,B),append(_,Texta,File_contents_newlist_term),append(Text1,Texta,Text3),

%text is computed v
Len_so_far2 is 0,Start2 is 0,Len_needed2 is Len_needed-B,%%Len_so_far1+Len, 
find_br2(Rest,Start2,Len_needed2,Len_so_far2,Text3,Text2)) %% go to next list ***
).

