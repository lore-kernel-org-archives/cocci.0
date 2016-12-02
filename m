From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 11:00:20 +0100
Subject: [Cocci] Finding missing return value checks for some function calls
	with SmPL
Message-ID: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to try another search pattern out with the semantic patch language
from the software ?Coccinelle 1.0.6-00022-g862f5b29 (OCaml 4.03)?.


SmPL script example:

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
|  kmalloc_array
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


Source code example:

static void __init cpg_mstp_clocks_init(struct device_node *np)
{
	struct mstp_clock_group *group;
	const char *idxname;
	struct clk **clks;
	unsigned int i;

	group = kzalloc(sizeof(*group), GFP_KERNEL);
	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
	if (group == NULL || clks == NULL) {
		kfree(group);
		kfree(clks);
		pr_err("%s: failed to allocate group\n", __func__);
		return;
	}
}


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_too_late_checking2.cocci ../Probe/clk-mstp-excerpt1.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
HANDLING: ../Probe/clk-mstp-excerpt1.c


Now I wonder why the first assignment is not marked together with the function call
for further considerations by my source code analysis approach so far.
I would appreciate your advices.

Regards,
Markus
