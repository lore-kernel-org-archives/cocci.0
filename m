From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Feb 2014 16:37:35 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530A086E.8010901@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Something goes wrong with the switch pattern.  I would have to look into 
why.  But I think that a switch is highly improbable for making such a 
test, so you could just drop it.  You may also want to specify that input 
has pointer type, since you are actually looking for NULL tests, not zero 
tests.

julia

On Sun, 23 Feb 2014, SF Markus Elfring wrote:

> > Not sure what you mean by extended.
> 
> I would also like to try another source code search approach like the following.
> 
> elfring at Sonne:~/Projekte/Coccinelle/janitor> LINE='-----' && echo $LINE &&
> PAT=list_input_parameter_validation1.cocci && cat $PAT && echo $LINE &&
> SP=/usr/local/bin/spatch && $SP --version && $SP --sp-file $PAT
> /usr/src/linux-stable/fs/btrfs/extent_map.c
> -----
> @initialize:python@
> @@
> import sys
> result = []
> mark = ['"', '', '"']
> delimiter = '|'
> 
> def store_positions(fun, typ, point, places):
>     """Add source code positions to an internal list."""
>     for place in places:
>         fields = []
>         fields.append(fun)
> 
>         mark[1] = typ
>         fields.append(''.join(mark))
> 
>         fields.append(point)
> 
>         mark[1] = place.file.replace('"', '""')
>         fields.append(''.join(mark))
> 
>         fields.append(place.line)
>         fields.append(str(int(place.column) + 1))
>         result.append(delimiter.join(fields))
> 
> @safety_check@
> identifier work, input;
> type data_type;
> position pos;
> @@
>  void work at pos(...,data_type input,...)
>  {
>   ...
> (
>   if (!input) return;
> |
>   if (input) { ... }
> |
>   if (input) { ... } else { ... }
> |
>   switch (input) { case 0: return; ... }
> )
>   ...
>  }
> 
> @script:python collection depends on safety_check@
> typ << safety_check.data_type;
> fun << safety_check.work;
> point << safety_check.input;
> places << safety_check.pos;
> @@
> store_positions(fun, typ, point, places)
> 
> @finalize:python@
> @@
> if result:
>    result.insert(0, delimiter.join(("function", '"data type"', '"parameter"',
> '"source file"', "line", "column")))
>    print("\r\n".join(result))
> else:
>    sys.stderr.write("No result for this analysis!\n")
> -----
> spatch version 1.0.0-rc20 with Python support and with PCRE support
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: /usr/src/linux-stable/fs/btrfs/extent_map.c
> No result for this analysis!
> 
> 
> Why is the function "free_extent_map" not displayed here?
> Do I need to adjust my SmPL rule "safety_check" anyhow?
> 
> Regards,
> Markus
> 
