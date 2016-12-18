From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 18 Dec 2016 17:00:31 +0100 (CET)
Subject: [Cocci] Checking incidence for SmPL initialisation rules after
 parallel script execution
In-Reply-To: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
References: <da6cd1b6-17a0-d5e9-3ba6-7565cc80ce39@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1612181659510.1965@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 18 Dec 2016, SF Markus Elfring wrote:

> Hello,
>
> I noticed some software development progress for an issue like ?SmPL constraints
> are broken for type metavariables.?.
> https://github.com/coccinelle/coccinelle/issues/32
>
>
> Now I am checking further test results from a command like the following
> for the software combination ?Coccinelle 1.0.6-00033-g23cca0a2 (OCaml 4.03.0)?.
>
> spatch.opt -timeout 23 -j 4 --chunksize 1 -sp-file ~/Projekte/Coccinelle/janitor/list_non-void_and_non-static_functions2.cocci -dir ~/geladen/Freeware/Quellen/NetBSD/7.0.2 > ~/Projekte/Bau/NetBSD/Coccinelle/functions1/API2.txt 2> ~/Projekte/Bau/NetBSD/Coccinelle/functions1/API2-errors.txt
>
>
> This script contains also a SmPL rule ?initialize:python? which should output
> a header line (usually once?).
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> ack 'function|"data type"|"source file"|line|column' ~/Projekte/Bau/NetBSD/Coccinelle/functions1/API2.txt | wc -l
> 2022
>
>
> Is it really appropriate that this header appears so often in the shown output file?

Without having the semantic patch and the .c file, ideally with both
cut down to a minimal version that shows the problem, I can't answer this
question.

julia
