From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 15:53:21 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170704135006.wipw7z7pzyjwc7jv@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291026390.2983@hadrien>
 <WM!fa141e32a0b1e5356bb136cefca80be54d02a269aa1d5e1c1d01b9dd1e9da14f2f9fffdc08676c298a48132a86f2037e!@mailstronghold-1.zmailcloud.com>
 <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291733320.2968@hadrien>
 <WM!a6114e049b67df39e40551cd95bf5d65e432ff2f8c0445b0273a6b12349ae6346924a09e4c027fdcc87febe26a5e6a4e!@mailstronghold-2.zmailcloud.com>
 <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
 <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041531280.3224@hadrien>
 <WM!8666006bd8d2547072f2aaa49a217ebee942918ea85a26184b30aa0c245a807e35f125c1045776851fe6d85360d3ed76!@mailstronghold-3.zmailcloud.com>
 <20170704135006.wipw7z7pzyjwc7jv@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707041552400.3224@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:

> On Tue, Jul 04, 2017 at 03:32:25PM +0200, Julia Lawall wrote:
> >> The main problem that is holding me up is that coccinelle fails with the
> >> following error when trying to use the patch against the code above:
> >> Fatal error: exception Common.Impossible(145)
> >
> > You need
> >
> > identifier b_process.merged;
> >
> > instead of
> >
> > expression b_process.merged;
> >
> > When you do that, you will see that some more quotes are needed on the
> > string.
>
> That does work and seems to preserve the things that needed escaping,
> so just putting quotes around when merging looks enough, great!
>
> There is another scenario that I probably need to be able to handle, a
> string like this does not seem to match anything I throw at it (and in
> retrospect, you might have mentioned that earlier):
>
> "asd" "fgh" "jkl"
>
> Is there a way around that somehow or match, then pass into python to
> handle that?

This is in the C code?  I think that it should be matched by an
expression.  But run spatch --parse-c file.c to see if the containing
function has a parse error.

julia
