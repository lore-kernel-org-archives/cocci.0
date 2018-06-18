From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jun 2018 20:11:13 +0200 (CEST)
Subject: [Cocci] Something like --exclude?
In-Reply-To: <CAGXu5j+AK-Bkv5k-wMpPt7asmU+AmusRjeFOSjwYqomD-PB0fA@mail.gmail.com>
References: <CAGXu5j+AK-Bkv5k-wMpPt7asmU+AmusRjeFOSjwYqomD-PB0fA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1806182006580.3293@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Jun 2018, Kees Cook wrote:

> Hi,
>
> I normally use "--dir ." when doing recursive runs in the kernel tree,
> but I want to avoid changes in the tools/ subdirectory. I can't find
> anything like --exclude, and --dir can't be specified multiple times.
> Is there an existing solution I'm missing?

It's rather clunky, but you can make a python rule to depart from such a
file immediately.  In OCaml, I would write (you should be able to take
this code as is):

@script:ocaml@
@@

let file = List.hd (Coccilib.files()) in
if List.mem "tools" (Str.split (Str.regexp "/") file)
then Coccilib.exit()

The disadvantage of putting the rule just like that is that Coccinelle
will think that every file is relevant.  So you may want to do something
like:

@r@
@@

important_function_name(...)

@script:ocaml depends on r@
@@

{the code above}

Then Coccinelle will only consider processing files that contain
important_function_name.

julia
