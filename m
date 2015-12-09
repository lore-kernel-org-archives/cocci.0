From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Dec 2015 14:50:48 +0100
Subject: [Cocci] Finding usage of the statement "goto" with SmPL
Message-ID: <566831B8.1020306@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried another tiny SmPL script out.

@jumping@
identifier label;
@@
*goto label;


This test example works as expected.

elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_goto_usage1.cocci ~/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c
?
@@ -1424,7 +1400,6 @@ static int __init zram_init(void)
                ret = zram_add();
                mutex_unlock(&zram_index_mutex);
                if (ret < 0)
-                       goto out_error;
                num_devices--;
        }
 

Now I am trying also to generate other display formats for the corresponding data
with a SmPL approach like the following.

?
@contains_goto@
identifier label, work;
position g_pos, pos;
type return_type;
@@
 return_type work at pos(...)
 {
 ... when any
 goto label at g_pos;
 ... when any
 }

@script:python collection depends on contains_goto@
fun << contains_goto.work;
places << contains_goto.pos;
go_to << contains_goto.label;
jump_at << contains_goto.g_pos;
@@
print("collection: " + "fun=" + fun + " | go_to=" + go_to)
store_positions(fun, places, go_to, jump_at)
?


elfring@Sonne:~/Projekte/Coccinelle/janitor/jumping1> spatch.opt list_functions_with_goto1.cocci ~/Projekte/Linux/next-patched/drivers/block/zram/zram_drv.c
?
No result for this analysis!


Unfortunately, I get the impression that the SmPL rule does not get executed
because the base rule "contains_goto" might not produce the desired data.
How should this surprise be resolved?

Regards,
Markus
