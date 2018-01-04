From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Jan 2018 16:19:40 +0100 (CET)
Subject: [Cocci] Sources with high badcount
In-Reply-To: <d5a6e404-77ce-5ade-d7ff-40363cebf24c@orange.fr>
References: <6118e43b-bdba-0b6f-13a4-8caba08ec3e0@orange.fr>
 <alpine.DEB.2.20.1801041507290.3077@hadrien>
 <f2c1b42f-791f-dd82-6824-9c83e6c3e439@orange.fr>
 <alpine.DEB.2.20.1801041549370.3077@hadrien>
 <d5a6e404-77ce-5ade-d7ff-40363cebf24c@orange.fr>
Message-ID: <alpine.DEB.2.20.1801041618390.3077@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 4 Jan 2018, Francois-Xavier Le Bail wrote:

> On 04/01/2018 15:53, Julia Lawall wrote:
> >
> >
> > On Thu, 4 Jan 2018, Francois-Xavier Le Bail wrote:
> >
> >> On 04/01/2018 15:09, Julia Lawall wrote:
> >>>
> >>>
> >>> On Thu, 4 Jan 2018, Francois-Xavier Le Bail wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> I got high badcounts with some sources.
> >>>
> >>> Actually, in this case there are just some parse errrors in the code.
> >>>
> >>> ND_PRINT((ndo, " from %s", etheraddr_string(... (line 302)
> >>> This is missing one )
> >>>
> >>> ND_PRINT((ndo, ", hops %d", EXTRACT_U_1(... (line 322)
> >>> This has one ) too many.
> >>
> >> Bingo !
> >>
> >> Thank you.
> >>
> >> Do you have an option or a tool to find these errors ?
> >> Because neither gcc nor clang find them !
> >
> > No.  Actually the parser is built on the assumption that the code has been
> > approved by the compiler.  I'm really puzzled why gcc/clang did not
> > complain.  Perhaps the whole fils is just ifdefd out.
>
> Not ifdefd out in this case.
>
> > I don't know why it didn't put BAD on some line, but I guess it was pretty
> > disoriented.  It already seems to have a special handling of macros that
> > have a single argument that is an argument list, ie ND_PRINT.  That macro
> > is mentioned at the top of the --parse-c output.  Maybe it can be helpful
> > to look around the things that are mentioned there.
>
> After doing the ')' fixes. I got:
> BAD:!!!!!       bp = (const struct bootp *);
>
> The source line is:
> bp = (const struct bootp *)cp;
>
> I have also the message 'set verbose_parsing for more info' but the '--verbose-parsing' option was used.

My output is as follows for spatch --parse-c print-bootp.c.  I have
attached my corrected file.

julia

init_defs_builtins: /home/jll/coccinelle/standard.h

PARSING: print-bootp.c
(ONCE) CPP-found define initializer: VM_RFC1048
(ONCE) CPP-TYPEDEF: promoting:(2) nd_byte on line 71
(ONCE) CPP-TYPEDEF: promoting:(5) netdissect_options on line 264
TYPEDEF CONFLICT:uint32_t
transforming some ident into a typedef
-----------------------------------------------------------------------
maybe 10 most problematic tokens
-----------------------------------------------------------------------
-----------------------------------------------------------------------
NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
nb good = 1114,  nb passed = 0 =========> 0.00% passed
nb good = 1114,  nb bad = 0 =========> 100.00% good or passed



>
> --
> Francois-Xavier
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: print-bootp.c
Type: text/x-csrc
Size: 32503 bytes
Desc: 
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180104/0c63ffdf/attachment-0001.bin>
