From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 03 Dec 2014 11:30:43 +0100
Subject: [Cocci] Determination for the number of named function
 parameters (with SmPL)
In-Reply-To: <8DDAD79C-96D4-43BA-BC3F-F9EE237D2C60@gmail.com>
References: <547C4D11.1050206@users.sourceforge.net>
 <8DDAD79C-96D4-43BA-BC3F-F9EE237D2C60@gmail.com>
Message-ID: <547EE653.5000901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> elfring at Sonne:~/Projekte/Coccinelle/Probe> cat list_parameter_numbers1.txt
>> number|counter
>> 0|29
> 
> I think the results are dubious. Only 29 functions with no parameters?
> That can't be right.

How do you think about to experiment a bit more with the following
semantic query approach?

@initialize:python@
@@
import sys
import sqlite3 as SQLite
connection = SQLite.connect(":memory:")
c = connection.cursor()
c.execute("""
create table numbers
(parameter_number integer,
 function text,
 source_file text,
 line integer,
 column integer,
 constraint c
 primary key (function, source_file, line, column)
)
without rowid""")

def store_number(count, fun, places):
    """Add an integer to an internal list."""
    for place in places:
        c.execute("""insert into numbers
(parameter_number,
 function,
 source_file,
 line,
 column
)
values (?, ?, ?, ?, ?)""",
                  (count,
                   fun,
                   place.file,
                   place.line,
                   int(place.column) + 1
                  )
                 )

@counting_parameters@
identifier work;
parameter list[number] pl;
position pos;
type return_type;
@@
 return_type work at pos(pl)
 {
  ...
 }

@script:python collection@
count << counting_parameters.number;
fun << counting_parameters.work;
places << counting_parameters.pos;
@@
store_number(count, fun, places)

@finalize:python@
@@
c.execute("""select count(*) nr from numbers""")
result = c.fetchone()

if result[0] > 0:
   c.execute("""create index x on numbers (parameter_number)""")
   c.execute("""select *
from numbers
where parameter_number > 12
order by parameter_number desc, function, source_file""")
   delimiter = "|"
   mark1 = ['"', '', '"']
   mark2 = ['"', '', '"']
   sys.stdout.write(delimiter.join(('"parameter number"',
                                    "function",
                                    '"source file"',
                                    "line",
                                    "column"
                                   )))
   sys.stdout.write("\r\n")
   for entry in c:
      mark1[1] = entry[1]
      mark2[1] = entry[2].replace('"', '""')
      sys.stdout.write(delimiter.join((str(entry[0]),
                                       ''.join(mark1),
                                       ''.join(mark2),
                                       str(entry[3]),
                                       str(entry[4])
                                      )))
      sys.stdout.write("\r\n")
else:
   sys.stderr.write("No result for this analysis!\n")

connection.close()


elfring at Sonne:~/Projekte/Linux/next-patched> XX=$(date) && spatch.opt -timeout 12 -sp-file ~/Projekte/Coccinelle/Probe/list_parameter_numbers1b.cocci -dir . > list_parameter_numbers1b.txt 2> list_parameter_numbers1b-errors.txt ; YY=$(date) && echo "$XX * $YY"
Mi 3. Dez 08:46:17 CET 2014 * Mi 3. Dez 09:13:14 CET 2014
elfring at Sonne:~/Projekte/Linux/next-patched> cat list_parameter_numbers1b.txt
"parameter number"|function|"source file"|line|column
22|"send_cap_msg"|"./fs/ceph/caps.c"|968|12
21|"dispc_ovl_setup_common"|"./drivers/video/fbdev/omap2/dss/dispc.c"|2414|12
...
13|"src_sync_cmd"|"./drivers/scsi/aacraid/src.c"|172|12
13|"submit_extent_page"|"./fs/btrfs/extent_io.c"|2761|12


Regards,
Markus
