From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 28 Aug 2018 15:19:08 -0700 (PDT)
Subject: [Cocci] coccinelle to rescue for "C++11 requires a space
 between literal and string macro"
In-Reply-To: <DM3PR14MB0766042ACA4CECA31C33FF29800A0@DM3PR14MB0766.namprd14.prod.outlook.com>
References: <DM3PR14MB0766042ACA4CECA31C33FF29800A0@DM3PR14MB0766.namprd14.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1808281514290.2555@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 28 Aug 2018, Felix Blyakher wrote:

> Hello coccinelle experts,
>
> I'm working with the legacy code and with newish gcc 7.3 hit the following warning:
>
> warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]
>  #define PADARG64 "0x%016"QUAD"x"
>                   ^
>
> where QUAD is a platform dependent string, thus the macro.
>
> The string concatenation works in C OK for this code, though, gcc rightfully complains
> about required space and wants it to be:
>
>  #define PADARG64 "0x%016" QUAD "x"
>
> The code like this is sprinkled across huge code base, mostly in printf-like statements,
> and some in defines like above to be used in printf-like statements.
>
> I'd like to use coccinelle to change the code globally.
> I was trying something like (I know it may have false positive, just need to get something for starter):
>
>
> @@
> Identifier I;
> @@
>
> -"I"
> +" I "

Coccinelle doesn't interpret things inside strings, except format
directives.  Also, identifier shouldn't be capitalized.

What you want is:

@@
constant char[] c;
@@

- c
+ c

When Coccinelle adds the string back, it will pretty print it properly.
If you want to see a diff in the output, put --force-diff on the command
line.  Normally Coccinelle doesn't print a diff when there are only
whitespace changes.

This will work on every string in your code.  If you don't want this, then
you can put:

constant char[] c : script:python { check c };

where check is some python code you write under

@initialize:python@
@@

def check ...

to check whether it is a string with multiple pieces.  Note that the c
that check received will have the spaces already, so it won't be possible
to tell if the string is actually missing spaces.  But you can distinguish
strings in multiple pieces from string that are atomic.

Let me know if anything is not clear.

julia
