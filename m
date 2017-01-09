From: keescook@chromium.org (Kees Cook)
Date: Mon, 9 Jan 2017 12:56:02 -0800
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <alpine.DEB.2.20.1701092008160.2029@hadrien>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
 <d0289ec5-3ce2-f119-6876-e19dc1a5ccde@oracle.com>
 <alpine.DEB.2.20.1701092008160.2029@hadrien>
Message-ID: <CAGXu5jLBcx_eOBSHnwOVdBKOaZ8TTN2u-n-=+dR4Pf06NAiBfQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jan 9, 2017 at 11:08 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Mon, 9 Jan 2017, Vaishali Thakkar wrote:
>
>> On Tuesday 27 December 2016 11:51 PM, Julia Lawall wrote:
>> > I totally dropped the ball on this.  Many thanks to Vaishali for
>> > resurrecting it.
>> >
>> > Some changes are suggested below.
>> >
>> > On Tue, 26 Apr 2016, Kees Cook wrote:
>> >
>> > > This is usually a sign of a resized request. This adds a check for
>> > > potential races or confusions. The check isn't 100% accurate, so it
>> > > needs some manual review.
>> > >
>> > > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > > ---
>> > >  scripts/coccinelle/tests/reusercopy.cocci | 36
>> > > +++++++++++++++++++++++++++++++
>> > >  1 file changed, 36 insertions(+)
>> > >  create mode 100644 scripts/coccinelle/tests/reusercopy.cocci
>> > >
>> > > diff --git a/scripts/coccinelle/tests/reusercopy.cocci
>> > > b/scripts/coccinelle/tests/reusercopy.cocci
>> > > new file mode 100644
>> > > index 000000000000..53645de8ae95
>> > > --- /dev/null
>> > > +++ b/scripts/coccinelle/tests/reusercopy.cocci
>> > > @@ -0,0 +1,36 @@
>> > > +/// Recopying from the same user buffer frequently indicates a pattern of
>> > > +/// Reading a size header, allocating, and then re-reading an entire
>> > > +/// structure. If the structure's size is not re-validated, this can lead
>> > > +/// to structure or data size confusions.
>> > > +///
>> > > +// Confidence: Moderate
>> > > +// Copyright: (C) 2016 Kees Cook, Google. License: GPLv2.
>> > > +// URL: http://coccinelle.lip6.fr/
>> > > +// Comments:
>> > > +// Options: -no_includes -include_headers
>> >
>> > The options could be: --no-include --include-headers
>> >
>> > Actually, Coccinelle supports both, but it only officially supports the
>> > -- versions.
>> >
>> > > +
>> > > +virtual report
>> > > +virtual org
>> >
>> > Add, the following for the *s:
>> >
>> > virtual context
>> >
>> > Then add the following rule:
>> >
>> > @ok@
>> > position p;
>> > expression src,dest;
>> > @@
>> >
>> > copy_from_user at p(&dest, src, sizeof(dest))
>> >
>> > > +
>> > > + at cfu_twice@
>> > > +position p;
>> >
>> > Change this to:
>> >
>> > position p != ok.p;
>> >
>> > > +identifier src;
>> > > +expression dest1, dest2, size1, size2, offset;
>> > > +@@
>> > > +
>> > > +*copy_from_user(dest1, src, size1)
>> > > + ... when != src = offset
>> > > +     when != src += offset
>>
>> Here, may be we should add few more lines from Pengfei's
>> script to avoid th potential FPs.
>
> Which lines (I don't have it handy)?

I'm going to compare
https://github.com/wpengfei/double_fetch_cocci/blob/master/pattern_match_linux.cocci
to my original one, add your improvements and see what I get...

-Kees

>
> julia
>
>>
>> > Add the following lines:
>> >
>> >      when != if (size2 > e1 || ...) { ... return ...; }
>> >      when != if (size2 > e1 || ...) { ... size2 = e2 ... }
>> >
>> > These changes drop cases where the last argument to copy_from_usr is the
>> > size of the first argument, which seems safe enough, and where there is a
>> > test on the size value that can either update it or abort the function.
>> > These changes only eliminate false positives, as far as I could tell.
>> >
>> > If it would be more convenient, I could just send the complete revised
>> > patch, or whatever seems convenient.
>>
>> I was also thinking that probably we should also add other user space memory
>> API functions. May be get_user and strncpy_from_user. Although I'm not sure
>> how common it is to find such patterns for both of these functions.
>>
>> > thanks,
>> > julia
>> >
>> > > +*copy_from_user at p(dest2, src, size2)
>> > > +
>> > > + at script:python depends on org@
>> > > +p << cfu_twice.p;
>> > > +@@
>> > > +
>> > > +cocci.print_main("potentially dangerous second copy_from_user()",p)
>> > > +
>> > > + at script:python depends on report@
>> > > +p << cfu_twice.p;
>> > > +@@
>> > > +
>> > > +coccilib.report.print_report(p[0],"potentially dangerous second
>> > > copy_from_user()")
>> > > --
>> > > 2.6.3
>> > >
>> > >
>> > > --
>> > > Kees Cook
>> > > Chrome OS & Brillo Security
>> > >
>> > _______________________________________________
>> > Cocci mailing list
>> > Cocci at systeme.lip6.fr
>> > https://systeme.lip6.fr/mailman/listinfo/cocci
>> >
>>
>>



-- 
Kees Cook
Nexus Security
