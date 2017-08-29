From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Aug 2017 23:17:53 +0200 (CEST)
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
References: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1708292315050.5428@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 29 Aug 2017, Ond?ej Kuzn?k wrote:

> Hi again,
> having achieved some consensus to go ahead with this in the project and
> some time to spare again, I have started on refining the patch to get as large
> part of the OpenLDAP source code converted as possible.
>
> There seem to be a few hundred occurrences that I can't seem to get
> coccinelle to process, a few too many to process manually (by an order
> of magnitude).
>

Allowing format list to match strings in multiple pieces seems like a
somewhat complex undertaking.

Perhaps the following could be acceptable?

@initialize:ocaml@
@@

let fmtn(fmt,n) =
   List.length (Str.split_delim (Str.regexp_string "%") fmt) = 3

@@
char[] fmt : script:ocaml() { fmtn(fmt,2) };
expression list[2] args;
expression E;
@@

Debug( E, fmt, args
-, 0
 );

You would have to duplicate the latter rule for each possible number of
arugments.

julia
