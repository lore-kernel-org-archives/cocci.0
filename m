From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 11:20:14 +0100
Subject: [Cocci] Finding missing return value checks for some function
 calls with SmPL
In-Reply-To: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
Message-ID: <e853f47b-78be-7450-a420-b301f4f504d1@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Now I wonder why the first assignment is not marked together with the function call
> for further considerations by my source code analysis approach so far.

I should have adjusted one of the used regular expressions a bit more like the following.


@find_too_late_checking@
expression ex1, ex2;
identifier action1 =~ "^(?x)
(?:
   kzalloc
|  kmalloc_array
)$",
           action2 =~ "^(?x)
(?:
   kzalloc
|  kmalloc(?:_array)?
)$",
           work;
type return_type;
@@
 return_type work(...)
 {
 ... when any
*ex1 = action1(...);
 ex2 = action2(...);
 ... when any
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_too_late_checking2.cocci ../Probe/clk-mstp-excerpt1.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
HANDLING: ../Probe/clk-mstp-excerpt1.c
diff = 
--- ../Probe/clk-mstp-excerpt1.c
+++ /tmp/cocci-output-20109-52f048-clk-mstp-excerpt1.c
@@ -5,7 +5,6 @@ static void __init cpg_mstp_clocks_init(
 	struct clk **clks;
 	unsigned int i;
 
-	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
 	if (group == NULL || clks == NULL) {
 		kfree(group);


I imagine that there are further software improvements to consider around
such use cases.

Regards,
Markus
