From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 04 Oct 2014 22:22:49 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
Message-ID: <54305719.1050304@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> How are the chances to complete the desired data extraction for all 23753 C
>> files in a shorter time frame?
> 
> Use the timeout option.

I would like to avoid it because I do not really have got an overview for source
file sizes and corresponding source code complexity.


> Then hopefully you can get a result for 23753-1 files.

Would you like to try out the discussed source code analysis approach also on
your software development system?

elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through> spatch.opt -debug
--include-headers-for-types -I /usr/src/linux-stable/include -sp_file
list_pass-through_functions.cocci
/usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c



init_defs_builtins: /usr/local/share/coccinelle/standard.h


-----------------------------------------------------------------------


processing semantic patch file: list_pass-through_functions.cocci


with isos from: /usr/local/share/coccinelle/standard.iso


-----------------------------------------------------------------------


@initialize:python@


@@


import sys


result = []


mark = ['"', '', '"']
delimiter = '|'

def store_positions(fun, typ, pt_param, places, data_structure = ""):
    """Add source code positions to an internal list."""
    for place in places:
        fields = []
        fields.append(fun)

        mark[1] = typ
        fields.append(''.join(mark))

        fields.append(pt_param)
        fields.append(data_structure)

        mark[1] = place.file.replace('"', '""')
        fields.append(''.join(mark))

        fields.append(place.line)
        fields.append(str(int(place.column) + 1))
        result.append(delimiter.join(fields))

@is_pass_through@
identifier pt_function, input;
type data_type;
position pos;
@@
 data_type at pos pt_function(...,data_type input,...)
 {
  <+...
  return input;
  ...+>
 }

@is_pass_through_member_candidate@
identifier pt_function, input, tag;
type data_type;
position pos;
@@
 struct tag
 {
  ...
  data_type at pos (*pt_function)(...,data_type input,...);
  ...
 }

@script:python collection1 depends on is_pass_through@
typ << is_pass_through.data_type;
fun << is_pass_through.pt_function;
pt_param << is_pass_through.input;
places << is_pass_through.pos;
@@
store_positions(fun, typ, pt_param, places)

@script:python collection2 depends on is_pass_through_member_candidate@
tag << is_pass_through_member_candidate.tag;
typ << is_pass_through_member_candidate.data_type;
fun << is_pass_through_member_candidate.pt_function;
pt_param << is_pass_through_member_candidate.input;
places << is_pass_through_member_candidate.pos;
@@
store_positions(fun, typ, pt_param, places, tag)

@finalize:python@
@@
if result:
   result.insert(0, delimiter.join(("function", '"data type"', "parameter",
'"contained in"', '"source file"', "line", "column")))
   print("\r\n".join(result))
else:
   sys.stderr.write("No result for this analysis!\n")

-----------------------------------------------------------------------
script rule 1 =
-----------------------------------------------------------------------
dependencies for script satisfied:
binding in = []
HANDLING: /usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
is_pass_through =
-----------------------------------------------------------------------
dependencies for rule is_pass_through satisfied:
binding in = []
binding relevant in = []
     (ONCE) USING optional_storage builtin isomorphism
^C     C-c intercepted, will do some cleaning before exiting


In which time frame should such a SmPL script be usually executed?

Regards,
Markus
