From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sat, 9 May 2015 16:09:41 +0200
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
Message-ID: <20150509140941.GA13643@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 07 May 2015, ZhouYuan wrote:

your second question regardin if/else was not yet addressed - so here are
some notes on trying to solve this - again this might not be the right 
approach - only got it to work by removing the if structure isomorphisms !

<snip>
> 
>    Also, another example can be witnessed here. I wrote another patch to
>    check whether there is an "else" after  "if" statement:
> 
>      @rule534@
>      function F;
>      position p;
>      statement S1, S2;
>      @@
>      F at p (...){
>      if (...) S1
>      ...when != else S2
>      }
> 
>    But i also got the same "minus: parse error" at the line of when.
>    I would be so appreciated if someone could give me some suggestions about
>    what is wrong in my Patch and how to use when correctly.
>    Thank you so much!

The problem here I think is the default.iso that does not allow
to distinguish the if and else as you like - if we take a simple
general if match like:

<snip>
@ifelse@
function f;
statement S1, S2;
position p;
@@
f (...){
<...
if@p (...) S1 else S2
...>
}
<snip>

and run 
hofrat at debian:/tmp$ spatch --parse-cocci if.cocci 
we get:

ifelse:f(...) {
  <...
  
    
    (
    
    (
    if at ifelse:p (...) ifelse:S1 else ifelse:S2
    |
    if at ifelse:p (...) ifelse:S1
    )
    |
    
    (
    if at ifelse:p (...) ifelse:S2 else ifelse:S1
    |
    if@ifelse:p (...) ifelse:S2
    )
    )
  ...>
}

so the standard.iso "if structure isomorphisms" are not allowing you
to differenciate the if and else here. if you copy that file into
"my.iso" and remove those if structure isomorphisms then you can
differenciate if with and without else.

<snip>
@ifonly@
function f;
statement S1;
position p;
@@
f (...){
<...
*if@p (...) S1
...>
}

@script: python depends on ifonly@
p<<ifonly.p;
@@
print "%s %s" % (p[0].file, p[0].line)
<snip>

The test-case is:

#include <stdio.h>                                                              
<snip>
int bar(void)
{
        int x=2;
        if (x) {
                printf("2\n");
        } else {
                printf("!2\n");
        }
        return 0;
}

int foo(void)
{
        int x=2;
        if (x) {
                printf("2\n");
        }
}
<snip>

run this now with the changed iso file

hofrat at debian:/tmp$ spatch --sp-file if.cocci --iso-file my.iso if.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: if.c
if.c 17
diff = 
--- if.c
+++ /tmp/cocci-output-12260-c3738e-if.c
@@ -14,8 +14,5 @@ int bar(void)
 int foo(void)
 {
        int x=2;
-       if (x) {
-               printf("2\n");
-       }
 }


thx!
hofrat 
