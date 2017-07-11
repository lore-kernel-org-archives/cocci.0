From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 11 Jul 2017 21:24:24 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
References: <WM!3b412209b28e186e2cf1ceaaa46d40e6d1947012ed574b129f9c461a255f53e26f88920405ecdf4a7d052d70724bc64e!@mailstronghold-2.zmailcloud.com>
 <20170710161224.rbqo4drhcfqosh23@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101816540.1968@hadrien>
 <WM!18ce1dcc914ca4f9b61f6c3aaf891296df9651e3b4d79666e0682dd2ff392a761c732ee0cf4f6500e93b392f83991daf!@mailstronghold-1.zmailcloud.com>
 <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
 <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
 <alpine.DEB.2.20.1707111508220.2316@hadrien>
 <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
 <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707112123000.2316@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 11 Jul 2017, Ond?ej Kuzn?k wrote:

> On Tue, Jul 11, 2017 at 03:10:36PM +0200, Julia Lawall wrote:
> > On Tue, 11 Jul 2017, Ond?ej Kuzn?k wrote:
> >> On Mon, Jul 10, 2017 at 07:26:36PM +0200, Julia Lawall wrote:
> >>> Try running spatch --parse-c on your directory to get a list at the end of
> >>> the top 10 things it doesn't like.
> >>
> >> One of the system dependent macros SLAP_EVENT_DECL is listed in each of
> >> the 10 things. The macro is used in
> >> https://github.com/openldap/openldap/blob/master/servers/slapd/daemon.c#L2343
> >> to declare some variables used in the corresponding event loop.
> >>
> >> The macro definition looks like this:
> >>
> >> # define SLAP_EVENT_DECL		struct pollfd *revents
> >>
> >> or:
> >>
> >> # define SLAP_EVENT_DECL	fd_set readfds, writefds; char *rflags
> >>
> >> Ignoring this macro is OK I guess, if there is a way to do that with
> >> coccinelle?
> >
> > Just
> >
> > #define SLAP_EVENT_DECL
> >
> > in the .h file. But there will be stray ;s then.  So you might want to put
> > the whole first definition.
>
> It does seem to improve things, thanks. The line 2496 still doesn't
> apply even when I declare SLAP_EVENT_FNAME to something like "name" in
> -macro-file-builtins and I think there were similar ones in other files
> later.
>
> >> Also, moving onto the other patch, I get similar inconsistencies with
> >> ./servers/slapd/back-sql/add.c, --parse-c doesn't list any problematic
> >> statements but the output logs a few parse errors that don't make much
> >> sense to me.
> >
> > Could you send the complete semantic patch that you are currently
> > considering?  Then I can take a look.
>
> Attaching the patches I'm currently working with:
> (-macro-file-builtins macros.h)
> 1. variadic.cocci
> 2. shortcut.cocci
> 3. merge.cocci
>
> The back-sql issue above is when trying to apply 2. (shortcut.cocci).
> But the one I pasted in my last email is simple enough to illustrate the
> issue (trying to merge snprintf and Debug, then get rid of extra if()s)
> even without the python stuff.

Sorry, but I'm lost.  I tried shortcut.cocci on
./servers/slapd/back-sql/add.c, and afterwards
./servers/slapd/back-sql/add.c has no snprintfs.  My command line is:

spatch -macro-file-builtins macros.h --in-place ./servers/slapd/back-sql/add.c shortcut.cocci

julia

>
> Thanks,
>
> --
> Ond?ej Kuzn?k
> Senior Software Engineer
> Symas Corporation                       http://www.symas.com
> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
>
