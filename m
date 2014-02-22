From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Feb 2014 19:01:59 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402221333040.2017@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53085B37.6030005@users.sourceforge.net>
 <alpine.DEB.2.02.1402221333040.2017@localhost6.localdomain6>
Message-ID: <5308E617.60705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you want to match a call to ZERO_OR_NULL_PTR, then you need to include 
> that in the semantic patch.  Coccinelle does not expand macros, so if 
> doesn't see the relation to a NULL test.

I have tried a command like the following a moment ago.

elfring at Sonne:~/Projekte/Coccinelle/janitor>
MY_PATTERN=find_input_pointer_validation2.cocci && cat $MY_PATTERN && echo
'-----' && spatch --version && spatch --sp-file $MY_PATTERN
/usr/src/linux-stable/mm/slab.c --recursive-includes -I
/usr/src/linux-stable/include/linux -I /usr/src/linux-stable/include/uapi -I
/usr/src/linux-stable/arch/ia64/include -I
/usr/src/linux-stable/include/asm-generic -I
/usr/src/linux-stable/include/asm-generic/bitops -I /usr/local/include/c++/4.8.2
-I /usr/local/include/c++/4.8.2/x86_64-unknown-linux-gnu -I /usr/local/include
-I /usr/include
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
spatch version 1.0.0-rc20 with Python support and with PCRE support
init_defs_builtins: ...
(ONCE) TYPE: header trace/events/kmem.h not found

previous modification:
MINUS
According to environment 2:
   Show_functions_with_input_pointer_validation.t -> const
void
   Show_functions_with_input_pointer_validation.fun -> id kfree

current modification:
MINUS
According to environment 2:
   Show_functions_with_input_pointer_validation.t -> const void
   Show_functions_with_input_pointer_validation.fun -> id kfree

Fatal error: exception Failure("Show_functions_with_input_pointer_validation:
already tagged token:
C code context
File "/usr/src/linux-stable/mm/slab.c", line 3650, column 11,  charpos = 94972
    around = 'const', whole content = void kfree(const void *objp)")



How can I achieve a better result here?



> What you have proposed is a semntic patch that finds functions that test
> their argument for NULL and return if the test is satisfied.  That gives
> the user some information, but the rules in the Linux kernel are for finding 
> bugs or making transformations.

I try to collect all names for functions which handle passed null pointers in a
known way. I hope that such a function list can be converted into a constraint
for a metavariable in another semantic patch variant.

Regards,
Markus
