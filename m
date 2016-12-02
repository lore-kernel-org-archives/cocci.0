From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 2 Dec 2016 14:38:44 +0100
Subject: [Cocci] Comparing SmPL script constraints with direct regular
 expression interface
In-Reply-To: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
References: <99797688-d8b2-5001-dd92-26f98e3a4901@users.sourceforge.net>
Message-ID: <19d8e848-da35-10af-6773-deab88137852@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I tried another source code search pattern out with the semantic patch language
from the software ?Coccinelle 1.0.6-00022-g862f5b29 (OCaml 4.03)?.


SmPL script example:

@find_too_late_checking@
expression assign1, assign2, ex1, ex2;
identifier action1 =~ "^(?x)
(?:
   k(?:[cmz]alloc|(?:m(?:alloc_array|em_cache_alloc(?:_node)?)|zalloc_node))
|  of_find_matching_node
# Alternation placeholder
)$",
           action2 =~ "^(?x)
(?:
   k(?:[cmz]alloc|(?:m(?:alloc_array|em_cache_alloc(?:_node)?)|zalloc_node))
|  of_find_matching_node
# Alternation placeholder
)$",
           work;
statement is, es;
type return_type;
@@
 return_type work(...)
 {
 ... when any
*ex1 = action1(...);
 ex2 = action2(...);
 ... when any
     when != (ex1 = assign1)
     when != (ex2 = assign2)
 if (
*      \( !(ex1) \| (ex1) == NULL \)
    || \( !(ex2) \| (ex2) == NULL \)
    || ...)
    is
 else
    es
 ... when any
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_too_late_checking1.cocci ../Probe/clk-mstp-excerpt1.c
?
diff = 
--- ../Probe/clk-mstp-excerpt1.c
+++ /tmp/cocci-output-23612-4723e1-clk-mstp-excerpt1.c
@@ -5,9 +5,7 @@ static void __init cpg_mstp_clocks_init(
 	struct clk **clks;
 	unsigned int i;
 
-	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
-	if (group == NULL || clks == NULL) {
 		kfree(group);
 		kfree(clks);
 		pr_err("%s: failed to allocate group\n", __func__);


This source code analysis approach is incomplete so far. It demonstrates a few
aspects where further software extensions might help.

1. The semantic patch language supports data processing with regular expressions
   to some degree as direct constraints for metavariables.
   A ?regexp? can be specified for several metavariables. Such regular expressions
   can become very detailed and big so that I got the desire to avoid
   code duplication there as much as possible.
   So it would be nice if SmPL variables can share a specific compiled ?regexp?
   from a single specification place.

2. The support for script constraints was recently mentioned.
   https://github.com/coccinelle/coccinelle/commit/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b

   But I am unsure about their current development and documentation status.
   Are there any more imaginations floating around for the notation and usage
   of named (or ad hoc) predicates?

Regards,
Markus
