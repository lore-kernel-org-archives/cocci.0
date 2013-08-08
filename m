From: neleai@seznam.cz (=?utf-8?B?T25kxZllaiBCw61sa2E=?=)
Date: Thu, 8 Aug 2013 08:50:34 +0200
Subject: [Cocci] [PATCH] Fix typos.
In-Reply-To: <alpine.DEB.2.02.1308010859510.2047@localhost6.localdomain6>
References: <20130728134848.GA18947@domone.kolej.mff.cuni.cz>
 <alpine.DEB.2.02.1308010859510.2047@localhost6.localdomain6>
Message-ID: <20130808065000.GA24061@domone.kolej.mff.cuni.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 01, 2013 at 09:02:57AM +0200, Julia Lawall wrote:
> Thanks for the patch.
> 
> Could you send me an email including both the patch and
> 
>         Signed-off-by: Random J Developer <random@developer.example.org>
> 
> (adjusted appropriately) with the same meaning as in the Linux kernel 
> (Documentation/SubmittingPatches, section 12).
> 
> Thanks!
>
Added signed-of-by,

It turned out that there was problem with following hunk containing unicode:
-(* dont work :( let ( ? ) f g x = f(g(x)) *) 

I now tested that saving mail as it is followed by git apply works.
> julia
> 
> On Sun, 28 Jul 2013, Ond?ej B?lka wrote:
> 
> > Hi, I am writing tool to help with style issues, see
> > https://github.com/neleai/stylepp
> > 
> > One area that I have almost ready is fixing typos, so I prepared patch
> > with it. 
> > 
> > It works by supplying a replacement dictionary and then it replaces all
> > occurences in comments and only in comments. (see 
> > script/stylepp_spell_patch which I used.)
> > 
> > Main obstacle here was mixing english and french as my program
> > cannot recognize language of comments yet and I had to delete false
> > positives. If you know a program that can recognize language I would be
> > grateful.
> > 
> > To simplify review I used additional tools. To make more readable what
> > changed I wrote a tool that sorts and summarizes diff, output of
> > git diff origin_master | stylepp_strip_diff
> > is bellow.
> > 
> > This is followed by patch itself. Changes there are sorted by alphabeth
> > which I obtained by command:
> > git diff origin_master | stylepp_sort_diff
> > 
> > Comments?
> >                                             ^
-    attibutes [attr].  After printing, the attributes are
-    automatically reseted to the defaults, unless autoreset is turned
+    attributes [attr].  After printing, the attributes are
+    automatically reset to the defaults, unless autoreset is turned
-    [arg1],...,[argN] according to [format] with the attibutes [attr].
-    After printing, the attributes are automatically reseted to the
+    [arg1],...,[argN] according to [format] with the attributes [attr].
+    After printing, the attributes are automatically reset to the
-                * failed. Le try limite le scope des crashes pendant la
-                * trasformation au fichier concerne. *)
+                * failed. Le try limit le scope des crashes pendant la
+                * transformation au type concerne. *)
- * from the dbm, before marshalling. This is useful for instance if you
- * want to store objects such as oset. Indeed we cant marshall
+ * from the dbm, before marshalling. This is useful for instance if you
+ * want to store objects such as oset. Indeed we cannot marshall
- * traditionnal data structures before marshalling them, and you have
- * to rebuild the object from the traditionnal data structure when you
- * get them from the dbm. Hence fv/unv. You can do the same for the key
+ * traditional data structures before marshalling them, and you have
+ * to rebuild the object from the traditional data structure when you
+ * get them from the dbm. Hence fv/unv. You can do the same for the key
ge the other commons_xxx libraries by \n-explicitely building them after he has 
ge the other commons_xxx libraries by \n+explicitly building them after he has i
                                                ^^                             
 and afters to the instantiated code *) \n let extra_copy_stmt_plus model e =   
 and afters to the instantiated code *) \n let extra_copy_stmt_plus model e =   
                                        ^                                      
 would have preferred a  \n-** real bus astraction, btw). \n */                 
 would have preferred a  \n+** real bus abstraction, btw). \n */                
                                         ^                                     
ith aft \n-given None, because they can accomodate their own directives or comme
ith aft \n+given None, because they can accommodate their own directives or comm
                                            ^^                                 
nce and tone of each of the contributor acknowledgements \n and/or dedications g
nce and tone of each of the contributor acknowledgments \n and/or dedications gi
                                                 ^^                            
 stopping and interrupting the CPU. The additionnal  \n ** interrupt flags are s
 stopping and interrupting the CPU. The additional  \n ** interrupt flags are st
                                              ^ ^                              
- to handle the braces, need again pass additionnal info. \n *                  
- to handle the braces, need again pass additional info. \n *                   
                                              ^ ^                              
ted case, casedefault)) we need to pass additionnal info. \n * The start/exit wh
ted case, casedefault)) we need to pass additional info. \n * The start/exit whe
                                              ^ ^                              
its goal point, then  \n-** there is no additionnal residual. \n */             
its goal point, then  \n+** there is no additional residual. \n */              
                                              ^ ^                              
iled \n-* or .spatch_ok), and also some additionnal strings to be printed in \n 
iled \n+* or .spatch_ok), and also some additional strings to be printed in \n *
                                              ^ ^                              
tatement. \n-* But in some cases we add additionnal stuff in which case we don't
tatement. \n+* But in some cases we add additional stuff in which case we don't 
                                              ^ ^                              
SIMPLE + TAG using a single MOVE. \n-** Agressive optimization, is'nt it? \n ** 
SIMPLE + TAG using a single MOVE. \n+** Aggressive optimization, is'nt it? \n **
                                         ^^                                    
*************************) \n-(* change algo *) \n (****************************
*************************) \n+(* change algorithm *) \n (***********************
                                            ^   ^                              
d avoid the intervise \n-* (but yes the algo are then more complex :) \n * opti:
d avoid the intervise \n+* (but yes the algorithm are then more complex :) \n * 
                                            ^   ^                              
                * \n-* todo: cf book on algo, a la rivest/sedgewick \n * todo: r
                * \n+* todo: cf book on algorithm, a la rivest/sedgewick \n * to
                                            ^   ^                              
i to e. If you want to do that, use the appropiate \n * wrapper get_local_ii_of_
i to e. If you want to do that, use the appropriate \n * wrapper get_local_ii_of
                                              ^                                
-** completed the command before we won abitration, \n ** send a M_ABORT message
+** completed the command before we won arbitration, \n ** send a M_ABORT messag
                                         ^                                     
 \n-(* subtil: don't forget to give all argumens to f, otherwise partial app \n 
 \n+(* subtil: don't forget to give all arguments to f, otherwise partial app \n
                                               ^                               
r->green.length == 5) { \n-bpp--; /* an artifical value - 15 */ \n }            
r->green.length == 5) { \n+bpp--; /* an artificial value - 15 */ \n }           
                                               ^                               
------------------- *) \n-(* note: that assignement is not a statement but an ex
------------------- *) \n+(* note: that assignment is not a statement but an exp
                                             ^^                                
he done queue that may break any  \n-** assomption from the C code if we are int
he done queue that may break any  \n+** assumption from the C code if we are int
                                           ^                                   
on \n-phase when typedef information is availalble *) \n and initialiser = initi
on \n+phase when typedef information is available *) \n and initialiser = initia
                                             ^^                                
       \n-/* go to next scatter list if availavle */ \n if (SCpnt->SCp.this_resi
       \n+/* go to next scatter list if available */ \n if (SCpnt->SCp.this_resi
                                              ^                                
       \n-/* go to next scatter list if availavle */ \n if (SCpnt->SCp.this_resi
       \n+/* go to next scatter list if available */ \n if (SCpnt->SCp.this_resi
                                              ^                                
es); \n-if (res == 0) { /* if some data avilable ? */ \n if (stat == BUSPHASE_DA
es); \n+if (res == 0) { /* if some data available ? */ \n if (stat == BUSPHASE_D
                                          ^                                    
LUN and TASK(s)  \n-** concerned by the cancelation. \n ** If it is not ABORT_TA
LUN and TASK(s)  \n+** concerned by the cancellation. \n ** If it is not ABORT_T
                                             ^^                                
gna \n-* we have Signed explicitly ? we cant "accrocher" this mcode to \n * some
gna \n+* we have Signed explicitly ? we cannot "accrocher" this mcode to \n * so
                                           ^^                                  
 forces us to do a token type that \n-* cant be a pair of a sum type, it must be
 forces us to do a token type that \n+* cannot be a pair of a sum type, it must 
                                           ^^                                  
o it that way. The ocamlyacc token \n-* cant be a pair of a sum type, it must be
o it that way. The ocamlyacc token \n+* cannot be a pair of a sum type, it must 
                                           ^^                                  
             \n-(* want or of merd, but cant cos cant put die ... in b (strict c
             \n+(* want or of merd, but cannot cos cannot put die ... in b (stri
                                           ^           ^                       
os found in ".h"  \n-*     but where we cant detect that it will be a "bad macro
os found in ".h"  \n+*     but where we cannot detect that it will be a "bad mac
                                           ^^                                  
 correctly parsed \n-*     but where we cant detect that it will be a "bad macro
 correctly parsed \n+*     but where we cannot detect that it will be a "bad mac
                                           ^^                                  
os found in ".h"  \n-*     but where we cant detect that it will be a "bad macro
os found in ".h"  \n+*     but where we cannot detect that it will be a "bad mac
                                           ^^                                  
 correctly parsed \n-*     but where we cant detect that it will be a "bad macro
 correctly parsed \n+*     but where we cannot detect that it will be a "bad mac
                                           ^^                                  
                              try \n-(* cant do input_line chan::aux() cos ocaml
                              try \n+(* cannot do input_line chan::aux() cos oca
                                           ^^                                  
        let rec cat_aux acc ()  = \n-(* cant do input_line chan::aux() cos ocaml
        let rec cat_aux acc ()  = \n+(* cannot do input_line chan::aux() cos oca
                                           ^^                                  
a collection(i,a) at the same time. But cant do that. \n *   So for array, I see
a collection(i,a) at the same time. But cannot do that. \n *   So for array, I s
                                           ^^                                  
                                  \n-(* cant do this: \n *    let rec (lg: ('a g
                                  \n+(* cannot do this: \n *    let rec (lg: ('a
                                           ^^                                  
n-(*  [  ] [      TODO? could have [ so cant englobe right now, but would be bet
n+(*  [  ] [      TODO? could have [ so cannot englobe right now, but would be b
                                           ^^                                  
n-(*  [  ] [      TODO? could have [ so cant englobe right now, but would be bet
n+(*  [  ] [      TODO? could have [ so cannot englobe right now, but would be b
                                           ^^                                  
meopt, typ)), iivirg -> \n-(* first var cant have a preceding ',' *) \n assert (
meopt, typ)), iivirg -> \n+(* first var cannot have a preceding ',' *) \n assert
                                           ^^                                  
idot, expr)), iivirg -> \n-(* first var cant have a preceding ',' *) \n assert (
idot, expr)), iivirg -> \n+(* first var cannot have a preceding ',' *) \n assert
                                           ^^                                  
                             \n-(* rene cant have found that a state containing 
                             \n+(* rene cannot have found that a state containin
                                           ^^                                  
: faire = graphe (int can change !!! => cant make simply =) \n reassign number f
: faire = graphe (int can change !!! => cannot make simply =) \n reassign number
                                           ^^                                  
parser. It is ugly code \n-* because we cant modify ocamllex and ocamlyacc. As w
parser. It is ugly code \n+* because we cannot modify ocamllex and ocamlyacc. As
                                           ^^                                  
* the bubble never goes at top and so I cant really C-c. \n *                   
* the bubble never goes at top and so I cannot really C-c. \n *                 
                                           ^^                                  
 in body of dowhile \n-* (whereas While cant return None). But if return None, c
 in body of dowhile \n+* (whereas While cannot return None). But if return None,
                                           ^^                                  
* Have to build a new node (clone), cos cant share it. \n * update: This is now 
* Have to build a new node (clone), cos cannot share it. \n * update: This is no
                                           ^^                                  
 the obj.func object notation. In OCaml cant use '.' so I use +> \n *           
 the obj.func object notation. In OCaml cannot use '.' so I use +> \n *         
                                           ^^                                  
********************************) \n-(* cant use parser as it's a reseverd word 
********************************) \n+(* cannot use parser as it's a reseverd wor
                                           ^^                                  
                            \n-(* note: cant use partial application with let ms
                            \n+(* note: cannot use partial application with let 
                                           ^^                                  
= 'Z' \n-then (* perhaps the begin of a captialized identifier *) \n Buffer.add_
= 'Z' \n+then (* perhaps the begin of a capitalized identifier *) \n Buffer.add_
                                           ^^                                  
for all i (cos to go from S1[1..i] to 0 characteres of S2 you have to delete all
for all i (cos to go from S1[1..i] to 0 characters of S2 you have to delete all 
                                                ^^                             
******) \n-(* N-ary tree with updatable childrens *) \n (***********************
******) \n+(* N-ary tree with updatable children *) \n (************************
                                               ^^                              
              \n-(* note: less need for cloneable, copyable as in Java. Only nee
              \n+(* note: less need for clonable, copyable as in Java. Only need
                                           ^^                                  
damental interfaces \n-* here ? such as cloneable, equaable, showable, debugable
damental interfaces \n+* here ? such as clonable, equaable, showable, debugable,
                                           ^^                                  
ruct value as is easily \n-* - take the comparaison function in parameters (=> f
ruct value as is easily \n+* - take the comparison function in parameters (=> fu
                                             ^^                                
 and still allows to preserve linux-2.0 compatibilty. \n ** In fact, it is mostl
 and still allows to preserve linux-2.0 compatibility. \n ** In fact, it is most
                                                  ^                            
------------------------------ *) \n-(* Contraint on Identifier and Function *) 
------------------------------ *) \n+(* Constraint on Identifier and Function *)
                                           ^                                   
 something which allows to retrieve the controler type, unit, \n ** target, lun 
 something which allows to retrieve the controller type, unit, \n ** target, lun
                                              ^^                               
in cocci_vs_c.ml, to have a more direct correspondance between \n * the ast_cocc
in cocci_vs_c.ml, to have a more direct correspondence between \n * the ast_cocc
                                                  ^                            
 device and  \n-** put them back in the correponding LUN queue, then   \n ** req
 device and  \n+** put them back in the corresponding LUN queue, then   \n ** re
                                             ^                                 
 SCRIPTS. \n-** Read the amount of data correponding to the  \n ** message lengt
 SCRIPTS. \n+** Read the amount of data corresponding to the  \n ** message leng
                                             ^                                 
ode, the second is the tokens \n-in the descendents *) \n let minus_table =     
ode, the second is the tokens \n+in the descendants *) \n let minus_table =     
                                               ^                               
er booted the O/S from another O/S that did'nt enable  \n **   the multiplier fo
er booted the O/S from another O/S that didn't enable  \n **   the multiplier fo
                                           ^^                                  
SCSI BIOS is present. \n-** - SCSI BIOS did'nt enable the multiplier for some re
SCSI BIOS is present. \n+** - SCSI BIOS didn't enable the multiplier for some re
                                           ^^                                  
? because sometimes want disable it but dont \n * want put the cache_computation
? because sometimes want disable it but don't \n * want put the cache_computatio
                                           ^                                   
n such as Out_of_memory, \n-* but as we dont add directly but only at flush time
n such as Out_of_memory, \n+* but as we don't add directly but only at flush tim
                                           ^                                   
n such as Out_of_memory, \n-* but as we dont add directly but only at flush time
n such as Out_of_memory, \n+* but as we don't add directly but only at flush tim
                                           ^                                   
rams but no parens found: " ^ s); \n-(* dont apply the macro, perhaps a redefini
rams but no parens found: " ^ s); \n+(* don't apply the macro, perhaps a redefin
                                           ^                                   
  } \n-(* 'x is a ('a * 'b) but in fact dont care about 'b, we just tag the SP *
  } \n+(* 'x is a ('a * 'b) but in fact don't care about 'b, we just tag the SP 
                                           ^                                   
(* may launch Not_found, but this time, dont catch it *) \n let v = !wrapped#ass
(* may launch Not_found, but this time, don't catch it *) \n let v = !wrapped#as
                                           ^                                   
(* may launch Not_found, but this time, dont catch it *) \n let v = !wrapped#ass
(* may launch Not_found, but this time, don't catch it *) \n let v = !wrapped#as
                                           ^                                   
cpp "In Initializer passing"; (* cheat: dont count in stat *) \n incr Stat.nIfde
cpp "In Initializer passing"; (* cheat: don't count in stat *) \n incr Stat.nIfd
                                           ^                                   
al search on the file, he will see that dont exist anymore and \n *    so using 
al search on the file, he will see that don't exist anymore and \n *    so using
                                           ^                                   
expansion. \n-* Only subtelity is maybe dont expand the TDefineIdent. \n *      
expansion. \n+* Only subtelity is maybe don't expand the TDefineIdent. \n *     
                                           ^                                   
avariables used after, and that we \n-* dont find any such region, then mysat() 
avariables used after, and that we \n+* don't find any such region, then mysat()
                                           ^                                   
? could, but \n-* in ograph_extended we dont force the user to have a key and we
? could, but \n+* in ograph_extended we don't force the user to have a key and w
                                           ^                                   
                                  \n-(* dont forget that cmd_to_list call bash a
                                  \n+(* don't forget that cmd_to_list call bash 
                                           ^                                   
es. \n-*  - if use -z for glimpseindex, dont forget the -z too for glimpse \n * 
es. \n+*  - if use -z for glimpseindex, don't forget the -z too for glimpse \n *
                                           ^                                   
prf e = bigf.kexpr (k,bigf) e \n-(* !!! dont go in _typ !!! *) \n and k ((e,_typ
prf e = bigf.kexpr (k,bigf) e \n+(* !!! don't go in _typ !!! *) \n and k ((e,_ty
                                           ^                                   
                                  \n-(* dont go in _typ *) \n | TypeName (name,_
                                  \n+(* don't go in _typ *) \n | TypeName (name,
                                           ^                                   
                            \n-(* todo? dont go in Include. Have a visitor flag 
                            \n+(* todo? don't go in Include. Have a visitor flag
                                           ^                                   
                  vk_type bigf t; \n-(* dont go in tbis *) \n attrs +> List.iter
                  vk_type bigf t; \n+(* don't go in tbis *) \n attrs +> List.ite
                                           ^                                   
this to be passed as hof, because ocaml dont have \n * haskell "section" operato
this to be passed as hof, because ocaml don't have \n * haskell "section" operat
                                           ^                                   
e have also typeQualifier but they \n-* dont have sense. I put this to factorise
e have also typeQualifier but they \n+* don't have sense. I put this to factoris
                                           ^                                   
use 'it' special keyword ? \n-* In fact dont have to name it, use +> (fun v -> .
use 'it' special keyword ? \n+* In fact don't have to name it, use +> (fun v -> 
                                           ^                                   
d else \n-(* todo? put more condition ? dont ifdefize declaration ? *) \n true  
d else \n+(* todo? put more condition ? don't ifdefize declaration ? *) \n true 
                                           ^                                   
occi2("\n",_,_,_,_)) as x)::xs -> \n-(* dont inline in expr because of weird eva
occi2("\n",_,_,_,_)) as x)::xs -> \n+(* don't inline in expr because of weird ev
                                           ^                                   
                           * \n-* And I dont like having too much files, especia
                           * \n+* And I don't like having too much files, especi
                                           ^                                   
n-(* could do a print_string but printf dont like print_string *) \n let echo s 
n+(* could do a print_string but printf don't like print_string *) \n let echo s
                                           ^                                   
eElem contains just '-' information. We dont need to add \n * stuff in the envir
eElem contains just '-' information. We don't need to add \n * stuff in the envi
                                           ^                                   
to use glimpse \n-*    cos we use -l so dont need to know what is the place of t
to use glimpse \n+*    cos we use -l so don't need to know what is the place of 
                                           ^                                   
       \n-(* Pass only "true" comments, dont pass TCommentMisc and TCommentCpp *
       \n+(* Pass only "true" comments, don't pass TCommentMisc and TCommentCpp 
                                           ^                                   
se of DeclList, in    int i,*j[23];  we dont print anymore the \n int before *j 
se of DeclList, in    int i,*j[23];  we don't print anymore the \n int before *j
                                           ^                                   
       \n-(* todo: pas beau le seed.  I dont put the type otherwise have to \n *
       \n+(* todo: pas beau le seed.  I don't put the type otherwise have to \n 
                                           ^                                   
ome Makefile for our \n-* big-tests. So dont remove. \n *)                      
ome Makefile for our \n+* big-tests. So don't remove. \n *)                     
                                           ^                                   
 \n-(*  Str.split, but lines "\n1\n2\n" dont return the \n and forget the first 
 \n+(*  Str.split, but lines "\n1\n2\n" don't return the \n and forget the first
                                           ^                                   
                         * \n-* Here we dont use the keep argument of julia. cf 
                         * \n+* Here we don't use the keep argument of julia. cf
                                           ^                                   
mation available in flow_to_ast, but we dont want \n * to polluate both files.  
mation available in flow_to_ast, but we don't want \n * to polluate both files. 
                                           ^                                   
               (* coccionly: \n-pad: if dont want cocci write: \n failwith      
               (* coccionly: \n+pad: if don't want cocci write: \n failwith     
                                           ^                                   
n-(* if process a big set of files then dont want get overflow in the middle \n 
n+(* if process a big set of files then don't want get overflow in the middle \n
                                           ^                                   
ng, kindstring) assoc ? \n-* Because we dont want that a variable shadow a struc
ng, kindstring) assoc ? \n+* Because we don't want that a variable shadow a stru
                                           ^                                   
                      z = 4; \n-} // we dont want that it add both foo on the } 
                      z = 4; \n+} // we don't want that it add both foo on the }
                                           ^                                   
                  else \n-(* subtil: we dont want the '...' to match until the \
                  else \n+(* subtil: we don't want the '...' to match until the 
                                           ^                                   
                \n-(* Trick in case you dont want to do an 'open Common' while s
                \n+(* Trick in case you don't want to do an 'open Common' while 
                                           ^                                   
                          * \n-* Also I dont want to mix code with data structur
                          * \n+* Also I don't want to mix code with data structu
                                           ^                                   
rated \n-* and in our case we sometimes dont want to visit too much. For instanc
rated \n+* and in our case we sometimes don't want to visit too much. For instan
                                           ^                                   
       et compose f g x = f (g x) \n-(* dont work :( let ( ? ) f g x = f(g(x)) *
       et compose f g x = f (g x) \n+(* don't work :( let ( ? ) f g x = f(g(x)) 
                                           ^                                   
e \n-* if file contain chazarain_j then dont work with -w \n *)                 
e \n+* if file contain chazarain_j then don't work with -w \n *)                
                                           ^                                   
                         o#length \n-(* dont work: \n method big_union: 'b. ('a 
                         o#length \n+(* don't work: \n method big_union: 'b. ('a
                                           ^                                   
   * \n-* Note: because now the info is embeded in the name, the info for \n * e
   * \n+* Note: because now the info is embedded in the name, the info for \n * 
                                            ^^                                 
ons possible de paire      *) \n-(* par exemple combinaison [1;2;4] -> [1, 2; 1,
ons possible de paire      *) \n+(* par example combinaison [1;2;4] -> [1, 2; 1,
                                          ^                                    
Interv (i1, i2-1))::aux xs ys (* -1 cos exlude [ *) \n (*  [    ] *)            
Interv (i1, i2-1))::aux xs ys (* -1 cos exclude [ *) \n (*  [    ] *)           
                                          ^                                    
ult, so if in signa \n-* we have Signed explicitely ? we cant "accrocher" this m
ult, so if in signa \n+* we have Signed explicitly ? we cannot "accrocher" this 
                                                ^           ^                  
\n-building spatch, checks whether some featues work (python and ocaml scripts, 
\n+building spatch, checks whether some features work (python and ocaml scripts,
                                             ^                                 
 analysis results, which for the moment focusses on integers. \n * The lower bou
 analysis results, which for the moment focuses on integers. \n * The lower boun
                                           ^ ^                                 
es the ast. But I prefer do it \n-* the functionnal way. \n *                   
es the ast. But I prefer do it \n+* the functional way. \n *                    
                                              ^ ^                              
                                  \n-(* grammer = parser ot tokens *) \n (* type
                                  \n+(* grammar = parser ot tokens *) \n (* type
                                             ^                                 
 newcount = cocci_count + 2 in (* count incuding space *) \n let future_count = 
 newcount = cocci_count + 2 in (* count including space *) \n let future_count =
                                           ^                                   
\n-let newcount = count + 2 in (* count incuding space *) \n let future_count = 
\n+let newcount = count + 2 in (* count including space *) \n let future_count =
                                           ^                                   
                            /* \n-**    Initialise ncr_device structure with ite
                            /* \n+**    Initialize ncr_device structure with ite
                                                ^                              
                               /* \n-** Initialyze the CCB free queue and, \n **
                               /* \n+** Initialize the CCB free queue and, \n **
                                               ^                               
                               /* \n-** Initialyze the start and restart actions
                               /* \n+** Initialize the start and restart actions
                                               ^                               
ons like List.find, List.mem \n-* which internaly use this convenient but evolut
ons like List.find, List.mem \n+* which internally use this convenient but evolu
                                               ^^                              
y forall is needed, but need check same lenth too*) \n with _ -> false          
y forall is needed, but need check same length too*) \n with _ -> false         
                                           ^                                   
lock held, so: \n-** - We are uselessly loosing a couple of micro-seconds to loc
lock held, so: \n+** - We are uselessly losing a couple of micro-seconds to lock
                                        ^ ^                                    
**************************) \n-(* Scope managment (cocci) *) \n (***************
**************************) \n+(* Scope management (cocci) *) \n (**************
                                             ^                                 
**************************) \n-(* Error managment *) \n (***********************
**************************) \n+(* Error management *) \n (**********************
                                             ^                                 
ist * 'x) -> \n-string (* extension for marshalled dependencies *) -> \n (unit -
ist * 'x) -> \n+string (* extension for marshaled dependencies *) -> \n (unit ->
                                             ^ ^                               
 filename -> \n-string (* extension for marshalled object *) -> \n (filename lis
 filename -> \n+string (* extension for marshaled object *) -> \n (filename list
                                             ^ ^                               
  | Some ia1, ebs -> \n-(* allow ',' to maching nothing. optional comma trick *)
  | Some ia1, ebs -> \n+(* allow ',' to matching nothing. optional comma trick *
                                          ^                                    
arrow for this \n-* target. Clear flag. Negotation on request sense. \n * Note: 
arrow for this \n+* target. Clear flag. Negotiation on request sense. \n * Note:
                                             ^                                 
-* the parameter and then replace their occurence in the body in a Tident. \n * 
+* the parameter and then replace their occurrence in the body in a Tident. \n *
                                            ^^                                 
oid.  Also, unitarily is represented as occuring once, \n while nonunitarily is 
oid.  Also, unitarily is represented as occurring once, \n while nonunitarily is
                                            ^^                                 
XX: NSP_QUIRK \n-* data phase skip only occures in case of SCSI_LOW_READ \n */  
XX: NSP_QUIRK \n+* data phase skip only occurs in case of SCSI_LOW_READ \n */   
                                            ^^                                 
                                  \n-(* optimisation allowing to launch coccinel
                                  \n+(* optimization allowing to launch coccinel
                                              ^                                
               * \n-* todo? alternative optimisation for the include problem: \n
               * \n+* todo? alternative optimization for the include problem: \n
                                              ^                                
Ast.unwrap ast with \n-(* the following optimisation is not a good idea, because
Ast.unwrap ast with \n+(* the following optimization is not a good idea, because
                                              ^                                
                                  \n-(* Optimisation. Try not unparse/reparse th
                                  \n+(* Optimization. Try not unparse/reparse th
                                              ^                                
 list \n-* are kind of sorted, so could optimise the insert_set operations. \n *
 list \n+* are kind of sorted, so could optimize the insert_set operations. \n *
                                              ^                                
 everything to async 8 bit \n-** - Tell ourself to negotiate next time :-) \n **
 everything to async 8 bit \n+** - Tell ourselves to negotiate next time :-) \n 
                                              ^ ^                              
c:main" *) \n-(* local function that is parameterized by whether to launch gv *)
c:main" *) \n+(* local function that is parametrized by whether to launch gv *) 
                                              ^^                               
f a resizer function, this \n-time of a parameterized resizer. \n               
f a resizer function, this \n+time of a parametrized resizer. \n                
                                              ^^                               
pted inside the SCRIPTS  \n-** critical pathes, we can safely restart the SCRIPT
pted inside the SCRIPTS  \n+** critical paths, we can safely restart the SCRIPTS
                                           ^^                                  
                exit) \n-(* worry about perf, but seems correct, not ax *) \n (c
                exit) \n+(* worry about performance, but seems correct, not ax *
                                            ^     ^                            
ow store them in Ast_c ? \n-* store all posible variations in ast_c ? a list of 
ow store them in Ast_c ? \n+* store all possible variations in ast_c ? a list of
                                          ^^                                   
n-(* an attribute is an identifier that preceeds another identifier and \n begin
n+(* an attribute is an identifier that precedes another identifier and \n begin
                                             ^^                                
he following flag setting. So this code propably \n * will generate a NotParsedC
he following flag setting. So this code probably \n * will generate a NotParsedC
                                           ^                                   
and_ns = ctl_and CTL.NONSTRICT in \n-(* proces bef_aft *) \n let shortest l =   
and_ns = ctl_and CTL.NONSTRICT in \n+(* process bef_aft *) \n let shortest l =  
                                             ^^                                
> true  (* unreachable memory, thus any propery holds *) \n | IntSet s          
> true  (* unreachable memory, thus any property holds *) \n | IntSet s         
                                              ^                                
                       * \n-* Perform a psuedo DMA mode read from an NCR53C400 o
                       * \n+* Perform a pseudo DMA mode read from an NCR53C400 o
                                          ^^                                   
                       * \n-* Perform a psuedo DMA mode read from an NCR53C400 o
                       * \n+* Perform a pseudo DMA mode read from an NCR53C400 o
                                          ^^                                   
 it should be build_and here?  we don't realy have multiple \n minirules anymore
 it should be build_and here?  we don't really have multiple \n minirules anymor
                                           ^^                                  
et the BUS. \n-** Are these assumptions reasonnable ? (Wait and see ...) \n */  
et the BUS. \n+** Are these assumptions reasonable ? (Wait and see ...) \n */   
                                            ^ ^                                
 ensure that when we call aux_statement recursivly, we \n * pass it xi_lbl and n
 ensure that when we call aux_statement recursively, we \n * pass it xi_lbl and 
                                                ^                              
                     \n-(* get the node refered by the suffix link at [n] *) \n 
                     \n+(* get the node referred by the suffix link at [n] *) \n
                                            ^^                                 
                     \n-(* get the node refered by the suffix link at [n] *) \n 
                     \n+(* get the node referred by the suffix link at [n] *) \n
                                            ^^                                 
       \n-let typeC r k e = (* not sure relevent because "only after iso" *) \n 
       \n+let typeC r k e = (* not sure relevant because "only after iso" *) \n 
                                             ^                                 
rser) and return something and the \n-* remaing list of stuff. *) \n type ('a, '
rser) and return something and the \n+* remaining list of stuff. *) \n type ('a,
                                             ^^                                
        /* \n-** C1010_66MHz rev 0 part requies AIPCNTL1 bit 3 to be set. \n */ 
        /* \n+** C1010_66MHz rev 0 part requires AIPCNTL1 bit 3 to be set. \n */
                                             ^                                 
tate and that those states \n-* are not reseted between each test file, then hav
tate and that those states \n+* are not reset between each test file, then havin
                                            ^^                                 
); \n-(* todo: should be even stronger, shoud be i > min+1 *) \n assert (i > min
); \n+(* todo: should be even stronger, should be i > min+1 *) \n assert (i > mi
                                            ^                                  
 gathering them. Same for logging. \n-* Similiar to the type prof = PALL | PNONE
 gathering them. Same for logging. \n+* Similar to the type prof = PALL | PNONE 
                                            ^^                                 
        * \n-* Sometimes we want to add someting at the beginning or at the end 
        * \n+* Sometimes we want to add something at the beginning or at the end
                                             ^                                 
                                  \n-(* specialised \n let (string_of_list: char
                                  \n+(* specialized \n let (string_of_list: char
                                                ^                              
N status. \n-** Prepare all needed data strutures for getting  \n ** sense data.
N status. \n+** Prepare all needed data structures for getting  \n ** sense data
                                            ^                                  
control flow it matches, and the set of subsitutions for this match. \n *)      
control flow it matches, and the set of substitutions for this match. \n *)     
                                            ^                                  
tall the interrupt handler. \n-** If we synchonize the C code with SCRIPTS on in
tall the interrupt handler. \n+** If we support the C code with SCRIPTS on inter
                                         ^    ^                                
ync (wide), \n-**       it CAN transfer synch (wide). \n */                     
ync (wide), \n+**       it CAN transfer sync (wide). \n */                      
                                           ^^                                  
--------- \n-** negotiation of wide and synch transfer and device quirks. \n ** 
--------- \n+** negotiation of wide and sync transfer and device quirks. \n ** s
                                           ^^                                  
                            \n-/* setup synch transfer registers */ \n nsp_index
                            \n+/* setup sync transfer registers */ \n nsp_index_
                                           ^^                                  
TR message, \n-**       it CAN transfer synch. \n */                            
TR message, \n+**       it CAN transfer sync. \n */                             
                                           ^^                                  
ily detect \n-* it, cos the '=' sign is syntaxically overloaded in caml. It is a
ily detect \n+* it, cos the '=' sign is syntactically overloaded in caml. It is 
                                             ^^                                
arse_c.ml \n-* (now have other mark for tha matter). \n *)                      
arse_c.ml \n+* (now have other mark for the matter). \n *)                      
                                          ^                                    
                           } \n-/* fall thru */ \n default:                     
                           } \n+/* fall through */ \n default:                  
                                           ^  ^                                
        /* \n-** The device wants us to tranfer more data than  \n ** expected o
        /* \n+** The device wants us to transfer more data than  \n ** expected 
                                            ^                                  
       \n-/* Check to see if we need to trucate the output */ \n if ( outputBuff
       \n+/* Check to see if we need to truncate the output */ \n if ( outputBuf
                                           ^                                   
       \n-/* Check to see if we need to trucate the output */ \n if ( outputBuff
       \n+/* Check to see if we need to truncate the output */ \n if ( outputBuf
                                           ^                                   
ent tous les fichiers texte. \n-* Si le fichier texte est trop petit, contient p
ent tous les fichiers texte. \n+* Si le type texte est trop petit, contient par 
                                        ^                                      
r + 1' where dma_addr was declared as a varialbe \n * of type dma_addr_t, then a
r + 1' where dma_addr was declared as a variable \n * of type dma_addr_t, then a
                                             ^^                                
 *) \n-(*   (\* Parse CONFIG.SYS to see wether it has the right line *\) *) \n (
 *) \n+(*   (\* Parse CONFIG.SYS to see whether it has the right line *\) *) \n 
                                         ^                                     
. The programmer should not be bothered wether this \n * flag is set via args cm
. The programmer should not be bothered whether this \n * flag is set via args c
                                         ^                                     
h_no_body.c \n-* but I don't think it's worthwile to handle \n * such pathologic
h_no_body.c \n+* but I don't think it's worthwhile to handle \n * such pathologi
                                              ^                                

Signed-off-by: Ond?ej B?lka <neleai@seznam.cz>
                                
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -731,7 +731,7 @@ static void MDELAY(long ms) { while (ms--) UDELAY(1000); }
 **	is guaranteed for power of 2 cache line size.
 **	Enhanced in linux-2.3.44 to provide a memory pool per pcidev 
 **	to support dynamic dma mapping. (I would have preferred a 
-**	real bus astraction, btw).
+**	real bus abstraction, btw).
 */
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
diff --git a/parsing_cocci/adjust_pragmas.ml b/parsing_cocci/adjust_pragmas.ml
index aadb009..b16d98f 100644
--- a/parsing_cocci/adjust_pragmas.ml
+++ b/parsing_cocci/adjust_pragmas.ml
@@ -26,7 +26,7 @@
 
 # 0 "./adjust_pragmas.ml"
 (* Find a directive or comment at the end of a statement.  Things with aft
-given None, because they can accomodate their own directives or comments *)
+given None, because they can accommodate their own directives or comments *)
 
 module Ast0 = Ast0_cocci
 module Ast = Ast_cocci
diff --git a/docs/manual/license.txt b/docs/manual/license.txt
index c7449da..b9e4abd 100644
--- a/docs/manual/license.txt
+++ b/docs/manual/license.txt
@@ -222,7 +222,7 @@ J. Preserve the network location, if any, given in the Document for
    publisher of the version it refers to gives permission.
 K. For any section Entitled "Acknowledgements" or "Dedications",
    Preserve the Title of the section, and preserve in the section all
-   the substance and tone of each of the contributor acknowledgements
+   the substance and tone of each of the contributor acknowledgments
    and/or dedications given therein.
 L. Preserve all the Invariant Sections of the Document,
    unaltered in their text and in their titles.  Section numbers
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -8765,7 +8765,7 @@ static void ncr_log_hard_error(ncb_p np, u_short sist, u_char dstat)
 **	In normal situations, interrupt conditions occur one at 
 **	a time. But when something bad happens on the SCSI BUS, 
 **	the chip may raise several interrupt flags before 
-**	stopping and interrupting the CPU. The additionnal 
+**	stopping and interrupting the CPU. The additional 
 **	interrupt flags are stacked in some extra registers 
 **	after the SIP and/or DIP flag has been raised in the 
 **	ISTAT. After the CPU has read the interrupt condition 
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -254,10 +254,10 @@ let insert_all_braces xs starti =
  * type additionnal_info defined above.
  *
  * - to complete (break, continue (and enclosing loop), switch (and
- * associated case, casedefault)) we need to pass additionnal info.
+ * associated case, casedefault)) we need to pass additional info.
  * The start/exit when enter in a loop, to know the current 'for'.
  *
- * - to handle the braces, need again pass additionnal info.
+ * - to handle the braces, need again pass additional info.
  *
  * - need pass the labels.
  *
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -10662,7 +10662,7 @@ static int ncr_compute_residual(ncb_p np, ccb_p cp)
 
 	/*
 	**	If SCRIPTS reaches its goal point, then 
-	**	there is no additionnal residual.
+	**	there is no additional residual.
 	*/
 	if (cp->phys.header.lastp == cp->phys.header.goalp)
 		return resid;
diff --git a/testing.ml b/testing.ml
index 88845c4..7ca3a62 100644
--- a/testing.ml
+++ b/testing.ml
@@ -289,7 +289,7 @@ let test_okfailed cocci_file cfiles =
   cfiles +> List.iter delete_previous_result_files;
 
   (* final_files contain the name of an output file (a .ok or .failed
-   * or .spatch_ok), and also some additionnal strings to be printed in
+   * or .spatch_ok), and also some additional strings to be printed in
    * this output file in addition to the general error message of
    * full_engine. *)
   let final_files = ref [] in
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -278,7 +278,7 @@ let rec (aux_statement: (nodei option * xinfo) -> statement -> nodei option) =
   in
 
   (* Normally the new auxinfo to pass recursively to the next aux_statement.
-   * But in some cases we add additionnal stuff in which case we don't use
+   * But in some cases we add additional stuff in which case we don't use
    * this 'xi_lbl' but a 'newxi' specially built.
    *)
   let xi_lbl =
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -3385,7 +3385,7 @@ static	struct script script0 __initdata = {
 		0,
 	/*
 	**	Read IDENTIFY + SIMPLE + TAG using a single MOVE.
-	**	Agressive optimization, is'nt it?
+	**	Aggressive optimization, is'nt it?
 	**	No need to test the SIMPLE TAG message, since the 
 	**	driver only supports conformant devices for tags. ;-)
 	*/
diff --git a/parsing_c/flag_parsing_c.ml b/parsing_c/flag_parsing_c.ml
index 6b17c34..528031c 100644
--- a/parsing_c/flag_parsing_c.ml
+++ b/parsing_c/flag_parsing_c.ml
@@ -145,7 +145,7 @@ let cmdline_flags_checks () =
   ]
 
 (*****************************************************************************)
-(* change algo *)
+(* change algorithm *)
 (*****************************************************************************)
 
 (* cocci specific *)
diff --git a/commons/seti.ml b/commons/seti.ml
index 14b6889..76591bd 100644
--- a/commons/seti.ml
+++ b/commons/seti.ml
@@ -6,7 +6,7 @@ open Common
 (* todo: could take an incr/decr func in param, to make it generic
  * opti: remember the min/max (optimisation to have intersect biggest x -> x)
  * opti: avoid all those rev, and avoid the intervise
- * (but yes the algo are then more complex :)
+ * (but yes the algorithm are then more complex :)
  * opti: balanced set intervalle
 *)
 
diff --git a/commons/ocollection.ml b/commons/ocollection.ml
index 3fa2dcc..a385538 100644
--- a/commons/ocollection.ml
+++ b/commons/ocollection.ml
@@ -42,7 +42,7 @@ open Common
  * ?? I define those classes cos their name are cool, say what is intended to
  * do with
  *
- * todo: cf book on algo, a la rivest/sedgewick
+ * todo: cf book on algorithm, a la rivest/sedgewick
  * todo: recreate collection hierarchy, inspire smalltalk ? haskell ? merd ?
  * todo: put a clean sequence (inherit collection) and make array a special
  * class
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -10257,7 +10257,7 @@ static void ncr_sir_task_recovery(ncb_p np, int num)
 
 		/*
 		**	If we have none, probably since the device has 
-		**	completed the command before we won abitration,
+		**	completed the command before we won arbitration,
 		**	send a M_ABORT message without IDENTIFY.
 		**	According to the specs, the device must just 
 		**	disconnect the BUS and not abort any task.
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -659,7 +659,7 @@ let profile_start category = failwith "todo"
 let profile_end category = failwith "todo"
 
 
-(* subtil: don't forget to give all argumens to f, otherwise partial app
+(* subtil: don't forget to give all arguments to f, otherwise partial app
  * and will profile nothing.
  *
  * todo: try also detect when complexity augment each time, so can
diff --git a/tests/testifdef.c b/tests/testifdef.c
index b25972a..55d6714 100644
--- a/tests/testifdef.c
+++ b/tests/testifdef.c
@@ -614,7 +614,7 @@ static int matroxfb_decode_var(CPMINFO struct fb_var_screeninfo *var, int *visua
 		var->yoffset = var->yres_virtual - var->yres;
 
 	if (bpp == 16 && var->green.length == 5) {
-		bpp--; /* an artifical value - 15 */
+		bpp--; /* an artificial value - 15 */
 	}
 
 	for (rgbt = table; rgbt->bpp < bpp; rgbt++);
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -395,7 +395,7 @@ and expression = (expressionbis * exp_info ref (* semantic: *)) wrap3
 (* ------------------------------------------------------------------------- *)
 (* C statement *)
 (* ------------------------------------------------------------------------- *)
-(* note: that assignement is not a statement but an expression;
+(* note: that assignment is not a statement but an expression;
  * wonderful C langage.
  *
  * note: I use 'and' for type definition cos gccext allow statement as
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -9024,7 +9024,7 @@ unknown_int:
 **
 **	There are 3 small SCRIPTS sections that deal with the 
 **	start queue and the done queue that may break any 
-**	assomption from the C code if we are interrupted 
+**	assumption from the C code if we are interrupted 
 **	inside, so we reset if it happens. Btw, since these 
 **	SCRIPTS sections are executed while the SCRIPTS hasn't 
 **	started SCSI operations, it is very unlikely to happen.
diff --git a/commons/ocamlextra/ANSITerminal.mli b/commons/ocamlextra/ANSITerminal.mli
index dd203b3..7e02a08 100644
--- a/commons/ocamlextra/ANSITerminal.mli
+++ b/commons/ocamlextra/ANSITerminal.mli
@@ -58,14 +58,14 @@ val set_autoreset : bool -> unit
 
 val print_string : style list -> string -> unit
   (** [print_string attr txt] prints the string [txt] with the
-    attibutes [attr].  After printing, the attributes are
-    automatically reseted to the defaults, unless autoreset is turned
+    attributes [attr].  After printing, the attributes are
+    automatically reset to the defaults, unless autoreset is turned
     off. *)
 
 val printf : style list -> ('a, unit, string, unit) format4 -> 'a
   (** [printf attr format arg1 ... argN] prints the arguments
-    [arg1],...,[argN] according to [format] with the attibutes [attr].
-    After printing, the attributes are automatically reseted to the
+    [arg1],...,[argN] according to [format] with the attributes [attr].
+    After printing, the attributes are automatically reset to the
     defaults, unless autoreset is turned off. *)
 
 
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -547,7 +547,7 @@ and declaration =
 
      (* fullType is the type used if the type should be converted to
 	an assignment.  It can be adjusted in the type annotation
-	phase when typedef information is availalble *)
+	phase when typedef information is available *)
      and initialiser = initialiserbis wrap
        and initialiserbis =
           | InitExpr of expression
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -717,7 +717,7 @@ static void nsp_pio_read(Scsi_Cmnd *SCpnt, nsp_hw_data *data)
 		ocount			 += res;
 		//DEBUG(0, " ptr=0x%p this_residual=0x%x ocount=0x%x\n", SCpnt->SCp.ptr, SCpnt->SCp.this_residual, ocount);
 
-		/* go to next scatter list if availavle */
+		/* go to next scatter list if available */
 		if (SCpnt->SCp.this_residual	== 0 &&
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//DEBUG(0, " scatterlist next timeout=%d\n", time_out);
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -809,7 +809,7 @@ static void nsp_pio_write(Scsi_Cmnd *SCpnt, nsp_hw_data *data)
 		SCpnt->SCp.this_residual -= res;
 		ocount			 += res;
 
-		/* go to next scatter list if availavle */
+		/* go to next scatter list if available */
 		if (SCpnt->SCp.this_residual	== 0 &&
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//DEBUG(0, " scatterlist next\n");
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -674,7 +674,7 @@ static void nsp_pio_read(Scsi_Cmnd *SCpnt, nsp_hw_data *data)
 
 		res = nsp_fifo_count(SCpnt) - ocount;
 		//DEBUG(0, " ptr=0x%p this=0x%x ocount=0x%x res=0x%x\n", SCpnt->SCp.ptr, SCpnt->SCp.this_residual, ocount, res);
-		if (res == 0) { /* if some data avilable ? */
+		if (res == 0) { /* if some data available ? */
 			if (stat == BUSPHASE_DATA_IN) { /* phase changed? */
 				//DEBUG(0, " wait for data this=%d\n", SCpnt->SCp.this_residual);
 				continue;
diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 6814e0b..1e58158 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -2077,7 +2077,7 @@ let whencode_allowed prev_ecount prev_icount prev_dcount
   (ecount = 0 or other_ecount = 0, icount = 0 or other_icount = 0,
    dcount = 0 or other_dcount = 0)
 
-(* copy the befores and afters to the instantiated code *)
+(* copy the befores and afters to the instantiated code *)
 let extra_copy_stmt_plus model e =
   (if not !Flag.sgrep_mode2 (* sgrep has no plus code, so nothing to do *)
   then
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -10327,7 +10327,7 @@ static void ncr_sir_task_recovery(ncb_p np, int num)
 
 		/*
 		**	Otherwise, check for the LUN and TASK(s) 
-		**	concerned by the cancelation.
+		**	concerned by the cancellation.
 		**	If it is not ABORT_TAG then it is CLEAR_QUEUE 
 		**	or an ABORT message :-)
 		*/
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2866,7 +2866,7 @@ and simulate_signed ta basea stringsa signaopt tb baseb ii rebuilda =
       (* In ii there is a list, sometimes of length 1 or 2 or 3.
        * And even if in baseb we have a Signed Int, that does not mean
        * that ii is of length 2, cos Signed is the default, so if in signa
-       * we have Signed explicitly ? we cant "accrocher" this mcode to
+       * we have Signed explicitly ? we cannot "accrocher" this mcode to
        * something :( So for the moment when there is signed in cocci,
        * we force that there is a signed in c too (done in pattern.ml).
        *)
diff --git a/parsing_c/token_c.ml b/parsing_c/token_c.ml
index 37642e9..0c023ba 100644
--- a/parsing_c/token_c.ml
+++ b/parsing_c/token_c.ml
@@ -31,7 +31,7 @@ open Common
  *
  * Also, ocamlyacc imposes some stupid constraints on the way we can define
  * the token type. ocamlyacc forces us to do a token type that
- * cant be a pair of a sum type, it must be directly a sum type.
+ * cannot be a pair of a sum type, it must be directly a sum type.
  * We don't have this constraint here.
  *
  * Also, some yacc tokens are not used in the grammar because they are filtered
diff --git a/parsing_c/token_helpers.ml b/parsing_c/token_helpers.ml
index 4da757b..d2d0e8c 100644
--- a/parsing_c/token_helpers.ml
+++ b/parsing_c/token_helpers.ml
@@ -213,7 +213,7 @@ let is_ident_like = function
 (*****************************************************************************)
 
 (* Because ocamlyacc force us to do it that way. The ocamlyacc token
- * cant be a pair of a sum type, it must be directly a sum type.
+ * cannot be a pair of a sum type, it must be directly a sum type.
  *)
 let info_of_tok = function
   | TString ((string, isWchar), i) -> i
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1428,7 +1428,7 @@ let exn_to_s exn =
 let string_of_exn exn = exn_to_s exn
 
 
-(* want or of merd, but cant cos cant put die ... in b (strict call) *)
+(* want or of merd, but cannot cos cannot put die ... in b (strict call) *)
 let (|||) a b = try a with _ -> b
 
 (* emacs/lisp inspiration, (vouillon does that too in unison I think) *)
diff --git a/scripts/coccicheck/cocci/notand.h b/scripts/coccicheck/cocci/notand.h
index 4c8456e..3da8c30 100644
--- a/scripts/coccicheck/cocci/notand.h
+++ b/scripts/coccicheck/cocci/notand.h
@@ -5,7 +5,7 @@
 /* This file contains:
  *   - macros found in <.h>
  *   - macros found in ".h" 
- *     but where we cant detect that it will be a "bad macro"
+ *     but where we cannot detect that it will be a "bad macro"
  *   - hints, cf below.
  * 
  * A "bad macro" is a macro using free variables or when expanded
diff --git a/scripts/coccicheck/cocci/notand.h b/scripts/coccicheck/cocci/notand.h
index 4c8456e..3da8c30 100644
--- a/scripts/coccicheck/cocci/notand.h
+++ b/scripts/coccicheck/cocci/notand.h
@@ -23,7 +23,7 @@
  *     In the future should be autodetected
  *     (not so easy to do same for macros in .h cos require to access .h file)
  *   - macros found in .c; macros correctly parsed
- *     but where we cant detect that it will be a "bad macro"
+ *     but where we cannot detect that it will be a "bad macro"
  *
  * Some of those macros could be deleted and the C code rewritten because
  * they are "bad" macros.
diff --git a/standard.h b/standard.h
index f85dcc8..0f6734d 100644
--- a/standard.h
+++ b/standard.h
@@ -5,7 +5,7 @@
 /* This file contains:
  *   - macros found in <.h>
  *   - macros found in ".h" 
- *     but where we cant detect that it will be a "bad macro"
+ *     but where we cannot detect that it will be a "bad macro"
  *   - hints, cf below.
  * 
  * A "bad macro" is a macro using free variables or when expanded
diff --git a/standard.h b/standard.h
index f85dcc8..0f6734d 100644
--- a/standard.h
+++ b/standard.h
@@ -23,7 +23,7 @@
  *     In the future should be autodetected
  *     (not so easy to do same for macros in .h cos require to access .h file)
  *   - macros found in .c; macros correctly parsed
- *     but where we cant detect that it will be a "bad macro"
+ *     but where we cannot detect that it will be a "bad macro"
  *
  * Some of those macros could be deleted and the C code rewritten because
  * they are "bad" macros.
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3121,7 +3121,7 @@ let cat_orig file =
   let chan = open_in file in
   let rec cat_orig_aux ()  =
     try
-      (* cant do input_line chan::aux() cos ocaml eval from right to left ! *)
+      (* cannot do input_line chan::aux() cos ocaml eval from right to left ! *)
       let l = input_line chan in
       l :: cat_orig_aux ()
     with End_of_file -> [] in
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3131,7 +3131,7 @@ let cat_orig file =
 let cat file =
   let chan = open_in file in
   let rec cat_aux acc ()  =
-      (* cant do input_line chan::aux() cos ocaml eval from right to left ! *)
+      (* cannot do input_line chan::aux() cos ocaml eval from right to left ! *)
     let (b, l) = try (true, input_line chan) with End_of_file -> (false, "") in
     if b
     then cat_aux (l::acc) ()
diff --git a/commons/ocollection.ml b/commons/ocollection.ml
index 3fa2dcc..a385538 100644
--- a/commons/ocollection.ml
+++ b/commons/ocollection.ml
@@ -26,7 +26,7 @@ open Common
  *
  * - pb binary methods: use tosetb tricks, or via (not safe) Obj.magic.
  * - array/list are both a sequence _and_ a dictionnary, so are both
- *   a collection(a) and a collection(i,a) at the same time. But cant do that.
+ *   a collection(a) and a collection(i,a) at the same time. But cannot do that.
  *   So for array, I see it mainly as an assoc => favor assoc, and
  *   for list, I see it mainly as a collection => favor collection
  *
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -907,7 +907,7 @@ let b = oneof [always true; always false] ()
 let b = frequency [3, always true; 2, always false] ()
 *)
 
-(* cant do this:
+(* cannot do this:
  *    let rec (lg: ('a gen) -> ('a list) gen) = fun gen -> oneofl [[]; lg gen ()]
  * nor
  *    let rec (lg: ('a gen) -> ('a list) gen) = fun gen -> oneof [always []; lg gen]
diff --git a/commons/seti.ml b/commons/seti.ml
index 14b6889..76591bd 100644
--- a/commons/seti.ml
+++ b/commons/seti.ml
@@ -176,7 +176,7 @@ let rec inter xs ys =
                     (*  [  ] *)
                     (*  [  ] *)
                 | Inf -> (Interv (i1, j1))::aux xs      ((Interv (j1+1, j2))::ys)
-                    (*  [  ] [      TODO? could have [ so cant englobe right now, but would be better *)
+                    (*  [  ] [      TODO? could have [ so cannot englobe right now, but would be better *)
                     (*  [      ] *)
                 | Sup -> (Interv (i1, j2))::aux ((Interv (j2+1, j1))::xs) ys
                     (*  [    ] *)
diff --git a/commons/seti.ml b/commons/seti.ml
index 14b6889..76591bd 100644
--- a/commons/seti.ml
+++ b/commons/seti.ml
@@ -221,7 +221,7 @@ let union xs ys =
                     (*  [  ] *)
                     (*  [  ] *)
                 | Inf -> (Interv (i1, j1))::aux xs      ((Interv (j1+1, j2))::ys)
-                    (*  [  ] [      TODO? could have [ so cant englobe right now, but would be better *)
+                    (*  [  ] [      TODO? could have [ so cannot englobe right now, but would be better *)
                     (*  [      ] *)
                 | Sup -> (Interv (i1, j2))::aux ((Interv (j2+1, j1))::xs) ys
                     (*  [    ] *)
diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index 504a3b9..bfd5908 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -568,7 +568,7 @@ let mk_pretty_printers
 
 	    (match x with
 	      (Simple (nameopt, typ)), iivirg ->
-              (* first var cant have a preceding ',' *)
+              (* first var cannot have a preceding ',' *)
 		assert (List.length iivirg =|= 0);
 		let identinfo =
                   match nameopt with
diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index 504a3b9..bfd5908 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -578,7 +578,7 @@ let mk_pretty_printers
 		pp_type_with_ident identinfo None typ Ast_c.noattr;
 		
 	    | (BitField (nameopt, typ, iidot, expr)), iivirg ->
-                      (* first var cant have a preceding ',' *)
+                      (* first var cannot have a preceding ',' *)
 		assert (List.length iivirg =|= 0);
 		(match nameopt with
 		| None ->
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -3843,7 +3843,7 @@ let rec (rule_elem_node: (A.rule_elem, Control_flow_c.node) matcher) =
       )
 
 
-  (* rene cant have found that a state containing a fake/exit/... should be
+  (* rene cannot have found that a state containing a fake/exit/... should be
    * transformed
    * TODO: and F.Fake ?
    *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -5227,7 +5227,7 @@ let (display_dot: 'a graph -> ('a -> string) -> unit)= fun (nodes,arcs) func ->
   close_out file;
   let status = Unix.system "viewdot test.dot" in
   ()
-(* todo: faire = graphe (int can change !!! => cant make simply =)
+(* todo: faire = graphe (int can change !!! => cannot make simply =)
    reassign number first !!
  *)
 
diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index e580944..8cd58c0 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -397,7 +397,7 @@ let extract_macros a =
 (* The use of local refs (remaining_tokens, passed_tokens, ...) makes
  * possible error recovery. Indeed, they allow to skip some tokens and
  * still be able to call again the ocamlyacc parser. It is ugly code
- * because we cant modify ocamllex and ocamlyacc. As we want some
+ * because we cannot modify ocamllex and ocamlyacc. As we want some
  * extended lexing tricks, we have to use such refs.
  *
  * Those refs are now also used for my lalr(k) technique. Indeed They
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -6094,7 +6094,7 @@ let main_boilerplate f =
       Sys.set_signal Sys.sigint (Sys.Signal_handle   (fun _ ->
         pr2 "C-c intercepted, will do some cleaning before exiting";
         (* But if do some try ... with e -> and if do not reraise the exn,
-         * the bubble never goes at top and so I cant really C-c.
+         * the bubble never goes at top and so I cannot really C-c.
          *
          * A solution would be to not raise, but do the erase_temp_file in the
          * syshandler, here, and then exit.
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -734,7 +734,7 @@ let rec (aux_statement: (nodei option * xinfo) -> statement -> nodei option) =
 
 
   (* This time, may return None, for instance if goto in body of dowhile
-   * (whereas While cant return None). But if return None, certainly
+   * (whereas While cannot return None). But if return None, certainly
    * some deadcode.
    *)
   | Iteration  (Ast_c.DoWhile (st, e)) ->
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -206,7 +206,7 @@ let compute_labels_and_create_them st =
 (* ctl_braces: *)
 let insert_all_braces xs starti =
   xs  +> List.fold_left (fun acc node ->
-    (* Have to build a new node (clone), cos cant share it.
+    (* Have to build a new node (clone), cos cannot share it.
      * update: This is now done by the caller. The clones are in xs.
      *)
     let newi = !g#add_node node in
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1180,7 +1180,7 @@ let t = macro_expand "type 'a bintree = Leaf of 'a | Branch of ('a bintree * 'a
 (* Composition/Control *)
 (*****************************************************************************)
 
-(* I like the obj.func object notation. In OCaml cant use '.' so I use +>
+(* I like the obj.func object notation. In OCaml cannot use '.' so I use +>
  *
  * update: it seems that F# agrees with me :) but they use |>
  *)
diff --git a/commons/parser_combinators.mli b/commons/parser_combinators.mli
index b14c53b..889ce26 100644
--- a/commons/parser_combinators.mli
+++ b/commons/parser_combinators.mli
@@ -114,7 +114,7 @@ val lex : string -> token list
 
 
 (*****************************************************************************)
-(* cant use parser as it's a reseverd word *)
+(* cannot use parser as it's a reseverd word *)
 type 'a pparser = (token, 'a) genp
 
 val ident : string pparser
diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index dfb18a6..3fc7045 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -76,7 +76,7 @@ let is_known_typdef =
       )
     )
 
-(* note: cant use partial application with let msg_typedef =
+(* note: cannot use partial application with let msg_typedef =
  * because it would compute msg_typedef at compile time when
  * the flag debug_typedef is always false
  *)
diff --git a/ocaml/yes_prepare_ocamlcocci.ml b/ocaml/yes_prepare_ocamlcocci.ml
index 9a87977..271cb2b 100644
--- a/ocaml/yes_prepare_ocamlcocci.ml
+++ b/ocaml/yes_prepare_ocamlcocci.ml
@@ -291,7 +291,7 @@ let approx_coccilib_deps cmi =
       end
       else begin
         if c >= 'A' && c <= 'Z'
-        then (* perhaps the begin of a captialized identifier *)
+        then (* perhaps the begin of a capitalized identifier *)
           Buffer.add_char buf c
         else ()
       end
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -2402,7 +2402,7 @@ let size_ko i =
  *
  * Dynamic programming technique
  * base:
- * D(i,0) = i  for all i (cos to go from S1[1..i] to 0 characteres of S2 you have to delete all characters from S1[1..i]
+ * D(i,0) = i  for all i (cos to go from S1[1..i] to 0 characters of S2 you have to delete all characters from S1[1..i]
  * D(0,j) = j  for all j (cos j characters must be inserted)
  * recurrence:
  * D(i,j) = min([D(i-1, j)+1, D(i, j - 1 + 1), D(i-1, j-1) + t(i,j)])
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -1679,7 +1679,7 @@ val tree_iter : ('a -> unit) -> 'a tree -> unit
 
 
 (*****************************************************************************)
-(* N-ary tree with updatable childrens *)
+(* N-ary tree with updatable children *)
 (*****************************************************************************)
 
 (* no empty tree, must have one root at least *)
diff --git a/commons/interfaces.ml b/commons/interfaces.ml
index e197ffc..af96d1c 100644
--- a/commons/interfaces.ml
+++ b/commons/interfaces.ml
@@ -42,7 +42,7 @@ open Common.BasicType
 (* Basic *)
 (*****************************************************************************)
 
-(* note: less need for cloneable, copyable as in Java. Only needed
+(* note: less need for clonable, copyable as in Java. Only needed
  * when use ref, but refs should be avoided anyway so better not to
  * encourage it.
  *
diff --git a/commons/objet.ml b/commons/objet.ml
index 447cc89..d49b978 100644
--- a/commons/objet.ml
+++ b/commons/objet.ml
@@ -3,7 +3,7 @@ open Common
 (* TypeClass via objects. Cf also now interfaces.ml
  *
  * todo? get more inspiration from Java to put fundamental interfaces
- * here ? such as cloneable, equaable, showable, debugable, etc
+ * here ? such as clonable, equaable, showable, debugable, etc
  *)
 
 class virtual objet =
diff --git a/commons/ocollection.ml b/commons/ocollection.ml
index 3fa2dcc..a385538 100644
--- a/commons/ocollection.ml
+++ b/commons/ocollection.ml
@@ -15,7 +15,7 @@ open Common
  * Some features/notes:
  * - views a la wadler to make it cool (I hate get/set).
  * - take list in parameters to be able to construct value as is easily
- * - take the comparaison function in parameters (=> functorial set made cool)
+ * - take the comparison function in parameters (=> functorial set made cool)
  *   make l [], h [], ... as in perl, and pass the func from pervasive
  *   in oo form (list, ...)
  * - pure/impure: could put 2 interface, with one that show that inpure
diff --git a/changes.txt b/changes.txt
index c4b64c4..4c51cab 100644
--- a/changes.txt
+++ b/changes.txt
@@ -330,7 +330,7 @@
 - matching of array initializations and of enum declarations
 
 ** Features:
-- compatability with Python 2.7.  Thanks to Richard W.M. Jones for pointing
+- compatibility with Python 2.7.  Thanks to Richard W.M. Jones for pointing
   out the problem
 - python and ocaml string representations of parameter lists and expression
   lists
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -431,7 +431,7 @@ static inline struct xpt_quehead *xpt_remque_tail(struct xpt_quehead *head)
 **	Simple Wrapper to kernel PCI bus interface.
 **
 **	This wrapper allows to get rid of old kernel PCI interface 
-**	and still allows to preserve linux-2.0 compatibilty.
+**	and still allows to preserve linux-2.0 compatibility.
 **	In fact, it is mostly an incomplete emulation of the new 
 **	PCI code for pre-2.2 kernels. When kernel-2.0 support 
 **	will be dropped, we will just have to remove most of this 
diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index fe408ab..1bfa67b 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -185,7 +185,7 @@ let print_type keep info = function
       print_string " */"*)
 
 (* --------------------------------------------------------------------- *)
-(* Contraint on Identifier and Function *)
+(* Constraint on Identifier and Function *)
 (* FIXME: Not called at the moment *)
 
 let rec idconstraint = function
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -4718,7 +4718,7 @@ struct host_data {
 };
 
 /*
-**	Print something which allows to retrieve the controler type, unit,
+**	Print something which allows to retrieve the controller type, unit,
 **	target, lun concerned by a kernel message.
 */
 
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -1120,7 +1120,7 @@ let real_al_info_cpp x =
  * a list where the comma are on their own. f(1,2,2) was
  * [(1,[]); (2,[,]); (2,[,])] and become [1;',';2;',';2].
  *
- * Used in cocci_vs_c.ml, to have a more direct correspondance between
+ * Used in cocci_vs_c.ml, to have a more direct correspondence between
  * the ast_cocci of julia and ast_c.
  *)
 let rec (split_comma: 'a wrap2 list -> ('a, il) either list) =
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -9694,7 +9694,7 @@ reset_all:
 **	contingent allegiance condition. For these reasons, 
 **	we remove from the start queue all commands for this 
 **	LUN that haven't been yet queued to the device and 
-**	put them back in the correponding LUN queue, then  
+**	put them back in the corresponding LUN queue, then  
 **	requeue the CCB that failed in front of the LUN queue.
 **	I just hope this not to be performed too often. :)
 **
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -3798,7 +3798,7 @@ static	struct scripth scripth0 __initdata = {
 		PADDRH (msg_weird_seen),
 	/*
 	**	We donnot handle extended messages from SCRIPTS.
-	**	Read the amount of data correponding to the 
+	**	Read the amount of data corresponding to the 
 	**	message length and call the C code.
 	*/
 	SCR_STORE_REL (scratcha, 1),
diff --git a/changes.txt b/changes.txt
index c4b64c4..4c51cab 100644
--- a/changes.txt
+++ b/changes.txt
@@ -741,7 +741,7 @@
 - allow . as the name of the directory
 - for type inference for an assignment, take the type of the right-hand
   side expression, not the type of the assigned variable
-- allow for with a declartion in the first header element, as in C++
+- allow for with a declaration in the first header element, as in C++
   (partial support)
 - allow for matching against variable declarations that include only
   storage, eg static, but no type at all.
diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 26cb99f..36e01c9 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -881,7 +881,7 @@ let contextify_whencode =
 (* --------------------------------------------------------------------- *)
 
 (* the first int list is the tokens in the node, the second is the tokens
-in the descendents *)
+in the descendants *)
 let minus_table =
   (Hashtbl.create(50) : (int list, Ast0.anything * int list list) Hashtbl.t)
 let plus_table =
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -5631,9 +5631,9 @@ ncr_attach (Scsi_Host_Template *tpnt, int unit, ncr_device *device)
 	**	condition is met:
 	**
 	**	- No SCSI BIOS is present.
-	**	- SCSI BIOS did'nt enable the multiplier for some reason.
+	**	- SCSI BIOS didn't enable the multiplier for some reason.
 	**	- User has disabled the controller from the SCSI BIOS.
-	**	- User booted the O/S from another O/S that did'nt enable 
+	**	- User booted the O/S from another O/S that didn't enable 
 	**	  the multiplier for some reason.
 	**
 	**	As a result, the driver may only have to measure some 
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3308,7 +3308,7 @@ let (readdir_to_dir_size_list: string -> (string * int) list) = fun path ->
 
 (* could be in control section too *)
 
-(* Why a use_cache argument ? because sometimes want disable it but dont
+(* Why a use_cache argument ? because sometimes want disable it but don't
  * want put the cache_computation funcall in comment, so just easier to
  * pass this extra option.
  *)
diff --git a/commons/ocollection/oassoc_buffer.ml b/commons/ocollection/oassoc_buffer.ml
index 973c8ec..6061b70 100644
--- a/commons/ocollection/oassoc_buffer.ml
+++ b/commons/ocollection/oassoc_buffer.ml
@@ -15,7 +15,7 @@ open Osetb
  *
  * In the same way sometimes an exn can occur at weird time. When
  * we add an element, sometimes this may raise an exn such as Out_of_memory,
- * but as we dont add directly but only at flush time, the exn
+ * but as we don't add directly but only at flush time, the exn
  * may happen far later the user added something in this oassoc.
  * Also in the case of Out_of_memory, even if the entry is not
  * added in the wrapped, it will still be present in the cache
diff --git a/commons/ocollection/oassoc_cache.ml b/commons/ocollection/oassoc_cache.ml
index 5fb5080..c95b6f8 100644
--- a/commons/ocollection/oassoc_cache.ml
+++ b/commons/ocollection/oassoc_cache.ml
@@ -26,7 +26,7 @@ open Osetb
  *
  * In the same way sometimes an exn can occur at weird time. When
  * we add an element, sometimes this may raise an exn such as Out_of_memory,
- * but as we dont add directly but only at flush time, the exn
+ * but as we don't add directly but only at flush time, the exn
  * may happen far later the user added something in this oassoc.
  * Also in the case of Out_of_memory, even if the entry is not
  * added in the wrapped, it will still be present in the cache
diff --git a/parsing_c/cpp_token_c.ml b/parsing_c/cpp_token_c.ml
index f0c3b97..f6c2b17 100644
--- a/parsing_c/cpp_token_c.ml
+++ b/parsing_c/cpp_token_c.ml
@@ -450,7 +450,7 @@ let rec apply_macro_defs
       (match params with
       | Params _ ->
           pr2 ("WEIRD: macro with params but no parens found: " ^ s);
-          (* dont apply the macro, perhaps a redefinition *)
+          (* don't apply the macro, perhaps a redefinition *)
           ()
       | NoParam ->
           (match body with
diff --git a/engine/pattern_c.ml b/engine/pattern_c.ml
index b46c0a2..6883e92 100644
--- a/engine/pattern_c.ml
+++ b/engine/pattern_c.ml
@@ -89,7 +89,7 @@ module XMATCH = struct
     binding: Lib_engine.metavars_binding;
     binding0: Lib_engine.metavars_binding; (* inherited bindings *)
   }
-  (* 'x is a ('a * 'b) but in fact dont care about 'b, we just tag the SP *)
+  (* 'x is a ('a * 'b) but in fact don't care about 'b, we just tag the SP *)
   (* opti? use set instead of list *)
   type 'x tout = ('x * Lib_engine.metavars_binding) list
 
diff --git a/commons/ocollection/oassoc_buffer.ml b/commons/ocollection/oassoc_buffer.ml
index 973c8ec..6061b70 100644
--- a/commons/ocollection/oassoc_buffer.ml
+++ b/commons/ocollection/oassoc_buffer.ml
@@ -104,7 +104,7 @@ object(o)
   method assoc k =
     try !cache#assoc k
     with Not_found ->
-      (* may launch Not_found, but this time, dont catch it *)
+      (* may launch Not_found, but this time, don't catch it *)
       let v = !wrapped#assoc k in
       begin
         cache := !cache#add (k,v);
diff --git a/commons/ocollection/oassoc_cache.ml b/commons/ocollection/oassoc_cache.ml
index 5fb5080..c95b6f8 100644
--- a/commons/ocollection/oassoc_cache.ml
+++ b/commons/ocollection/oassoc_cache.ml
@@ -113,7 +113,7 @@ object(o)
   method assoc k =
     try !cache#assoc k
     with Not_found ->
-      (* may launch Not_found, but this time, dont catch it *)
+      (* may launch Not_found, but this time, don't catch it *)
       let v = !wrapped#assoc k in
       begin
         cache := !cache#add (k,v);
diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index dfb18a6..3fc7045 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -2356,7 +2356,7 @@ let lookahead2 ~pass next before =
 
         if (LP.current_context () =*= LP.InInitializer)
         then begin
-          pr2_cpp "In Initializer passing"; (* cheat: dont count in stat *)
+          pr2_cpp "In Initializer passing"; (* cheat: don't count in stat *)
           incr Stat.nIfdefInitializer;
         end else begin
           pr2_cpp("IFDEF: or related inside function. I treat it as comment");
diff --git a/parsing_c/cpp_token_c.ml b/parsing_c/cpp_token_c.ml
index f0c3b97..f6c2b17 100644
--- a/parsing_c/cpp_token_c.ml
+++ b/parsing_c/cpp_token_c.ml
@@ -267,7 +267,7 @@ let rec (cpp_engine:
     (* expand only TIdent ? no cos the parameter of the macro
      * can actually be some 'register' so may have to look for
      * any tokens candidates for the expansion.
-     * Only subtelity is maybe dont expand the TDefineIdent.
+     * Only subtelity is maybe don't expand the TDefineIdent.
      *
      * update: in fact now the caller (define_parse) will have done
      * the job right and already replaced the macro parameter with a TIdent.
diff --git a/cocci.ml b/cocci.ml
index 3c66516..3462a33 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1254,13 +1254,13 @@ let end_env env =
  * match, will return a Left, with an empty transformation_info,
  * and so current_binding will grow. On the contrary if the first
  * region must bind some metavariables used after, and that we
- * dont find any such region, then mysat() will returns lots of
+ * don't find any such region, then mysat() will returns lots of
  * Right, and current_binding will not grow, and so we will have
  * an empty list of binding, and we will catch such a case.
  *
  * opti: julia says that because the binding is
  * determined by the used_after_list, the items in the list
- * are kind of sorted, so could optimise the insert_set operations.
+ * are kind of sorted, so could optimize the insert_set operations.
  *)
 
 
diff --git a/commons/ograph_simple.ml b/commons/ograph_simple.ml
index 815ae93..04bb751 100644
--- a/commons/ograph_simple.ml
+++ b/commons/ograph_simple.ml
@@ -10,7 +10,7 @@ open Osetb
 
 
 (* Difference with ograph_extended ? why not share code ? could, but
- * in ograph_extended we dont force the user to have a key and we
+ * in ograph_extended we don't force the user to have a key and we
  * generate those keys as he add nodes. Here we assume the user already
  * have an idea of what kind of key he wants to use (a string, a
  * filename, a, int, whatever)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3397,7 +3397,7 @@ let cache_computation_robust_in_dir a b c d e f =
 
 
 
-(* dont forget that cmd_to_list call bash and so pattern may contain
+(* don't forget that cmd_to_list call bash and so pattern may contain
  * '*' symbols that will be expanded, so can do  glob "*.c"
  *)
 let glob pattern =
diff --git a/commons/glimpse.ml b/commons/glimpse.ml
index 232ad83..aa14b14 100644
--- a/commons/glimpse.ml
+++ b/commons/glimpse.ml
@@ -120,7 +120,7 @@ let glimpseindex_files files indexdir =
  *  - -N also just show the filename on output
  *  - -l show just the filename too, but the files are still searched so
  *    at least no false positives.
- *  - if use -z for glimpseindex, dont forget the -z too for glimpse
+ *  - if use -z for glimpseindex, don't forget the -z too for glimpse
  *  - -W for boolean and queries to not be done on line level but file level
  *
  *  query langage: good;bad  for conjunction.   good,bad for disjunction.
diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aa59149..2fc6801 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -286,7 +286,7 @@ let rec vk_expr = fun bigf expr ->
   let iif ii = vk_ii bigf ii in
 
   let rec exprf e = bigf.kexpr (k,bigf) e
-  (* !!! dont go in _typ !!! *)
+  (* !!! don't go in _typ !!! *)
   and k ((e,_typ), ii) =
     iif ii;
     match e with
diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aa59149..2fc6801 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -467,7 +467,7 @@ and vk_type = fun bigf t ->
     | StructUnionName (s, structunion) -> ()
     | EnumName  s -> ()
 
-    (* dont go in _typ *)
+    (* don't go in _typ *)
     | TypeName (name,_typ) ->
         vk_name bigf name
 
diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aa59149..2fc6801 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -22,7 +22,7 @@ module F = Control_flow_c
 (* Prelude *)
 (*****************************************************************************)
 
-(* todo? dont go in Include. Have a visitor flag ? disable_go_include ?
+(* todo? don't go in Include. Have a visitor flag ? disable_go_include ?
  * disable_go_type_annotation ?
  *)
 
diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aa59149..2fc6801 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -523,7 +523,7 @@ and vk_onedecl = fun bigf onedecl ->
       v_attr = attrs})  ->
 
     vk_type bigf t;
-    (* dont go in tbis *)
+    (* don't go in tbis *)
     attrs +> List.iter (vk_attribute bigf);
     var +> Common.do_option (fun (name, iniopt) ->
       vk_name bigf name;
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -2346,7 +2346,7 @@ let lowercase = String.lowercase
 
 let quote s = "\"" ^ s ^ "\""
 
-(* easier to have this to be passed as hof, because ocaml dont have
+(* easier to have this to be passed as hof, because ocaml don't have
  * haskell "section" operators
  *)
 let null_string s =
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -157,7 +157,7 @@ and name =
  * from scratch, because many stuff are just sugar.
  *
  * invariant: Array and FunctionType have also typeQualifier but they
- * dont have sense. I put this to factorise some code. If you look in
+ * don't have sense. I put this to factorise some code. If you look in
  * the grammar, you see that we can never specify const for the array
  * himself (but we can do it for pointer) or function, we always
  * have in the action rule of the grammar a { (nQ, FunctionType ...) }.
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1413,7 +1413,7 @@ let myassert cond = if cond then () else failwith "assert error"
  *
  * The need for printf make me force to name stuff :(
  * How avoid ? use 'it' special keyword ?
- * In fact dont have to name it, use +> (fun v -> ...)  so when want
+ * In fact don't have to name it, use +> (fun v -> ...)  so when want
  * erase debug just have to erase one line.
  *)
 let warning s v = (pr2 ("Warning: " ^ s ^ "; value = " ^ (Dumper.dump v)); v)
diff --git a/parsing_c/cpp_ast_c.ml b/parsing_c/cpp_ast_c.ml
index cdb135f..dabfa0b 100644
--- a/parsing_c/cpp_ast_c.ml
+++ b/parsing_c/cpp_ast_c.ml
@@ -347,7 +347,7 @@ let should_ifdefize (tag,ii) ifdefs_directives xxs =
     pr2 "CPPASTC: some of its directives were passed";
     false
   end else
-    (* todo? put more condition ? dont ifdefize declaration ? *)
+    (* todo? put more condition ? don't ifdefize declaration ? *)
     true
 
 
diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 971024a..1f1bfd9 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1284,7 +1284,7 @@ loop (tu,current_tab) in
       x::aux true xs
     | ((Cocci2("{",_,_,_,_)) as a)::xs -> a::aux true xs
     | ((Cocci2("\n",_,_,_,_)) as x)::xs ->
-      (* dont inline in expr because of weird eval order of ocaml *)
+      (* don't inline in expr because of weird eval order of ocaml *)
       let s = String.concat "" !_current_tabbing in
       (* can't be C2, for later phases *)
       x::Cocci2 (s,-1,-1,-1,None)::aux started xs
diff --git a/commons/interfaces.ml b/commons/interfaces.ml
index e197ffc..af96d1c 100644
--- a/commons/interfaces.ml
+++ b/commons/interfaces.ml
@@ -189,6 +189,6 @@ end
  * module type Sexpable = Sexpable.S
  * module type Binable = Binable.S
  *
- * And I dont like having too much files, especially as all those xxable
+ * And I don't like having too much files, especially as all those xxable
  * end with able, not start, so don't see them together in the directory.
  *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3149,7 +3149,7 @@ let interpolate str =
     cat "/tmp/caml"
   end
 
-(* could do a print_string but printf dont like print_string *)
+(* could do a print_string but printf don't like print_string *)
 let echo s = printf "%s" s; flush stdout; s
 
 let usleep s = for i = 1 to s do () done
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -3787,7 +3787,7 @@ let rec (rule_elem_node: (A.rule_elem, Control_flow_c.node) matcher) =
 
   | _, F.Enter | _, F.Exit | _, F.ErrorExit -> fail2()
 
-  (* the metaRuleElem contains just '-' information. We dont need to add
+  (* the metaRuleElem contains just '-' information. We don't need to add
    * stuff in the environment. If we need stuff in environment, because
    * there is a + S somewhere, then this will be done via MetaStmt, not
    * via MetaRuleElem.
diff --git a/commons/glimpse.ml b/commons/glimpse.ml
index 232ad83..aa14b14 100644
--- a/commons/glimpse.ml
+++ b/commons/glimpse.ml
@@ -47,12 +47,12 @@ let s_of_glimpse_options xs =
  * note:
  *  - -o or -b for glimpseindex => bigger index, faster search
  *  - no need to use -b with our way to use glimpse
- *    cos we use -l so dont need to know what is the place of the word
+ *    cos we use -l so don't need to know what is the place of the word
  *    in the file
  *  - -f is for incremental indexing. Handle when files are deleted ?
  *    I think that not that bad cos yes certainly in the index there will
  *    have some  no-more-valid pointers, but as glimpse actually then do
- *    a real search on the file, he will see that dont exist anymore and
+ *    a real search on the file, he will see that don't exist anymore and
  *    so using -f is slower but very very little slower
  *  - for -z the order is important in .glimpse_filters => put
  *    the case of compressed file first
diff --git a/parsing_c/compare_c.ml b/parsing_c/compare_c.ml
index f76748e..d1df6d0 100644
--- a/parsing_c/compare_c.ml
+++ b/parsing_c/compare_c.ml
@@ -251,7 +251,7 @@ let compare_ast filename1 filename2  =
  *)
 
 
-(* Pass only "true" comments, dont pass TCommentMisc and TCommentCpp *)
+(* Pass only "true" comments, don't pass TCommentMisc and TCommentCpp *)
 let is_normal_space_or_comment to_expected = function
   | Parser_c.TCommentSpace _
   | Parser_c.TCommentNewline _
diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index 504a3b9..bfd5908 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -653,7 +653,7 @@ let mk_pretty_printers
     | CppDirectiveStruct cpp -> pp_directive cpp
     | IfdefStruct ifdef -> pp_ifdef ifdef
 
-(* used because of DeclList, in    int i,*j[23];  we dont print anymore the
+(* used because of DeclList, in    int i,*j[23];  we don't print anymore the
    int before *j *)
   and (pp_type_with_ident_rest: (string * info) option ->
     fullType -> attribute list -> unit) =
diff --git a/commons/oset.ml b/commons/oset.ml
index f68e279..13117ec 100644
--- a/commons/oset.ml
+++ b/commons/oset.ml
@@ -42,7 +42,7 @@ let ($--$) xs ys = xs#minus ys
 let ($<<=$) xs ys = xs#is_subset_of ys
 let ($==$) xs ys = xs#is_equal ys
 
-(* todo: pas beau le seed.  I dont put the type otherwise have to
+(* todo: pas beau le seed.  I don't put the type otherwise have to
  * put explicit :>
  *)
 let (mapo: ('a -> 'b) -> 'b oset -> 'a oset -> 'b oset) = fun f seed xs ->
diff --git a/main.ml b/main.ml
index e64fe96..5a2dd5a 100644
--- a/main.ml
+++ b/main.ml
@@ -1192,7 +1192,7 @@ let main () =
 	Testing.test_parse_cocci !cocci_file
 
      (* I think this is used by some scripts in some Makefile for our
-      * big-tests. So dont remove.
+      * big-tests. So don't remove.
       *)
     | [file1;file2] when !action =$= "--compare-c" ->
        Test_parsing_c.test_compare_c file1 file2 (* result = unix code *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -3080,7 +3080,7 @@ let (lines_with_nl: string -> string list) = fun s ->
   (time_func (fun () -> Str.split_delim (Str.regexp "\n") s)) +> lines_aux
 
 (* in fact better make it return always complete lines, simplify *)
-(*  Str.split, but lines "\n1\n2\n" dont return the \n and forget the first \n => split_delim better than split *)
+(*  Str.split, but lines "\n1\n2\n" don't return the \n and forget the first \n => split_delim better than split *)
 (* +> List.map (fun s -> s ^ "\n") but add an \n even at the end => lines_aux *)
 (* old: slow
   let chars = list_of_string s in
diff --git a/engine/pattern_c.ml b/engine/pattern_c.ml
index b46c0a2..6883e92 100644
--- a/engine/pattern_c.ml
+++ b/engine/pattern_c.ml
@@ -336,7 +336,7 @@ module XMATCH = struct
   (* pre: if have declared a new metavar that hide another one, then
    * must be passed with a binding that deleted this metavar
    *
-   * Here we dont use the keep argument of julia. cf f(X,X), J'ai
+   * Here we don't use the keep argument of julia. cf f(X,X), J'ai
    * besoin de garder le X en interne, meme si julia s'en fout elle du
    * X et qu'elle a mis X a DontSaved.
    *)
diff --git a/parsing_c/control_flow_c.ml b/parsing_c/control_flow_c.ml
index 8c18894..12fa4bd 100644
--- a/parsing_c/control_flow_c.ml
+++ b/parsing_c/control_flow_c.ml
@@ -176,7 +176,7 @@ type node = node1 * string
    * of an if (maybe a '}', maybe a ';')
    *
    * The problem is that this stuff should be in transformation.ml,
-   * but need information available in flow_to_ast, but we dont want
+   * but need information available in flow_to_ast, but we don't want
    * to polluate both files.
    *
    * So the choices are
diff --git a/engine/transformation_c.ml b/engine/transformation_c.ml
index 23e8fe0..e40f61a 100644
--- a/engine/transformation_c.ml
+++ b/engine/transformation_c.ml
@@ -375,7 +375,7 @@ module XTRANS = struct
           *)
              begin
             (* coccionly:
-               pad: if dont want cocci write:
+               pad: if don't want cocci write:
                 failwith
 	        (match Ast_c.pinfo_of_info ib with
 		  Ast_c.FakeTok _ -> "already tagged fake token"
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1479,7 +1479,7 @@ let _init_gc_stack =
 
 
 
-(* if process a big set of files then dont want get overflow in the middle
+(* if process a big set of files then don't want get overflow in the middle
  * so for this we are ready to spend some extra time at the beginning that
  * could save far more later.
  *)
diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index ad91aa0..7514272 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -133,7 +133,7 @@ let pr2, pr2_once = Common.mk_pr2_wrappers Flag_parsing_c.verbose_type
  * so don't need make difference between namespaces here.
  *
  * But, why not make simply a (string, kindstring) assoc ?
- * Because we dont want that a variable shadow a struct definition, because
+ * Because we don't want that a variable shadow a struct definition, because
  * they are still in 2 different namespace. But could for typedef,
  * because VarOrFunc and Typedef are in the same namespace.
  * But could do a record as in c_info.ml
diff --git a/tests/labels_metastatement.c b/tests/labels_metastatement.c
index 3697ffc..466b14c 100644
--- a/tests/labels_metastatement.c
+++ b/tests/labels_metastatement.c
@@ -3,7 +3,7 @@ int foo(int i) {
   if(1) {
     x = 3;
     z = 4;
-  } // we dont want that it add both foo on the } and on the endif
+  } // we don't want that it add both foo on the } and on the endif
     // (note: but need correct endif accrochage)
 
 }
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -831,7 +831,7 @@ let list_matcher match_dots rebuild_dots match_comma rebuild_comma
 		     "I have no token that I could accroche myself on"*)
                     else return (dots2metavar mcode, [])
 		  else
-                (* subtil: we dont want the '...' to match until the
+                (* subtil: we don't want the '...' to match until the
                    * comma. cf -test pb_params_iso. We would get at
                    * "already tagged" error.
                    * this is because both f (... x, ...) and f (..., x, ...)
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -67,7 +67,7 @@ val save_tmp_files : bool ref
 type filename = string
 type dirname = string
 
-(* Trick in case you dont want to do an 'open Common' while still wanting
+(* Trick in case you don't want to do an 'open Common' while still wanting
  * more pervasive types than the one in Pervasives. Just do the selective
  * open Common.BasicType.
  *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1542,7 +1542,7 @@ let check_stack_nbfiles nbfiles =
  * and so have to wait for parse_options, which in turn need the options
  * spec, so circle.
  *
- * Also I dont want to mix code with data structures, so it's better that the
+ * Also I don't want to mix code with data structures, so it's better that the
  * options variable contain just a few stuff and have no side effects except
  * setting global variables.
  *
diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index aa59149..2fc6801 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -124,7 +124,7 @@ let pr2, pr2_once = Common.mk_pr2_wrappers Flag_parsing_c.verbose_visit
  *      end in analysis#expr
  *
  * The problem is that you don't have control about what is generated
- * and in our case we sometimes dont want to visit too much. For instance
+ * and in our case we sometimes don't want to visit too much. For instance
  * our visitor don't recurse on the type annotation of expressions
  * Ok, this could be worked around, but the pb remains, you
  * don't have control and at some point you may want. In the same
diff --git a/commons/glimpse.ml b/commons/glimpse.ml
index 232ad83..aa14b14 100644
--- a/commons/glimpse.ml
+++ b/commons/glimpse.ml
@@ -9,7 +9,7 @@ type glimpse_search =
   (* -i insensitive search *)
   | GlimpseCaseInsensitive
   (* -w match on complete words. But not always good idea, for instance
-   * if file contain chazarain_j then dont work with -w
+   * if file contain chazarain_j then don't work with -w
    *)
   | GlimpseWholeWord
 
diff --git a/commons/oset.ml b/commons/oset.ml
index f68e279..13117ec 100644
--- a/commons/oset.ml
+++ b/commons/oset.ml
@@ -29,7 +29,7 @@ object(o: 'o)
     o#length =|= 1
   method cardinal: int = (* just to keep naming conventions *)
     o#length
-      (* dont work:
+      (* don't work:
          method big_union: 'b. ('a -> 'b oset) -> 'b oset = fun f -> todo()
       *)
 
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -128,12 +128,12 @@ and 'a wrap3 = 'a * il (* * evotype*)
  * as concatenated strings can be used not only for identifiers and for
  * declarators, but also for fields, for labels, etc.
  *
- * Note: because now the info is embeded in the name, the info for
+ * Note: because now the info is embedded in the name, the info for
  * expression like Ident, or types like Typename, are not anymore
  * stored in the expression or type. Hence if you assume this,
  * which was true before, you are now wrong. So never write code like
  * let (unwrape,_), ii = e  and use 'ii' believing it contains
- * the local ii to e. If you want to do that, use the appropiate
+ * the local ii to e. If you want to do that, use the appropriate
  * wrapper get_local_ii_of_expr_inlining_ii_of_name.
  *)
 and name =
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -4335,7 +4335,7 @@ let rec realCombinaison = function
       res2 ++ res ++ [[a]]
 
 (* genere toutes les combinaisons possible de paire      *)
-(* par exemple combinaison [1;2;4] -> [1, 2; 1, 4; 2, 4] *)
+(* par example combinaison [1;2;4] -> [1, 2; 1, 4; 2, 4] *)
 let rec combinaison = function
   | [] -> []
   | [a] -> []
diff --git a/commons/seti.ml b/commons/seti.ml
index 14b6889..76591bd 100644
--- a/commons/seti.ml
+++ b/commons/seti.ml
@@ -282,7 +282,7 @@ let diff xs ys =
                   (*         [ ] *)
                 else
                   (match j1 <=> j2 with
-                  | Equal -> (Interv (i1, i2-1))::aux xs ys (* -1 cos exlude [ *)
+                  | Equal -> (Interv (i1, i2-1))::aux xs ys (* -1 cos exclude [ *)
                       (*  [    ] *)
                       (*     [ ] *)
                   | Inf ->   (Interv (i1, i2-1))::aux xs ((Interv (j1+1, j2))::ys)
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -2988,7 +2988,7 @@ and simulate_signed_meta ta basea signaopt tb baseb ii rebuilda =
       (* In ii there is a list, sometimes of length 1 or 2 or 3.
        * And even if in baseb we have a Signed Int, that does not mean
        * that ii is of length 2, cos Signed is the default, so if in signa
-       * we have Signed explicitely ? we cant "accrocher" this mcode to
+       * we have Signed explicitly ? we cannot "accrocher" this mcode to
        * something :( So for the moment when there is signed in cocci,
        * we force that there is a signed in c too (done in pattern.ml).
        *)
diff --git a/commons/readme.txt b/commons/readme.txt
index 4478613..b4e6442 100644
--- a/commons/readme.txt
+++ b/commons/readme.txt
@@ -12,7 +12,7 @@ there are simple such as for ANSITerminal in ocamlextra/, and for
 dumper.ml I have even be further by inlining its code in common.ml so
 one can just do a open Common and have everything. Then if the user
 wants to, he can also leverage the other commons_xxx libraries by
-explicitely building them after he has installed the necessary
+explicitly building them after he has installed the necessary
 external files.
 
 For many configurable things we can use some flags in ml files, 
diff --git a/changes.txt b/changes.txt
index c4b64c4..4c51cab 100644
--- a/changes.txt
+++ b/changes.txt
@@ -119,7 +119,7 @@
   compiler and the C compiler and preprocessor).
 - Add line number directives to the .ml file generated from a .cocci file
 - Added 'make check' as an alternative to 'make test'. It can run after
-  building spatch, checks whether some featues work (python and ocaml scripts,
+  building spatch, checks whether some features work (python and ocaml scripts,
   regexes) if these features are enabled, and then launches the test suite
   with a 75% success rate requirement. It also does not ask for user input
   and can be used in autonomous builds.
diff --git a/engine/externalanalysis.ml b/engine/externalanalysis.ml
index ae18b88..1438842 100644
--- a/engine/externalanalysis.ml
+++ b/engine/externalanalysis.ml
@@ -88,7 +88,7 @@ module Int64Set = Set.Make (Int64)
 (* bound: either concrete or unbounded *)
 type bound = int64 option
 
-(* The type of analysis results, which for the moment focusses on integers.
+(* The type of analysis results, which for the moment focuses on integers.
  * The lower bound should be smaller or equal to the upper bound (not enforced)
  *)
 type result =
diff --git a/parsing_c/control_flow_c.ml b/parsing_c/control_flow_c.ml
index 8c18894..12fa4bd 100644
--- a/parsing_c/control_flow_c.ml
+++ b/parsing_c/control_flow_c.ml
@@ -74,7 +74,7 @@ open Ast_c
  * choice: Julia proposed that the flow is in fact just
  * a view through the Ast, which means just Ocaml ref, so that when we
  * modify some nodes, in fact it modifies the ast. But I prefer do it
- * the functionnal way.
+ * the functional way.
  *
  * The node2 type should be as close as possible to Ast_cocci.rule_elem to
  * facilitate the job of cocci_vs_c.
diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 971024a..1f1bfd9 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1024,7 +1024,7 @@ let add_newlines toks tabbing_unit =
       let sp = ref " " in
       let cocci_count = string_length s count in
       let space_cell = Some (cocci_count+1,sp) in (* count before space *)
-      let newcount = cocci_count + 2 in (* count incuding space *)
+      let newcount = cocci_count + 2 in (* count including space *)
       let future_count =
         string_length (TH.str_of_tok codetok) newcount in
       let b = T2(commatok,Ctx,idx,
diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 971024a..1f1bfd9 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1042,7 +1042,7 @@ let add_newlines toks tabbing_unit =
       let x = List.hd stack in
       let sp = ref " " in
       let space_cell = Some (count+1,sp) in (* count before space *)
-      let newcount = count + 2 in (* count incuding space *)
+      let newcount = count + 2 in (* count including space *)
       let future_count = string_length s newcount in
       let a = T2(commatok,Ctx,idx,
         Some (Unparse_cocci.SpaceOrNewline sp)) in
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -13425,7 +13425,7 @@ sym53c8xx_pci_init(Scsi_Host_Template *tpnt, pcidev_t pdev, ncr_device *device)
 #endif	/* SCSI_NCR_PCI_FIX_UP_SUPPORT */
 
  	/*
-	**    Initialise ncr_device structure with items required by ncr_attach.
+	**    Initialize ncr_device structure with items required by ncr_attach.
 	*/
 	device->pdev		= pdev;
 	device->slot.bus	= PciBusNumber(pdev);
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -5505,7 +5505,7 @@ ncr_attach (Scsi_Host_Template *tpnt, int unit, ncr_device *device)
 		goto attach_error;
 
 	/*
-	**	Initialyze the CCB free queue and,
+	**	Initialize the CCB free queue and,
 	**	allocate some CCB. We need at least ONE.
 	*/
 	xpt_que_init(&np->free_ccbq);
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -11762,7 +11762,7 @@ static ccb_p ncr_alloc_ccb(ncb_p np)
 	np->ccbh[hcode] = cp;
 
 	/*
-	**	Initialyze the start and restart actions.
+	**	Initialize the start and restart actions.
 	*/
 	cp->phys.header.go.start   = cpu_to_scr(NCB_SCRIPT_PHYS (np, idle));
 	cp->phys.header.go.restart = cpu_to_scr(NCB_SCRIPTH_PHYS(np,bad_i_t_l));
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -602,7 +602,7 @@ val (=*=): 'a -> 'a -> bool
  * val (=): unit -> unit -> bool
  *
  * But it will not forbid you to use caml functions like List.find, List.mem
- * which internaly use this convenient but evolution-unfriendly (=)
+ * which internally use this convenient but evolution-unfriendly (=)
 *)
 
 
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -5204,7 +5204,7 @@ let rec (equal: 'a graph -> 'a graph -> bool) = fun g1 g2 ->
        List.mem (List.assoc i1 conv, List.assoc i2 conv) arcs2)
      arcs1
       && (List.length arcs1 = List.length arcs2)
-    (* could think that only forall is needed, but need check same lenth too*)
+    (* could think that only forall is needed, but need check same length too*)
   with _ -> false
 
 let (display: 'a graph -> ('a -> unit) -> unit) = fun g display_func ->
diff --git a/cocci.ml b/cocci.ml
index 3c66516..3462a33 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1682,8 +1682,8 @@ and process_a_ctl_a_env_a_toplevel2 r e c f =
 	       try
                (* les "more than one var in a decl" et "already tagged token"
                 * font crasher coccinelle. Si on a 5 fichiers, donc on a 5
-                * failed. Le try limite le scope des crashes pendant la
-                * trasformation au fichier concerne. *)
+                * failed. Le try limit le scope des crashes pendant la
+                * transformation au type concerne. *)
 
                (* modify ast via side effect *)
 		 ignore
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -621,7 +621,7 @@ static int ncr_debug = SCSI_NCR_DEBUG_FLAGS;
 **	use several SCSI adapters, we are using one lock per controller 
 **	instead of some global one. For the moment (linux-2.1.95), driver's 
 **	entry points are called with the 'io_request_lock' lock held, so:
-**	- We are uselessly loosing a couple of micro-seconds to lock the 
+**	- We are uselessly losing a couple of micro-seconds to lock the 
 **	  controller data structure.
 **	- But the driver is not broken by design for SMP and so can be 
 **	  more resistant to bugs or bad changes in the IO sub-system code.
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -1938,7 +1938,7 @@ val error_message_short : filename -> (string * int) -> string
 val error_messagebis : filename -> (string * int) -> int -> string
 
 (*****************************************************************************)
-(* Scope managment (cocci) *)
+(* Scope management (cocci) *)
 (*****************************************************************************)
 
 (* for example of use, see the code used in coccinelle *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1384,7 +1384,7 @@ let release_file_lock filename =
 
 
 (*****************************************************************************)
-(* Error managment *)
+(* Error management *)
 (*****************************************************************************)
 
 exception Todo
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -445,7 +445,7 @@ val cache_computation_robust_in_dir :
   string option (* destination directory *) -> filename ->
   string (* extension for marshalled object *) ->
   (filename list * 'x) ->
-  string (* extension for marshalled dependencies *) ->
+  string (* extension for marshaled dependencies *) ->
   (unit -> 'a) ->
   'a
 
diff --git a/commons/common.mli b/commons/common.mli
index 64563bd..2f03b49 100644
--- a/commons/common.mli
+++ b/commons/common.mli
@@ -435,7 +435,7 @@ val cache_computation :
  *)
 val cache_computation_robust :
   filename ->
-  string (* extension for marshalled object *) ->
+  string (* extension for marshaled object *) ->
   (filename list * 'x) ->
   string (* extension for marshalled dependencies *) ->
   (unit -> 'a) ->
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 65e250f..967df84 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -865,7 +865,7 @@ let list_matcher match_dots rebuild_dots match_comma rebuild_comma
 				       )
 			)))
 	    | Some ia1, ebs ->
-          (* allow ',' to maching nothing. optional comma trick *)
+          (* allow ',' to matching nothing. optional comma trick *)
 		Some
 		  (if mcode_contain_plus (mcodekind ia1)
 		  then fail
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -6131,7 +6131,7 @@ static int ncr_ic_nego(ncb_p np, ccb_p cp, Scsi_Cmnd *cmd, u_char *msgptr)
 
 		/* Previous command recorded a parity or an initiator
 		 * detected error condition. Force bus to narrow for this
-		 * target. Clear flag. Negotation on request sense.
+		 * target. Clear flag. Negotiation on request sense.
 		 * Note: kernel forces 2 bus resets :o( but clears itself out. 
 		 * Minor bug? in scsi_obsolete.c (ugly)
 		 */
diff --git a/parsing_c/cpp_token_c.ml b/parsing_c/cpp_token_c.ml
index f0c3b97..f6c2b17 100644
--- a/parsing_c/cpp_token_c.ml
+++ b/parsing_c/cpp_token_c.ml
@@ -27,7 +27,7 @@ open Token_views_c
  *   - (3) in an argument to a macro call as in   IDENT(if);
  * Case 1 is easy to fix in define_ident.
  * Case 2 is easy to fix in define_parse where detect such toks in
- * the parameter and then replace their occurence in the body in a Tident.
+ * the parameter and then replace their occurrence in the body in a Tident.
  * Case 3 is only an issue when the expanded token is not really use
  * as usual but use for instance in concatenation as in  a ## if
  * when expanded. In the case the grammar this time will not be happy
diff --git a/parsing_cocci/free_vars.ml b/parsing_cocci/free_vars.ml
index 80900e6..1bda62f 100644
--- a/parsing_cocci/free_vars.ml
+++ b/parsing_cocci/free_vars.ml
@@ -74,7 +74,7 @@ let collect_refs include_constraints =
   (* the following considers that anything that occurs non-unitarily in one
      branch occurs nonunitarily in all branches.  This is not optimal, but
      doing better seems to require a breadth-first traversal, which is
-     perhaps better to avoid.  Also, unitarily is represented as occuring once,
+     perhaps better to avoid.  Also, unitarily is represented as occurring once,
      while nonunitarily is represented as twice - more is irrelevant *)
   (* cases for disjs and metavars *)
   let bind_disj refs_branches =
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -590,7 +590,7 @@ static int nsp_dataphase_bypass(Scsi_Cmnd *SCpnt, nsp_hw_data *data)
 
 	/*
 	 * XXX: NSP_QUIRK
-	 * data phase skip only occures in case of SCSI_LOW_READ
+	 * data phase skip only occurs in case of SCSI_LOW_READ
 	 */
 	DEBUG(0, " use bypass quirk\n");
 	SCpnt->SCp.phase = PH_DATA;
diff --git a/cocci.ml b/cocci.ml
index 3c66516..3462a33 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1923,7 +1923,7 @@ let full_engine2 (cocci_infos,toks) cfiles =
 
   show_or_not_cfiles  cfiles;
 
-  (* optimisation allowing to launch coccinelle on all the drivers *)
+  (* optimization allowing to launch coccinelle on all the drivers *)
   if !Flag_cocci.worth_trying_opt && not (worth_trying cfiles toks)
   then
     begin
diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index ad91aa0..7514272 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -1005,7 +1005,7 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
  * Because There would be some copy paste with annotate_program, it is
  * better to factorize code hence the just_add_in_env parameter below.
  *
- * todo? alternative optimisation for the include problem:
+ * todo? alternative optimization for the include problem:
  *  - processing all headers files one time and construct big env
  *  - use hashtbl for env (but apparently not biggest problem)
  *)
diff --git a/engine/asttoctl2.ml b/engine/asttoctl2.ml
index f6df332..49edb55 100644
--- a/engine/asttoctl2.ml
+++ b/engine/asttoctl2.ml
@@ -1696,7 +1696,7 @@ and statement stmt top after quantified minus_quantified
   match Ast.unwrap stmt with
     Ast.Atomic(ast) ->
       (match Ast.unwrap ast with
-	(* the following optimisation is not a good idea, because when S
+	(* the following optimization is not a good idea, because when S
 	   is alone, we would like it not to match a declaration.
 	   this makes more matching for things like when (...) S, but perhaps
 	   that matching is not so costly anyway *)
diff --git a/cocci.ml b/cocci.ml
index 3c66516..3462a33 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1096,7 +1096,7 @@ let build_info_program (cprogram,typedefs,macros) env =
 
 
 
-(* Optimisation. Try not unparse/reparse the whole file when have modifs  *)
+(* Optimization. Try not unparse/reparse the whole file when have modifs  *)
 let rebuild_info_program cs file isexp =
   cs +> List.map (fun c ->
     if !(c.was_modified)
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -10311,7 +10311,7 @@ static void ncr_sir_task_recovery(ncb_p np, int num)
 		**	If we sent a M_RESET, then a hardware reset has 
 		**	been performed by the target.
 		**	- Reset everything to async 8 bit
-		**	- Tell ourself to negotiate next time :-)
+		**	- Tell ourselves to negotiate next time :-)
 		**	- Prepare to clear all disconnected CCBs for 
 		**	  this target from our task list (lun=task=-1)
 		*/
diff --git a/parsing_c/test_parsing_c.ml b/parsing_c/test_parsing_c.ml
index 633c30d..dc769d2 100644
--- a/parsing_c/test_parsing_c.ml
+++ b/parsing_c/test_parsing_c.ml
@@ -207,7 +207,7 @@ let test_parse_i xs =
 
 (* ---------------------------------------------------------------------- *)
 (* file can be   "foo.c"  or "foo.c:main" *)
-(* local function that is parameterized by whether to launch gv *)
+(* local function that is parametrized by whether to launch gv *)
 let local_test_cfg launchgv file =
   let (file, specific_func) =
     if file =~ "\\(.*\\.c\\):\\(.*\\)"
diff --git a/commons/ocamlextra/dynArray.mli b/commons/ocamlextra/dynArray.mli
index 29660e1..491e5fc 100644
--- a/commons/ocamlextra/dynArray.mli
+++ b/commons/ocamlextra/dynArray.mli
@@ -256,7 +256,7 @@ val exponential_resizer : resizer_t
 
 val step_resizer : int -> resizer_t
 (** The stepwise resizer- another example of a resizer function, this
-	time of a parameterized resizer.
+	time of a parametrized resizer.
 
 	The resizer returned by [step_resizer step] returns the smallest
 	multiple of [step] larger than [newlength] if [currslots] is less
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -9047,7 +9047,7 @@ static void ncr_recover_scsi_int (ncb_p np, u_char hsts)
 
 	/*
 	**	If we haven't been interrupted inside the SCRIPTS 
-	**	critical pathes, we can safely restart the SCRIPTS 
+	**	critical paths, we can safely restart the SCRIPTS 
 	**	and trust the DSA value if it matches a CCB.
 	*/
 	if ((!(dsp > NCB_SCRIPT_PHYS (np, getjob_begin) &&
diff --git a/engine/asttoctl2.ml b/engine/asttoctl2.ml
index f6df332..49edb55 100644
--- a/engine/asttoctl2.ml
+++ b/engine/asttoctl2.ml
@@ -1804,7 +1804,7 @@ and statement stmt top after quantified minus_quantified
 			     (* error exit not possible; it is in the middle
 				of code, so a return is needed *)
 			     exit)
-			  (* worry about perf, but seems correct, not ax *)
+			  (* worry about performance, but seems correct, not ax *)
 			  (ctl_back_ag
 			     (ctl_not
 				(ctl_uncheck
diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index ad91aa0..7514272 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -71,7 +71,7 @@ module Lib = Lib_parsing_c
  * annotate_type.
  *
  * todo: how deal with typedef isomorphisms ? How store them in Ast_c ?
- * store all posible variations in ast_c ? a list of type instead of just
+ * store all possible variations in ast_c ? a list of type instead of just
  * the type ?
  *
  * todo: how to handle multiple possible definitions for entities like
diff --git a/parsing_cocci/parse_cocci.ml b/parsing_cocci/parse_cocci.ml
index a193b3f..a01245e 100644
--- a/parsing_cocci/parse_cocci.ml
+++ b/parsing_cocci/parse_cocci.ml
@@ -850,7 +850,7 @@ let rec find_function_names l =
   loop l
 
 (* ----------------------------------------------------------------------- *)
-(* an attribute is an identifier that preceeds another identifier and
+(* an attribute is an identifier that precedes another identifier and
    begins with __ *)
 
 let rec detect_attr l =
diff --git a/cocci.ml b/cocci.ml
index 3c66516..3462a33 100644
--- a/cocci.ml
+++ b/cocci.ml
@@ -1773,7 +1773,7 @@ let rec bigloop2 rs (ccs: file_info list) =
      * still call rebuild_info_c_and_headers to pretty print the
      * action (MINUS), so that later the diff will show what was
      * matched by sgrep. But we don't want the parsing error message
-     * hence the following flag setting. So this code propably
+     * hence the following flag setting. So this code probably
      * will generate a NotParsedCorrectly for the matched parts
      * and the very final pretty print and diff will work
      *)
diff --git a/engine/asttoctl2.ml b/engine/asttoctl2.ml
index f6df332..49edb55 100644
--- a/engine/asttoctl2.ml
+++ b/engine/asttoctl2.ml
@@ -1419,7 +1419,7 @@ let dots_au is_strict toend label s wrapcode n x seq_after y quantifier =
 let rec dots_and_nests plus nest whencodes bef aft dotcode after label
     process_bef_aft statement_list statement guard quantified wrapcode =
   let ctl_and_ns = ctl_and CTL.NONSTRICT in
-  (* proces bef_aft *)
+  (* process bef_aft *)
   let shortest l =
     List.fold_left ctl_or_fl CTL.False (List.map process_bef_aft l) in
   let bef_aft = (* to be negated *)
diff --git a/engine/externalanalysis.ml b/engine/externalanalysis.ml
index ae18b88..1438842 100644
--- a/engine/externalanalysis.ml
+++ b/engine/externalanalysis.ml
@@ -291,7 +291,7 @@ let exists p = satisfy (List.exists p)
 
 let single_int c r =
   match r with
-  | IntSet s when Int64Set.is_empty s -> true  (* unreachable memory, thus any propery holds *)
+  | IntSet s when Int64Set.is_empty s -> true  (* unreachable memory, thus any property holds *)
   | IntSet s                   -> Int64Set.equal (Int64Set.singleton c) s
   | IntBounds (Some l, Some u) -> l == c && u == c
   | _                          -> false
diff --git a/demos/demo_rule9/g_NCR5380.c b/demos/demo_rule9/g_NCR5380.c
index ec8a895..c324f77 100644
--- a/demos/demo_rule9/g_NCR5380.c
+++ b/demos/demo_rule9/g_NCR5380.c
@@ -541,7 +541,7 @@ int generic_NCR5380_biosparam(struct scsi_device *sdev,
  *	@dst: buffer to read into
  *	@len: buffer length
  *
- *	Perform a psuedo DMA mode read from an NCR53C400 or equivalent
+ *	Perform a pseudo DMA mode read from an NCR53C400 or equivalent
  *	controller
  */
  
diff --git a/demos/demo_rule9/g_NCR5380.c b/demos/demo_rule9/g_NCR5380.c
index ec8a895..c324f77 100644
--- a/demos/demo_rule9/g_NCR5380.c
+++ b/demos/demo_rule9/g_NCR5380.c
@@ -625,7 +625,7 @@ static inline int NCR5380_pread(struct Scsi_Host *instance, unsigned char *dst,
  *	@dst: buffer to read into
  *	@len: buffer length
  *
- *	Perform a psuedo DMA mode read from an NCR53C400 or equivalent
+ *	Perform a pseudo DMA mode read from an NCR53C400 or equivalent
  *	controller
  */
 
diff --git a/parsing_cocci/get_constants2.ml b/parsing_cocci/get_constants2.ml
index f63fa01..30de099 100644
--- a/parsing_cocci/get_constants2.ml
+++ b/parsing_cocci/get_constants2.ml
@@ -613,7 +613,7 @@ let rule_fn tls in_plus env neg_pos =
 	let was_bot = minuses = True in
 	let new_minuses = filter_combine minuses in_plus in
 	let new_plusses = Common.union_set plusses in_plus in
-	(* perhaps it should be build_and here?  we don't realy have multiple
+	(* perhaps it should be build_and here?  we don't really have multiple
 	   minirules anymore anyway. *)
 	match new_minuses with
 	  True ->
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -9621,7 +9621,7 @@ static void ncr_int_ma (ncb_p np)
 	**	we force a SIR_NEGO_PROTO interrupt (it is a hack that avoids 
 	**	bloat for such a should_not_happen situation).
 	**	In all other situation, we reset the BUS.
-	**	Are these assumptions reasonnable ? (Wait and see ...)
+	**	Are these assumptions reasonable ? (Wait and see ...)
 	*/
 unexpected_phase:
 	dsp -= 8;
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -36,7 +36,7 @@ let pr2, pr2_once = Common.mk_pr2_wrappers Flag_parsing_c.verbose_cfg
  * checktodo: after a switch, need check that all the st in the
  * compound start with a case: ?
  *
- * checktodo: how ensure that when we call aux_statement recursivly, we
+ * checktodo: how ensure that when we call aux_statement recursively, we
  * pass it xi_lbl and not just auxinfo ? how enforce that ?
  * in fact we must either pass a xi_lbl or a newxi
  *
diff --git a/commons/ocamlextra/suffix_tree.ml b/commons/ocamlextra/suffix_tree.ml
index 0635d05..ae2d229 100644
--- a/commons/ocamlextra/suffix_tree.ml
+++ b/commons/ocamlextra/suffix_tree.ml
@@ -141,7 +141,7 @@ let add_link root pred_opt explicit =
    suffix links
    ------------ *)
 
-(* get the node refered by the suffix link at [n] *)
+(* get the node referred by the suffix link at [n] *)
 (*
 let suffix_link (root : node) (n : node) : node =
   match n.link with
diff --git a/commons/ocamlextra/suffix_tree_ext.ml b/commons/ocamlextra/suffix_tree_ext.ml
index 4a363ad..e469fbe 100644
--- a/commons/ocamlextra/suffix_tree_ext.ml
+++ b/commons/ocamlextra/suffix_tree_ext.ml
@@ -141,7 +141,7 @@ let add_link root pred_opt explicit =
    suffix links
    ------------ *)
 
-(* get the node refered by the suffix link at [n] *)
+(* get the node referred by the suffix link at [n] *)
 (*
 let suffix_link (root : node) (n : node) : node =
   match n.link with
diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index ad3c975..3b6a6e9 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -541,7 +541,7 @@ let dup_positions rules =
 	  (List.map r.VT0.combiner_rec_expression explist)
     | _ -> k e in
 
-  let typeC r k e = (* not sure relevent because "only after iso" *)
+  let typeC r k e = (* not sure relevant because "only after iso" *)
     match Ast0.unwrap e with
       Ast0.DisjType(_,types,_,_) ->
 	List.fold_left Common.union_set option_default
diff --git a/commons/parser_combinators.mli b/commons/parser_combinators.mli
index b14c53b..889ce26 100644
--- a/commons/parser_combinators.mli
+++ b/commons/parser_combinators.mli
@@ -18,14 +18,14 @@
 
 (* A generic parser takes a list of stuff (either char for lexical
  * parser or tokens for grammar parser) and return something and the
- * remaing list of stuff. *)
+ * remaining list of stuff. *)
 type ('a, 'b) genp = 'a list -> 'b * 'a list
 val val_of_parser : 'b * 'a list -> 'b
 
 (* lexer = parser of char list *)
 (* type 'a lexer = (char, 'a) genp *)
 
-(* grammer = parser ot tokens *)
+(* grammar = parser ot tokens *)
 (* type 'a pparser = (token, 'a) genp *)
 
 
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -7751,7 +7751,7 @@ void ncr_init (ncb_p np, int reset, char * msg, u_long code)
 		np->rv_ccntl0 |= DPR;
 
 	/*
-	**	C1010_66MHz rev 0 part requies AIPCNTL1 bit 3 to be set.
+	**	C1010_66MHz rev 0 part requires AIPCNTL1 bit 3 to be set.
 	*/
 	if (np->device_id == PCI_DEVICE_ID_LSI_53C1010_66)
 		OUTB(nc_aipcntl1, (1<<3));
diff --git a/testing.ml b/testing.ml
index 88845c4..7ca3a62 100644
--- a/testing.ml
+++ b/testing.ml
@@ -76,7 +76,7 @@ let testone prefix x compare_with_expected_flag =
  * it is possible that a test file work in -test but may not
  * work while used inside a -testall. If we have some bugs in our
  * parser that modify some global state and that those states
- * are not reseted between each test file, then having run previous
+ * are not reset between each test file, then having run previous
  * test files may have an influence on another test file which mean
  * than a test may work in isolation (via -test) but not otherwise
  * (via -testall). Fortunately such bugs are rare.
diff --git a/commons/ocollection/oassocdbm.ml b/commons/ocollection/oassocdbm.ml
index d2523ed..5126912 100644
--- a/commons/ocollection/oassocdbm.ml
+++ b/commons/ocollection/oassocdbm.ml
@@ -5,14 +5,14 @@ open Oassoc
 (* !!take care!!: this class does side effect, not a pure oassoc.
  *
  * The fv/unv are here to give the opportunity to translate the value
- * from the dbm, before marshalling. This is useful for instance if you
- * want to store objects such as oset. Indeed we cant marshall
+ * from the ret, before marshalling. This is useful for instance if you
+ * want to store objects such as oset. Indeed we cannot marshall
  * conveniently functions/closures, and so objects (you can but you can
  * load them back only from the same binary, which limits the
  * practicallibity of the approach). You have to translate them to
- * traditionnal data structures before marshalling them, and you have
- * to rebuild the object from the traditionnal data structure when you
- * get them from the dbm. Hence fv/unv. You can do the same for the key
+ * traditional data structures before marshalling them, and you have
+ * to rebuild the object from the traditional data structure when you
+ * get them from the ret. Hence fv/unv. You can do the same for the key
  * with fkey/unkey, but as key are usually simple data structures,
  * there is less need for them, so I have commented them. *)
 class ['a,'b] oassocdbm   xs db (*fkey unkey*) fv unv =
diff --git a/commons/seti.ml b/commons/seti.ml
index 14b6889..76591bd 100644
--- a/commons/seti.ml
+++ b/commons/seti.ml
@@ -22,7 +22,7 @@ let invariant xs =
       match e with
       | Exact i ->
           if i <= min then pr2 (sprintf "i = %d, min = %d" i min);
-          (* todo: should be even stronger, shoud be i > min+1 *)
+          (* todo: should be even stronger, should be i > min+1 *)
           assert (i > min);
           i
       | Interv (i,j) ->
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1557,7 +1557,7 @@ let check_stack_nbfiles nbfiles =
  * todo? isn't unison or scott-mcpeak-lib-in-cil handles that kind of
  * stuff better ? That is the need to localize command line argument
  * while still being able to gathering them. Same for logging.
- * Similiar to the type prof = PALL | PNONE | PSOME of string list.
+ * Similar to the type prof = PALL | PNONE | PSOME of string list.
  * Same spirit of fine grain config in log4j ?
  *
  * todo? how mercurial/cvs/git manage command line options ? because they
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -43,7 +43,7 @@ open Common
  *
  * convention: I often use 'ii' for the name of a list of info.
  *
- * Sometimes we want to add someting at the beginning or at the end
+ * Sometimes we want to add something at the beginning or at the end
  * of a construct. For 'function' and 'decl' we want to add something
  * to their left and for 'if' 'while' et 'for' and so on at their right.
  * We want some kinds of "virtual placeholders" that represent the start or
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1085,7 +1085,7 @@ let print_list pr xs =
     print_string "]";
   end
 
-(* specialised
+(* specialized
 let (string_of_list: char list -> string) =
   List.fold_left (fun acc x -> acc^(Char.escaped x)) ""
 *)
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -9835,7 +9835,7 @@ next:
 
 		/*
 		**	Device returned CHECK CONDITION status.
-		**	Prepare all needed data strutures for getting 
+		**	Prepare all needed data structures for getting 
 		**	sense data.
 		*/
 
diff --git a/engine/ctlcocci_integration.ml b/engine/ctlcocci_integration.ml
index 3758d0a..f7ed3a2 100644
--- a/engine/ctlcocci_integration.ml
+++ b/engine/ctlcocci_integration.ml
@@ -84,7 +84,7 @@ let show_isos rule_elem =
 let (-->) x v = Ast_ctl.Subst (x,v);;
 
 (* Take list of predicate and for each predicate returns where in the
- * control flow it matches, and the set of subsitutions for this match.
+ * control flow it matches, and the set of substitutions for this match.
  *)
 let (labels_for_ctl: string list (* dropped isos *) ->
  (nodei * F.node) list -> Lib_engine.metavars_binding ->
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -5834,7 +5834,7 @@ ncr_attach (Scsi_Host_Template *tpnt, int unit, ncr_device *device)
 
 	/*
 	**	Install the interrupt handler.
-	**	If we synchonize the C code with SCRIPTS on interrupt, 
+	**	If we support the C code with SCRIPTS on interrupt, 
 	**	we donnot want to share the INTR line at all.
 	*/
 	if (request_irq(device->slot.irq, sym53c8xx_intr,
diff --git a/changes.txt b/changes.txt
index c4b64c4..4c51cab 100644
--- a/changes.txt
+++ b/changes.txt
@@ -717,7 +717,7 @@
   Thanks to Erik Hovland for an example that shows the problem.
 
 ** Internals:
-- supress warning in compiling ocamlsexp (warning caused by a new behavior
+- suppress warning in compiling ocamlsexp (warning caused by a new behavior
   of cpp used internally in processing files in ocamlsexp/)
 
 * 0.1.7
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -11063,7 +11063,7 @@ static void ncr_ppr_nego(ncb_p np, tcb_p tp, ccb_p cp)
 
 	/*
 	**      if target sends sync (wide),
-	**	      it CAN transfer synch (wide).
+	**	      it CAN transfer sync (wide).
 	*/
 
 	if (ofs)
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -1609,7 +1609,7 @@ struct tcb {
 	ccb_p   nego_cp;
 
 	/*----------------------------------------------------------------
-	**	negotiation of wide and synch transfer and device quirks.
+	**	negotiation of wide and sync transfer and device quirks.
 	**	sval, wval and uval are read from SCRIPTS and so have alignment 
 	**	constraints.
 	**----------------------------------------------------------------
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -844,7 +844,7 @@ static int nsp_nexus(Scsi_Cmnd *SCpnt, nsp_hw_data *data)
 
 	//DEBUG(0, "%s: in SCpnt=0x%p\n", __FUNCTION__, SCpnt);
 
-	/* setup synch transfer registers */
+	/* setup sync transfer registers */
 	nsp_index_write(base, SYNCREG,	sync->SyncRegister);
 	nsp_index_write(base, ACKWIDTH, sync->AckWidth);
 
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -10817,7 +10817,7 @@ static void ncr_sync_nego(ncb_p np, tcb_p tp, ccb_p cp)
 
 	/*
 	**      if target sends SDTR message,
-	**	      it CAN transfer synch.
+	**	      it CAN transfer sync.
 	*/
 
 	if (ofs)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1768,7 +1768,7 @@ let (=$=) : string -> string -> bool = (=)
 let (=:=) : bool   -> bool   -> bool = (=)
 
 (* the evil generic (=). I define another symbol to more easily detect
- * it, cos the '=' sign is syntaxically overloaded in caml. It is also
+ * it, cos the '=' sign is syntactically overloaded in caml. It is also
  * used to define function.
  *)
 let (=*=) = (=)
diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 251d35f..7911f69 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -826,7 +826,7 @@ let noInIfdef () =
 (* When want add some info in ast that does not correspond to
  * an existing C element.
  * old: or when don't want 'synchronize' on it in unparse_c.ml
- * (now have other mark for tha matter).
+ * (now have other mark for the matter).
  *)
 let no_virt_pos = ({str="";charpos=0;line=0;column=0;file=""},-1)
 
diff --git a/demos/demo_rule9/nsp_cs.c b/demos/demo_rule9/nsp_cs.c
index 2ad4cce..f2ddf31 100644
--- a/demos/demo_rule9/nsp_cs.c
+++ b/demos/demo_rule9/nsp_cs.c
@@ -1020,7 +1020,7 @@ static void nspintr(int irq, void *dev_id, struct pt_regs *regs)
 			tmpSC->scsi_done(tmpSC);
 			return;
 		}
-		/* fall thru */
+		/* fall through */
 	default:
 		if ((i_src & (IRQSTATUS_SCSI | IRQSTATUS_FIFO)) == 0) {
 			return;
diff --git a/demos/demo_rule9/sym53c8xx.c b/demos/demo_rule9/sym53c8xx.c
index e229c5e..8742329 100644
--- a/demos/demo_rule9/sym53c8xx.c
+++ b/demos/demo_rule9/sym53c8xx.c
@@ -11465,7 +11465,7 @@ void ncr_int_sir (ncb_p np)
                 }
 		goto out;
 	/*
-	**	The device wants us to tranfer more data than 
+	**	The device wants us to transfer more data than 
 	**	expected or in the wrong direction.
 	**	The number of extra bytes is in scratcha.
 	**	It is a data overrun condition.
diff --git a/demos/demo_rule9/scsiglue.c b/demos/demo_rule9/scsiglue.c
index 716af87..9225cc4 100644
--- a/demos/demo_rule9/scsiglue.c
+++ b/demos/demo_rule9/scsiglue.c
@@ -487,7 +487,7 @@ int usb_stor_scsiSense10to6( Scsi_Cmnd* the10 )
   outputBufferSize = *the10Locations.hdr.dataLengthLSB;
   outputBufferSize += USB_STOR_SCSI_SENSE_HDRSZ;
 
-  /* Check to see if we need to trucate the output */
+  /* Check to see if we need to truncate the output */
   if ( outputBufferSize > length )
     {
       printk( KERN_WARNING USB_STORAGE 
diff --git a/demos/demo_rule9/scsiglue.c b/demos/demo_rule9/scsiglue.c
index 716af87..9225cc4 100644
--- a/demos/demo_rule9/scsiglue.c
+++ b/demos/demo_rule9/scsiglue.c
@@ -671,7 +671,7 @@ int usb_stor_scsiSense6to10( Scsi_Cmnd* the6 )
   outputBufferSize = *the6Locations.hdr.dataLength;
   outputBufferSize += USB_STOR_SCSI_SENSE_10_HDRSZ;
 
-  /* Check to see if we need to trucate the output */
+  /* Check to see if we need to truncate the output */
   if ( outputBufferSize > length )
     {
       printk( KERN_WARNING USB_STORAGE 
diff --git a/commons/glimpse.ml b/commons/glimpse.ml
index 232ad83..aa14b14 100644
--- a/commons/glimpse.ml
+++ b/commons/glimpse.ml
@@ -63,7 +63,7 @@ let s_of_glimpse_options xs =
  *
  *
  * Note que glimpseindex index pas forcement tous les fichiers texte.
- * Si le fichier texte est trop petit, contient par exemple un seul mot,
+ * Si le type texte est trop petit, contient par example un seul mot,
  * alors il l'indexe pas. Si veut indexer quand meme, il faudrait ajouter
  * l'option -E
  *
diff --git a/parsing_c/type_c.ml b/parsing_c/type_c.ml
index 3e4d927..1b293c4 100644
--- a/parsing_c/type_c.ml
+++ b/parsing_c/type_c.ml
@@ -347,7 +347,7 @@ let lub op t1 t2 =
      * arithmetic are written with the pointer in the first position.
      *
      * Also when an expression contain a typedef, as in
-     * 'dma_addr + 1' where dma_addr was declared as a varialbe
+     * 'dma_addr + 1' where dma_addr was declared as a variable
      * of type dma_addr_t, then again I want to have in the lub
      * the typedef and it is often again in the first position.
      *
diff --git a/commons/ocamlextra/ANSITerminal.ml b/commons/ocamlextra/ANSITerminal.ml
index 8fcfa4a..b25b973 100644
--- a/commons/ocamlextra/ANSITerminal.ml
+++ b/commons/ocamlextra/ANSITerminal.ml
@@ -162,7 +162,7 @@ let printf style = kprintf (print_string style)
 (*   let ansi_sys = List.find is_readable [ *)
 (*     "C:\\DOS\\ANSI.SYS"; *)
 (*     "C:\\WINDOWS\\COMMAND\\ANSI.SYS"; ] in *)
-(*   (\* Parse CONFIG.SYS to see wether it has the right line *\) *)
+(*   (\* Parse CONFIG.SYS to see whether it has the right line *\) *)
 (*   try *)
 (*     let re = Str.regexp_case_fold *)
 (*                ("^DEVICE\\(HIGH\\)?[ \t]*=[ \t]*" ^ ansi_sys ^ "[ \t]*$") in *)
diff --git a/commons/common.ml b/commons/common.ml
index 46c2682..1b4bda7 100644
--- a/commons/common.ml
+++ b/commons/common.ml
@@ -1524,7 +1524,7 @@ let check_stack_nbfiles nbfiles =
  * why not use strings and do stuff like the following
  * 'if (get_config "verbose_parsing") then ...'
  * Because I want to make the interface for flags easier for the code
- * that use it. The programmer should not be bothered wether this
+ * that use it. The programmer should not be bothered whether this
  * flag is set via args cmd line or a config file, so I want to make it
  * as simple as possible, just use a global plain caml ref variable.
  *
diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index 3dda3ad..e859af0 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -593,7 +593,7 @@ let rec (aux_statement: (nodei option * xinfo) -> statement -> nodei option) =
              (* apparently gcc allows some switch body such as
               *   switch (i) case 0 : printf("here\n");
               *   cf tests-bis/switch_no_body.c
-              * but I don't think it's worthwile to handle
+              * but I don't think it's worthwhile to handle
               * such pathological and rare case. Not worth
               * the complexity. Safe to assume a coumpound.
               *)
_______________________________________________
Cocci mailing list
Cocci at systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
