From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Wed, 2 Jan 2013 22:07:49 +0100
Subject: [Cocci] Problem with variable declared with macro
In-Reply-To: <alpine.DEB.2.02.1301022125250.2022@localhost6.localdomain6>
References: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
 <alpine.DEB.2.02.1301022125250.2022@localhost6.localdomain6>
Message-ID: <CAACXqO9NCbawtU=DxMzNz7OgpVumUxi7_pJze4t3D=eZ6eV+Sg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2 January 2013 21:28, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Actually, I was totally off on my explanation.
>
> It won't parse
>
> #define MACRO1(id) \
> int id
>
> It doesn't accept incomplete statements.  I think it has a special case for
> while ... do (...).

That was not so good news, because the macros I started having problems
with are not possible to put inside while ... do. It is the BSD queue.h macros
like for instance

/*
 * Singly-linked Tail queue declarations.
 */
#define STAILQ_HEAD(name, type)                                         \
struct name {                                                           \
        struct type *stqh_first;/* first element */                     \
        struct type **stqh_last;/* addr of last next element */         \
}

which are used inside struct declarations like for instance

struct device {
        TAILQ_HEAD(device_list, device) dev_children;
        ...
}


I initially started writing a script to find usages of a macro containing
one of the queue macros, but it failed to find anything and then I
started trying to minimize.

Testing a bit further now I think maybe I reproduced the problem without
the queue macros (or maybe I have found another...).

$ more macro_match.cocci macro_match.c
::::::::::::::
macro_match.cocci
::::::::::::::

@r1@
@@

*MACRO1(...)


@r2@
@@

*MACRO2(...)

::::::::::::::
macro_match.c
::::::::::::::

#define MACRO1(id) \
char * id ## _name = #id

#define MACRO2(id) \
char * id ## _name = #id;

void f(void)
{
        MACRO1(dummy1);
        MACRO2(dummy2)
}

$ /tmp/coccinelle/bin/spatch  --verbose-parsing --parse-error-msg
--sp-file macro_match.cocci macro_match.c
init_defs_builtins: /tmp/coccinelle/share/coccinelle/standard.h
HANDLING: macro_match.c
ERROR-RECOV: found sync end of #define, line 3
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 3
parse error
 = File "macro_match.c", line 4, column 0,  charpos = 47
    around = '', whole content =
badcount: 2
bad:
bad: #define MACRO1(id) \
BAD:!!!!! char * id ## _name = #id
parse error
 = error in macro_match.c; set verbose_parsing for more info
badcount: 2
bad:
bad: #define MACRO1(id) \
BAD:!!!!! char * id ## _name = #id
parse error
 = error in /tmp/cocci-output-17413-41c6dd-macro_match.c; set
verbose_parsing for more info
badcount: 2
bad:
bad: #define MACRO1(id) \
BAD:!!!!! char * id ## _name = #id
diff =
--- macro_match.c
+++ /tmp/cocci-output-17413-41c6dd-macro_match.c
@@ -7,7 +7,6 @@ char * id ## _name = #id;

 void f(void)
 {
-       MACRO1(dummy1);
        MACRO2(dummy2)
 }

$


Even though MACRO1 is parsed as BAD rule r1 is matched, however r2
is not triggered although there is no badness to MACRO2.
What causes r2 not to match? Is it because "MACRO2(dummy2)" looks like
an incomplete statement?
