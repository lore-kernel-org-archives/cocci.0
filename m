From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Apr 2013 13:45:00 +0200 (CEST)
Subject: [Cocci] Analysis for Linux source files
In-Reply-To: <515AAF16.7000706@users.sourceforge.net>
References: <515AAF16.7000706@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304021344310.1939@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2 Apr 2013, SF Markus Elfring wrote:

> Hello,
>
> I try out a bit of static source code analysis again by the following command.
>
> elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through>
> XY=/usr/src/linux-stable/ && spatch -sp_file list_pass-through_functions.cocci \
> -dir $XY \
> -I ${XY}include \
> -I ${XY}usr/include \
> -I ${XY}arch/ia64/include \
> -I ${XY}arch/ia64/include/uapi \
> -I ${XY}arch/x86/include \
> -I ${XY}arch/x86/include/generated \
> -I /usr/include \
> -I /usr/include/c++/4.7/tr1 \
> -recursive_includes \
> >list_pass-through_functions-linux.txt \
> 2>list_pass-through_functions-linux-errors.txt
>
>
> I notice results like the following in my log file.
>
> ...
> HANDLING: /usr/src/linux-stable/init/noinitramfs.c
> EXN:Failure("empty list, max_min_ii_by_pos")
> Note: processing took    85.2s: /usr/src/linux-stable/init/noinitramfs.c
> HANDLING: /usr/src/linux-stable/init/do_mounts_md.c
> EXN:Failure("empty list, max_min_ii_by_pos")
> Note: processing took   109.5s: /usr/src/linux-stable/init/do_mounts_md.c

Without your semantic patch and some example code, I don't know.

julia
