From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 31 May 2013 12:09:06 +0200 (CEST)
Subject: [Cocci] Slow processing
In-Reply-To: <20130531095801.GA8771@domone.kolej.mff.cuni.cz>
References: <20130531095801.GA8771@domone.kolej.mff.cuni.cz>
Message-ID: <alpine.DEB.2.02.1305311200510.2232@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 31 May 2013, Ond?ej B?lka wrote:

> Hi,
> coccinelle is very slow for certain files. As example I took unused
> variable removal, which takes around 45s.

It is following all control-flow paths.  With the while loop, the
backwards goto, and the ifs inside, there are a lot of them.  In this
case, you probably don't care about loops and gotos.  You can thus use the
flags --no-loops and --no-gotos.  These are unsafe in general, but should
be OK for your case.

I don't think the extern T i; is helping you in any way.  The thing about
an ( | ) is that it sees which pattern matches at a specific position in
the control-flow graph.  Extern declarations are usually global, while the
rest of your rule matches only code within a function definition.  So the
two patterns will never match at the same place.

I guess the comment at the top of the rule suggests that I wrote it :)

julia

> Is this known bug? Or how hard would be to fix it?
>
> A testcase follows:
>
> Note: processing took    43.6s: ./time/test_time.c
>
> // Copyright: (C) 2009 Gilles Muller, Julia Lawall, INRIA, DIKU.  GPLv2.
>
> @@
> type T;
> identifier i;
> constant C;
> @@
>
> (
> extern T i;
> |
> - T i;
>   <+... when != i
> - i = C;
>   ...+>
> )
>
>
>
> /* Copyright (C) 1991-2013 Free Software Foundation, Inc.
>    This file is part of the GNU C Library.
>
>    The GNU C Library is free software; you can redistribute it and/or
>    modify it under the terms of the GNU Lesser General Public
>    License as published by the Free Software Foundation; either
>    version 2.1 of the License, or (at your option) any later version.
>
>    The GNU C Library is distributed in the hope that it will be useful,
>    but WITHOUT ANY WARRANTY; without even the implied warranty of
>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>    Lesser General Public License for more details.
>
>    You should have received a copy of the GNU Lesser General Public
>    License along with the GNU C Library; if not, see
>    <http://www.gnu.org/licenses/>.  */
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <time.h>
>
>
> int
> main (int argc, char **argv)
> {
>   time_t t;
>   register struct tm *tp;
>   struct tm tbuf;
>   int lose = 0;
>
>   --argc;
>   ++argv;
>
>   do
>     {
>       char buf[BUFSIZ];
>       if (argc > 0)
> 	{
> 	  static char buf[BUFSIZ];
> 	  sprintf (buf, "TZ=%s", *argv);
> 	  if (putenv (buf))
> 	    {
> 	      puts ("putenv failed.");
> 	      lose = 1;
> 	    }
> 	  else
> 	    puts (buf);
> 	}
>       tzset ();
>       tbuf.tm_year = 72;
>       tbuf.tm_mon = 0;
>       tbuf.tm_mday = 31;
>       tbuf.tm_hour = 6;
>       tbuf.tm_min = 14;
>       tbuf.tm_sec = 50;
>       tbuf.tm_isdst = -1;
>     doit:;
>       t = mktime (&tbuf);
>       if (t == (time_t) -1)
> 	{
> 	  puts ("mktime() failed?");
> 	  lose = 1;
> 	}
>       tp = localtime (&t);
>       if (tp == NULL)
> 	{
> 	  puts ("localtime() failed.");
> 	  lose = 1;
> 	}
>       else if (strftime (buf, sizeof (buf), "%a %b %d %X %Z %Y", tp) == 0)
> 	{
> 	  puts ("strftime() failed.");
> 	  lose = 1;
> 	}
>       else
> 	puts (buf);
>       if (tbuf.tm_year == 101)
> 	{
> 	  tbuf.tm_year = 97;
> 	  tbuf.tm_mon = 0;
> 	  goto doit;
> 	}
>       ++argv;
>     } while (--argc > 0);
>
>   {
> #define	SIZE	256
>     char buffer[SIZE];
>     time_t curtime;
>     struct tm *loctime;
>
>     curtime = time (NULL);
>
>     loctime = localtime (&curtime);
>
>     fputs (asctime (loctime), stdout);
>
>     strftime (buffer, SIZE, "Today is %A, %B %d.\n", loctime);
>     fputs (buffer, stdout);
>     strftime (buffer, SIZE, "The time is %I:%M %p.\n", loctime);
>     fputs (buffer, stdout);
>
>     loctime->tm_year = 72;
>     loctime->tm_mon = 8;
>     loctime->tm_mday = 12;
>     loctime->tm_hour = 20;
>     loctime->tm_min = 49;
>     loctime->tm_sec = 05;
>     curtime = mktime (loctime);
>     strftime (buffer, SIZE, "%D %T was %w the %jth.\n", loctime);
>     fputs (buffer, stdout);
>   }
>
>   return (lose ? EXIT_FAILURE : EXIT_SUCCESS);
> }
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
