From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Apr 2013 14:47:05 +0200 (CEST)
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <515ACBBD.3050309@users.sourceforge.net>
References: <515AAF16.7000706@users.sourceforge.net>
 <alpine.DEB.2.02.1304021344310.1939@hadrien>
 <515ACBBD.3050309@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304021446260.1939@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When I try, it complains because the parameter fun of store_positions does
not have an ident field.  Do you not see that problem?

julia

On Tue, 2 Apr 2013, SF Markus Elfring wrote:

> > Without your semantic patch and some example code, I don't know.
>
> I let the following SmPL filter pattern run on source files from the current
> Linux 3.8.5.
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git
>
>
> elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through> cat
> list_pass-through_functions.cocci
> @initialize:python@
> import sys
> result = []
> mark = ['"', '', '"']
> delimiter = '|'
>
> def store_positions(fun, typ, pt_param, places, data_structure = ""):
>     """Add source code positions to an internal list."""
>
>
>     for place in places:
>
>
>         fields = []
>
>
>         fields.append(fun.ident)
>
>
>
>
>
>         mark[1] = typ
>
>
>         fields.append(''.join(mark))
>
>
>
>
>
>         fields.append(pt_param.ident)
>
>
>         fields.append(data_structure)
>
>
>
>
>
>         mark[1] = place.file.replace('"', '""')
>
>
>         fields.append(''.join(mark))
>
>
>
>
>
>         fields.append(place.line)
>
>
>         fields.append(str(int(place.column) + 1))
>
>
>         result.append(delimiter.join(fields))
>
>
>
>
>
> @is_pass_through@
>
>
> identifier pt_function, input;
> type data_type;
> position pos;
> @@
>  data_type at pos pt_function(...,data_type input,...)
>  {
>   <+...
>   return input;
>   ...+>
>  }
>
> @is_pass_through_member_candidate@
> identifier pt_function, input, tag;
> type data_type;
> position pos;
> @@
>  struct tag
>  {
>   ...
>   data_type at pos (*pt_function)(...,data_type input,...);
>   ...
>  }
>
> @script:python collection1 depends on is_pass_through@
> typ << is_pass_through.data_type;
> fun << is_pass_through.pt_function;
> pt_param << is_pass_through.input;
> places << is_pass_through.pos;
> @@
> store_positions(fun, typ, pt_param, places)
>
> @script:python collection2 depends on is_pass_through_member_candidate@
> tag << is_pass_through_member_candidate.tag;
> typ << is_pass_through_member_candidate.data_type;
> fun << is_pass_through_member_candidate.pt_function;
> pt_param << is_pass_through_member_candidate.input;
> places << is_pass_through_member_candidate.pos;
> @@
> store_positions(fun, typ, pt_param, places, tag)
>
> @finalize:python@
> if result:
>    result.insert(0, delimiter.join(("function", '"data type"', "parameter",
> '"contained in"', '"source file"', "line", "column")))
>    print("\r\n".join(result))
> else:
>    sys.stderr.write("No result for this analysis!\n")
>
>
>
> Regards,
> Markus
>
