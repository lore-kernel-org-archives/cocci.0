From: wharms@bfs.de (walter harms)
Date: Mon, 01 Dec 2014 12:23:38 +0100
Subject: [Cocci] Determination for the number of named function
 parameters (with SmPL)
In-Reply-To: <547C4D11.1050206@users.sourceforge.net>
References: <547C4D11.1050206@users.sourceforge.net>
Message-ID: <547C4FBA.90808@bfs.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



Am 01.12.2014 12:12, schrieb SF Markus Elfring:
> Hello,
> 
> Would you like to know how many named function parameters are used in the source files?
> 
> How do you think about to try the following semantic query approach out a bit more?
> 
> @initialize:python@
> @@
> import sys
> import sqlite3 as SQLite
> connection = SQLite.connect(":memory:")
> c = connection.cursor()
> c.execute("""create table numbers (number integer)""")
> delimiter = "|"
> 
> def store_number(count):
>     """Add an integer to an internal list."""
>     c.execute("""insert into numbers (number) values (?)""",
>               (count, )
>              )
> 
> @counting_parameters@
> identifier work;
> parameter list[number] pl;
> type return_type;
> @@
>  return_type work(pl)
>  {
>   ...
>  }
> 
> @script:python collection@
> count << counting_parameters.number;
> @@
> store_number(count)
> 
> @finalize:python@
> @@
> c.execute("""select count(*) nr from numbers""")
> result = c.fetchone()
> 
> if result[0] > 0:
>    c.execute("""create index x on numbers (number)""")
>    c.execute("select number, count(*) nr from numbers group by number")
>    sys.stdout.write(delimiter.join( ("number", "counter") ))
>    sys.stdout.write("\r\n")
>    for result in c:
>       sys.stdout.write(delimiter.join((str(result[0]),
>                                        str(result[1])
>                                       )))
>       sys.stdout.write("\r\n")
> else:
>    sys.stderr.write("No result for this analysis!\n")
> 
> connection.close()
> 
> 
> 
> elfring at Sonne:~/Projekte/Coccinelle/Probe> XX=$(date) && spatch.opt -timeout 12 -sp-file list_parameter_numbers1.cocci -dir /usr/src/linux-stable > list_parameter_numbers1.txt 2> list_parameter_numbers1-errors.txt ; YY=$(date) && echo "$XX * $YY"
> ...
> elfring at Sonne:~/Projekte/Coccinelle/Probe> cat list_parameter_numbers1.txt
> number|counter
> 0|29
> 1|18261
> 2|15374
> 3|12237
> 4|8159
> 5|4339
> 6|2701
> 7|1183
> 8|518
> 9|260
> 10|146
> 11|83
> 12|42
> 13|21
> 14|9
> 15|7
> 16|2
> 17|4
> 18|1
> 21|1
> 22|1
> 
> 
> Do you find such an analysis result from the source files for Linux 3.17.4
> interesting for further considerations?
> 

 I am not sure that i understand these result.
Does that mean there are actually functions taking 22 arguments ?

re
 wh
