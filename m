From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 08:43:14 +0200 (CEST)
Subject: [Cocci] parsing of C code
In-Reply-To: <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
 <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
Message-ID: <alpine.DEB.2.20.1708230827550.3212@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Aug 2017, Derek M Jones wrote:

> Julia,
>
> > 1.  More aggressive inclusion of header files, combined with caching of
> > header files.  Now if there is only one occurrence of a header file with a
>
> Caching can be dangerous because macros may be defined differently
> for different includes of the same header.  An option to switch off
> caching could come in handy.

I believe that macros are only applied if they are defined in the same
file.  At this point, I'm not 100% certain of that.  But when I ran the
provided test script on the Linux kernel, I list very few functions as
compared to the current --recursive-includes implementation.  The lost
functions were due to the recovery strategy, not to macro issues.
The Linux kernel has some declarations like

type fn(a1, a2)

with no trailing ; followed by a function definition.  This gives a parse
error on a1.  In the previous version, Coccinelle was able to recover an
parse the function definition.  In the new version, I comment out the
arguments and then another error is encountered that is after the ).  This
causes the recovery process to skip over the subsequent function.  The
recovery code is rather subtle to avoid infinite loops, and so far my
attempts to improve it have led to more of a mess than anything else.

The problem could be solved by not trying to patch up errors in
parentheses when they occur at top level.  When they occur inside a
function, they should not impact the recovery process.

Basically the recovery process is focused on finding a { in column 0 and
then a } in column 0, and then it goes on after that.  But it can go
backwards sometimes, because a parsing problem can cause a parsing attempt
to read too far, into the next function.

>
> > given name in the provided include paths, it will take that one, even if
> > there is no obvious connection between the location of the .c file and the
> > location of the header file.  This compensates for the lact of parsing of
> > Makefiles to extract -I options.  More header files will likely now be
>
> There is no need to parse Makefiles.  Simply create a script, say coc99,
> and configure it as the compiler that make uses.  coc99 parses its
> arguments to extract whatever information cocci needs and passes
> everything to the 'real' C compiler as-is.

At least for the Linux kernel, you can't just run one make and get all the
files to be compiled.  Some files are indeed very hard to compile.  For a
more uniform project this could work, though.

> How is the O'Reilly book coming along ;-)

Still looking for an author :)

julia

>
> --
> Derek M. Jones           Software analysis
> tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
