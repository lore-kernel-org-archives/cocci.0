From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 26 Oct 2014 07:07:47 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <5308E617.60705@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53085B37.6030005@users.sourceforge.net>
 <alpine.DEB.2.02.1402221333040.2017@localhost6.localdomain6>
 <5308E617.60705@users.sourceforge.net>
Message-ID: <544C8FB3.9030000@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> spatch version 1.0.0-rc20 with Python support and with PCRE support
[...]
> Fatal error: exception Failure("Show_functions_with_input_pointer_validation:
> already tagged token:
> C code context

I tried this small source code search out again.

elfring at Sonne:~/Projekte/Coccinelle/janitor> date \
> && MY_PATTERN=find_input_pointer_validation2.cocci \
> && cat $MY_PATTERN \
> && echo '-----' \
> && spatch.opt --version \
> && spatch.opt --profile --include-headers-for-types --recursive-includes \
> -I /usr/src/linux-stable/include/linux \
> -I /usr/src/linux-stable/include/uapi \
> -I /usr/src/linux-stable/arch/ia64/include \
> -I /usr/src/linux-stable/include/asm-generic \
> -I /usr/src/linux-stable/include/asm-generic/bitops \
> -I /usr/local/include/c++/4.8.2 \
> -I /usr/local/include/c++/4.8.2/x86_64-unknown-linux-gnu \
> -I /usr/local/include \
> -I /usr/include \
> --sp-file $MY_PATTERN /usr/src/linux-stable/mm/slab.c; \
> date
So 26. Okt 07:02:18 CET 2014
@Show_functions_with_input_pointer_validation@
identifier fun, x;
type t;
@@
*void fun(..., t* x, ...)
 {
  ...
  if (unlikely(ZERO_OR_NULL_PTR(x)))
     return;
  ...
 }
-----
spatch version 1.0.0-rc22 with Python support and with PCRE support
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: /usr/src/linux-stable/mm/slab.c
(ONCE) TYPE: header process.h not found
[...]
(ONCE) TYPE: header trace/events/kmem.h not found
     (ONCE) already tagged but only removed, so safe
diff =
--- /usr/src/linux-stable/mm/slab.c
@@ -3598,7 +3598,6 @@ EXPORT_SYMBOL(kmem_cache_free);
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
-void kfree(const void *objp)
 {
        struct kmem_cache *c;
        unsigned long flags;
Note: processing took    43.5s: /usr/src/linux-stable/mm/slab.c
starting: Common.group_assoc_bykey_eff
ending: Common.group_assoc_bykey_eff, 0.000005s
---------------------
profiling result
---------------------
Main total                               :     43.552 sec          1 count
Main.outfiles computation                :     43.490 sec          1 count
full_engine                              :     43.481 sec          1 count
C parsing                                :     17.765 sec        866 count
TOTAL                                    :     17.763 sec        866 count
HACK                                     :      6.017 sec       2001 count
C parsing.fix_cpp                        :      5.559 sec       1134 count
C parsing.tokens                         :      3.528 sec        867 count
LEXING                                   :      3.506 sec        866 count
Parsing: multi pass                      :      2.818 sec       2369 count
Parsing: 1st pass                        :      2.258 sec      42256 count
MACRO managment                          :      1.725 sec       2671 count
YACC                                     :      1.634 sec      40007 count
TAC.annotate_program                     :      0.983 sec        433 count
show_xxx                                 :      0.855 sec        310 count
C parsing.fix_define                     :      0.761 sec       1733 count
MACRO mgmt prep 2                        :      0.494 sec        866 count
C consistencycheck                       :      0.461 sec        866 count
C parsing.lookahead                      :      0.407 sec     455401 count
Common.full_charpos_to_pos_large         :      0.389 sec        867 count
flow                                     :      0.371 sec      20946 count
C parsing.mk_info_item                   :      0.361 sec      42256 count
C parsing.lex_ident                      :      0.314 sec     313227 count
Type_c.type_of_s                         :      0.234 sec      10649 count
fix_flow                                 :      0.154 sec      15138 count
TAC.add_binding                          :      0.075 sec      18856 count
MACRO mgmt prep 1                        :      0.064 sec        866 count
pre_engine                               :      0.036 sec          1 count
parse cocci                              :      0.032 sec          1 count
bigloop                                  :      0.026 sec          1 count
Show_functions_with_input_pointer_validation :      0.023 sec          1 count
process_a_ctl_a_env_a_toplevel           :      0.023 sec        300 count
mysat                                    :      0.022 sec        300 count
Common.info_from_charpos                 :      0.018 sec         82 count
Common.=~                                :      0.013 sec       9107 count
worth_trying                             :      0.009 sec          1 count
Common.full_charpos_to_pos               :      0.005 sec          2 count
TAC.typedef_fix                          :      0.005 sec      14621 count
C unparsing                              :      0.005 sec          2 count
asttoctl2                                :      0.003 sec          1 count
ctl                                      :      0.000 sec          3 count
Transformation3.transform                :      0.000 sec          1 count
get_glimpse_constants                    :      0.000 sec          1 count
Main.result analysis                     :      0.000 sec          1 count
check_duplicate                          :      0.000 sec          1 count
Common.group_assoc_bykey_eff             :      0.000 sec          1 count
C_vs_c                                   :      0.000 sec          1 count
merge_env                                :      0.000 sec          1 count
post_engine                              :      0.000 sec          1 count
Main.infiles computation                 :      0.000 sec          1 count

So 26. Okt 07:03:01 CET 2014


Do you find this analysis result interesting?

Regards,
Markus
