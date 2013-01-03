From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Jan 2013 07:34:53 +0100 (CET)
Subject: [Cocci] Problem with variable declared with macro
In-Reply-To: <CAACXqO9NCbawtU=DxMzNz7OgpVumUxi7_pJze4t3D=eZ6eV+Sg@mail.gmail.com>
References: <CAACXqO9uArVgbnU=pGYWGgczHY_tCR6+0yOyBPYA22iP0OgahA@mail.gmail.com>
 <alpine.DEB.2.02.1301022125250.2022@localhost6.localdomain6>
 <CAACXqO9NCbawtU=DxMzNz7OgpVumUxi7_pJze4t3D=eZ6eV+Sg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301030728560.2167@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2 Jan 2013, H?kon L?vdal wrote:

> On 2 January 2013 21:28, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Actually, I was totally off on my explanation.
>>
>> It won't parse
>>
>> #define MACRO1(id) \
>> int id
>>
>> It doesn't accept incomplete statements.  I think it has a special case for
>> while ... do (...).
>
> That was not so good news, because the macros I started having problems
> with are not possible to put inside while ... do. It is the BSD queue.h macros
> like for instance

The point is that you want to change the macro definition as well as the 
use?  Changing the use is no problem.  You just should put declarer name 
in the metavariable list.

To make it possible to change the name, perhaps it would be possible to 
have a case for macros where the right-hand side is unparsed.  Christian?

> /*
> * Singly-linked Tail queue declarations.
> */
> #define STAILQ_HEAD(name, type)                                         \
> struct name {                                                           \
>        struct type *stqh_first;/* first element */                     \
>        struct type **stqh_last;/* addr of last next element */         \
> }
>
> which are used inside struct declarations like for instance
>
> struct device {
>        TAILQ_HEAD(device_list, device) dev_children;
>        ...
> }
>
>
> I initially started writing a script to find usages of a macro containing
> one of the queue macros, but it failed to find anything and then I
> started trying to minimize.
>
> Testing a bit further now I think maybe I reproduced the problem without
> the queue macros (or maybe I have found another...).
>
> $ more macro_match.cocci macro_match.c
> ::::::::::::::
> macro_match.cocci
> ::::::::::::::
>
> @r1@
> @@
>
> *MACRO1(...)
>
>
> @r2@
> @@
>
> *MACRO2(...)
>
> ::::::::::::::
> macro_match.c
> ::::::::::::::
>
> #define MACRO1(id) \
> char * id ## _name = #id
>
> #define MACRO2(id) \
> char * id ## _name = #id;
>
> void f(void)
> {
>        MACRO1(dummy1);
>        MACRO2(dummy2)
> }
>
> $ /tmp/coccinelle/bin/spatch  --verbose-parsing --parse-error-msg
> --sp-file macro_match.cocci macro_match.c
> init_defs_builtins: /tmp/coccinelle/share/coccinelle/standard.h
> HANDLING: macro_match.c
> ERROR-RECOV: found sync end of #define, line 3
> parsing pass2: try again
> ERROR-RECOV: found sync end of #define, line 3
> parse error
> = File "macro_match.c", line 4, column 0,  charpos = 47
>    around = '', whole content =
> badcount: 2
> bad:
> bad: #define MACRO1(id) \
> BAD:!!!!! char * id ## _name = #id
> parse error
> = error in macro_match.c; set verbose_parsing for more info
> badcount: 2
> bad:
> bad: #define MACRO1(id) \
> BAD:!!!!! char * id ## _name = #id
> parse error
> = error in /tmp/cocci-output-17413-41c6dd-macro_match.c; set
> verbose_parsing for more info
> badcount: 2
> bad:
> bad: #define MACRO1(id) \
> BAD:!!!!! char * id ## _name = #id
> diff =
> --- macro_match.c
> +++ /tmp/cocci-output-17413-41c6dd-macro_match.c
> @@ -7,7 +7,6 @@ char * id ## _name = #id;
>
> void f(void)
> {
> -       MACRO1(dummy1);
>        MACRO2(dummy2)
> }
>
> $
>
>
> Even though MACRO1 is parsed as BAD rule r1 is matched,

The parsing of the macro is completely irrelevant to the matching of the 
uses of the macro.

> however r2
> is not triggered although there is no badness to MACRO2.
> What causes r2 not to match? Is it because "MACRO2(dummy2)" looks like
> an incomplete statement?

It looks like an incomplete statement, so it is parsed as something 
bizarre and untransformable.  If you run spatch -parse_c on this code, you 
will get that some tokens are passed.  Those will be MACRO2(dummy2).

It is disadvantageous to successfully parse a macro definition, because 
you can then fall into this case.

julia
