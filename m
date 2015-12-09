From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Dec 2015 15:01:01 +0100 (CET)
Subject: [Cocci] Finding usage of the statement "goto" with SmPL
In-Reply-To: <566831B8.1020306@users.sourceforge.net>
References: <566831B8.1020306@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1512091458390.2491@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Dec 2015, SF Markus Elfring wrote:

> Hello,
>
> I have tried another tiny SmPL script out.
>
> @jumping@
> identifier label;
> @@
> *goto label;
>
>
> This test example works as expected.
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_goto_usage1.cocci ~/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c
> ?
> @@ -1424,7 +1400,6 @@ static int __init zram_init(void)
>                 ret = zram_add();
>                 mutex_unlock(&zram_index_mutex);
>                 if (ret < 0)
> -                       goto out_error;
>                 num_devices--;
>         }
>
>
> Now I am trying also to generate other display formats for the corresponding data
> with a SmPL approach like the following.
>
> ?
> @contains_goto@
> identifier label, work;
> position g_pos, pos;
> type return_type;
> @@
>  return_type work at pos(...)
>  {
>  ... when any
>  goto label at g_pos;
>  ... when any
>  }
>
> @script:python collection depends on contains_goto@
> fun << contains_goto.work;
> places << contains_goto.pos;
> go_to << contains_goto.label;
> jump_at << contains_goto.g_pos;
> @@
> print("collection: " + "fun=" + fun + " | go_to=" + go_to)
> store_positions(fun, places, go_to, jump_at)
> ?
>
>
> elfring at Sonne:~/Projekte/Coccinelle/janitor/jumping1> spatch.opt list_functions_with_goto1.cocci ~/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c
> ?
> No result for this analysis!

It doesn't match anything because when you write a rule that has no *,
then it is considered that you want the pattern to match on every
execution path.  It is unlikely that the goto is on every execution path,
so you get nothing.  To solve the problem, just put exists in the initial
@@

If you don't care about the position of the function header of the
containing function, but could live with just the function name, you can
access it much more efficiently from a position variable on the goto, in
the field current_element.

julia
