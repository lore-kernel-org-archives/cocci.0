From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Feb 2014 23:14:02 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
Message-ID: <530A72AA.3000601@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> But I think that a switch is highly improbable for making such a test,
> so you could just drop it.

I have got another idea for a bit of fine-tuning. I got the impression from the
manual that the SmPL syntax element "singleton" might be applicable.

elfring at Sonne:~/Projekte/Coccinelle/janitor> LINE='-----' && echo $LINE &&
PAT=list_input_parameter_validation2.cocci && cat $PAT && echo $LINE &&
SP=/usr/local/bin/spatch && $SP --version && $SP --sp-file $PAT
/usr/src/linux-stable/fs/btrfs/extent_map.c
-----


@initialize:python@
@@
import sys
result = []
mark = ['"', '', '"']
delimiter = '|'

def store_positions(fun, typ, point, places):
    """Add source code positions to an internal list."""
    for place in places:
        fields = []
        fields.append(fun)

        mark[1] = typ
        fields.append(''.join(mark))

        fields.append(point)

        mark[1] = place.file.replace('"', '""')
        fields.append(''.join(mark))

        fields.append(place.line)
        fields.append(str(int(place.column) + 1))
        result.append(delimiter.join(fields))

@safety_check@
identifier work, input;
type data_type;
position pos;
statement is, es;
@@
 void work at pos(...,data_type input,...)
 {
  ...
( if (!input) return;
| if (input) is
? else es
  ;
)
  ...
 }

@script:python collection depends on safety_check@
typ << safety_check.data_type;
fun << safety_check.work;
point << safety_check.input;
places << safety_check.pos;
@@
store_positions(fun, typ, point, places)

@finalize:python@
@@
if result:
   result.insert(0, delimiter.join(("function", '"data type"', '"parameter"',
'"source file"', "line", "column")))
   print("\r\n".join(result))
else:
   sys.stderr.write("No result for this analysis!\n")
-----
spatch version 1.0.0-rc20 with Python support and with PCRE support
init_defs_builtins: /usr/local/share/coccinelle/standard.h
warning: incompatible arity found on line 36
?safety_check:es
Fatal error: exception Failure("get_before_e: not supported")


Can this situation be improved?

Regards,
Markus
