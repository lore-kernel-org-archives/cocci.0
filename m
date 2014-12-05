From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 05 Dec 2014 21:05:03 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <alpine.DEB.2.10.1412051633240.2360@hadrien>
References: <5478F848.1080808@users.sourceforge.net>
 <alpine.DEB.2.02.1412032218310.2303@localhost6.localdomain6>
 <547F8C2B.5090601@users.sourceforge.net>
 <alpine.DEB.2.02.1412032334330.2303@localhost6.localdomain6>
 <5481BF42.9040503@users.sourceforge.net>
 <alpine.DEB.2.10.1412051633240.2360@hadrien>
Message-ID: <54820FEF.4080901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> OK, you hve two choices:
> 
> 1. Use the position variables

I might consider their use more for other data processing tasks.


> 2. Extend Coccinelle to handle constraints on types

Would you like to acknowledge that this implementation area
is still an open issue?
https://github.com/coccinelle/coccinelle/issues/32

How do you think about do document corresponding limitations?


> Or I guess a third choice which is to use some other tool.

I can also fiddle with SmPL rules which try to circumvent current
software limitations as a fourth choice, can't we?

I guess that it should work at least to filter on function
implementations which call only a single function.
The missing support for constraints on metavariables with
the data type "type" might not really matter in this specific
use case.

Example:

@non_void_single_function_call@
identifier caller, input, result, work;
type data_type, input_type, return_type;
@@
*return_type caller(..., input_type input, ...)
 {
(
  return work(input);
|
  data_type result = work(input);
  return result;
)
 }

elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file find_non-void_function2.cocci /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
diff =
--- /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
+++ /tmp/cocci-output-20396-ddaa9b-ast_ttm.c
@@ -225,7 +225,6 @@ static struct ttm_tt *ast_ttm_tt_create(
        return tt;
 }

-static int ast_ttm_tt_populate(struct ttm_tt *ttm)
 {
        return ttm_pool_populate(ttm);
 }


A wrapper function was found here which has got also the property "static".
I am trying to improve my source code analysis scripts especially for
this function type.


How do you think about the following differences in the results?

elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file list_functions_with_single_function_call3.cocci /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
warning: void_find_static: inherited metavariable caller not used in the -, +, or context code
warning: non_void_find_static: inherited metavariable caller not used in the -, +, or context code
HANDLING: /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
static|function|"data type"|"parameter"|"source file"|line|column
0|ast_ttm_tt_unpopulate|"struct ttm_tt *"|ttm|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|233|13
elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file list_functions_with_single_function_call4.cocci /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
warning: find_static: inherited metavariable caller not used in the -, +, or context code
HANDLING: /usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c
static|function|"data type"|"parameter"|"source file"|line|column
0|ast_ttm_tt_populate|"struct ttm_tt *"|ttm|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|228|12
0|ast_ttm_tt_unpopulate|"struct ttm_tt *"|ttm|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|233|13


* Both approaches should find more functions here, shouldn't they?
  (See attachments ...)

* It seems that my python function "store_static" is not called so far.
  Is that strange?

Regards,
Markus
-------------- next part --------------
@initialize:python@
@@
import sys
import sqlite3 as SQLite
connection = SQLite.connect(":memory:")
c = connection.cursor()
c.execute("""
create table positions
(static integer default 0,
 function text,
 data_type text,
 parameter text,
 source_file text,
 line integer,
 column integer,
 constraint c
 primary key (function, source_file, line, column)
)
without rowid""")
build_index=True

def store_positions(fun, typ, point, places):
    """Add source code positions to an internal list."""
    for place in places:
        c.execute("""insert into positions
(function,
 data_type,
 parameter,
 source_file,
 line,
 column
)
values (?, ?, ?, ?, ?, ?)""",
                  (fun,
                  typ,
                  point,
                  place.file,
                  place.line,
                  int(place.column) + 1
                  )
                 )

def store_static(fun, places):
    """Record that a function is static."""
    for place in places:
        fields = []
        fields.append("fun:")
        fields.append(fun)
        fields.append("file:")
        fields.append(place.file)
        fields.append("line:")
        fields.append(place.line)
        fields.append("column:")
        fields.append(int(place.column) + 1)
        sys.stderr.write("\n".join())
        sys.stderr.write("\n")
        c.execute("""update positions
set static=1
where function = ?
      and source_file = ?
      and line = ?
      and column = ?""",
                  (fun, place.file, place.line, int(place.column) + 1)
                 )

@void_single_function_call@
identifier caller, input, work;
type input_type;
position pos;
@@
 void caller at pos(input_type input)
 {
(
  work(input);
|
  work(input);
  return;
)
 }

@script:python void_collection depends on void_single_function_call@
typ << void_single_function_call.input_type;
fun << void_single_function_call.caller;
point << void_single_function_call.input;
places << void_single_function_call.pos;
@@
store_positions(fun, typ, point, places)

@non_void_single_function_call@
identifier caller, input, result, work;
type data_type, input_type, return_type;
position pos;
@@
 return_type caller at pos(input_type input)
 {
(
  return work(input);
|
  data_type result = work(input);
  return result;
)
 }

@script:python non_void_collection depends on non_void_single_function_call@
typ << non_void_single_function_call.data_type;
fun << non_void_single_function_call.caller;
point << non_void_single_function_call.input;
places << non_void_single_function_call.pos;
@@
store_positions(fun, typ, point, places)

@void_find_static depends on void_single_function_call@
identifier void_single_function_call.caller;
position void_single_function_call.pos;
@@
 static void callerk at pos(...)
 {
  ...
 }

@non_void_find_static depends on non_void_single_function_call@
identifier non_void_single_function_call.caller;
type non_void_single_function_call.return_type;
position non_void_single_function_call.pos;
@@
 static return_type callerk@pos(...)
 {
  ...
 }

@script:python index_creation@
@@
if build_index:
   c.execute("""
create unique index x
on positions(function, source_file, line, column)""")
   build_index=False

@script:python void_addition depends on void_find_static@
fun << void_single_function_call.caller;
places << void_single_function_call.pos;
@@
store_static(fun, places)

@script:python non_void_addition depends on non_void_find_static@
fun << non_void_single_function_call.caller;
places << non_void_single_function_call.pos;
@@
store_static(fun, places)

@finalize:python@
@@
c.execute("select count(*) nr from positions")
entry = c.fetchone()

if entry[0] > 0:
   c.execute("""
select *
from positions
order by source_file, function, line, column""")
   mark1 = ['"', '', '"']
   mark2 = ['"', '', '"']
   delimiter = '|'
   sys.stdout.write(delimiter.join(("static",
                                    "function",
                                    '"data type"',
                                    '"parameter"',
                                    '"source file"',
                                    "line",
                                    "column"
                                   )))
   sys.stdout.write("\r\n")
   for entry in c:
      mark1[1] = entry[2]
      mark2[1] = entry[4].replace('"', '""')
      sys.stdout.write(delimiter.join((str(entry[0]),
                                       entry[1],
                                       ''.join(mark1),
                                       entry[3],
                                       ''.join(mark2),
                                       str(entry[5]),
                                       str(entry[6])
                                      )))
      sys.stdout.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")

connection.close()
-------------- next part --------------
@initialize:python@
@@
import sys
import sqlite3 as SQLite
connection = SQLite.connect(":memory:")
c = connection.cursor()
c.execute("""
create table positions
(static integer default 0,
 function text,
 data_type text,
 parameter text,
 source_file text,
 line integer,
 column integer,
 constraint c
 primary key (function, source_file, line, column)
)
without rowid""")
build_index=True

def store_positions(fun, typ, point, places):
    """Add source code positions to an internal list."""
    for place in places:
        c.execute("""insert into positions
(function,
 data_type,
 parameter,
 source_file,
 line,
 column
)
values (?, ?, ?, ?, ?, ?)""",
                  (fun,
                  typ,
                  point,
                  place.file,
                  place.line,
                  int(place.column) + 1
                  )
                 )

def store_static(fun, places):
    """Record that a function is static."""
    for place in places:
        c.execute("""update positions
set static=1
where function = ?
      and source_file = ?
      and line = ?
      and column = ?""",
                  (fun, place.file, place.line, int(place.column) + 1)
                 )

@single_function_call@
identifier caller, input, result, work;
type data_type, input_type, return_type;
position pos;
@@
 return_type caller at pos(input_type input)
 {
(
  work(input);
|
  return work(input);
|
  data_type result = work(input);
  return result;
|
  work(input);
  return;
)
 }

@script:python collection depends on single_function_call@
typ << single_function_call.input_type;
fun << single_function_call.caller;
point << single_function_call.input;
places << single_function_call.pos;
@@
store_positions(fun, typ, point, places)

@find_static depends on single_function_call@
identifier single_function_call.caller;
type single_function_call.return_type;
position single_function_call.pos;
@@
 static return_type callerk@pos(...)
 {
  ...
 }

@script:python index_creation@
@@
if build_index:
   c.execute("""
create unique index x
on positions(function, source_file, line, column)""")
   build_index=False

@script:python addition depends on find_static@
fun << single_function_call.caller;
places << single_function_call.pos;
@@
store_static(fun, places)

@finalize:python@
@@
c.execute("select count(*) nr from positions")
entry = c.fetchone()

if entry[0] > 0:
   c.execute("""
select *
from positions
order by source_file, function, line, column""")
   mark1 = ['"', '', '"']
   mark2 = ['"', '', '"']
   delimiter = '|'
   sys.stdout.write(delimiter.join(("static",
                                    "function",
                                    '"data type"',
                                    '"parameter"',
                                    '"source file"',
                                    "line",
                                    "column"
                                   )))
   sys.stdout.write("\r\n")
   for entry in c:
      mark1[1] = entry[2]
      mark2[1] = entry[4].replace('"', '""')
      sys.stdout.write(delimiter.join((str(entry[0]),
                                       entry[1],
                                       ''.join(mark1),
                                       entry[3],
                                       ''.join(mark2),
                                       str(entry[5]),
                                       str(entry[6])
                                      )))
      sys.stdout.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")

connection.close()
