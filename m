From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 19 May 2018 17:57:52 +0200 (CEST)
Subject: [Cocci] Need help compiling coccinelle on Ubuntu 16.04
In-Reply-To: <CAF_dkJB=v5dyjJwC5HFHfubP0NRhPPQCWkY6QbnF0OSB8LiBJw@mail.gmail.com>
References: <CAF_dkJCyP-2Yc-fynAGWp5D7YZP5ybaLXrYK4EHc_Z7XSP9kiA@mail.gmail.com>
 <alpine.DEB.2.20.1805190735090.2237@hadrien>
 <CAF_dkJB=v5dyjJwC5HFHfubP0NRhPPQCWkY6QbnF0OSB8LiBJw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1805191757170.2277@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 19 May 2018, Patrick Doyle wrote:

> On Sat, May 19, 2018 at 1:36 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Wed, 16 May 2018, Patrick Doyle wrote:
> >
> >> I just tried compiling coccinelle on a Ubuntu 16.04 system, having
> >> installed all the dependencies that seem to make sense, and it fails
> >> to compile.
> >
> > I had this problem and then somehow it disappeared...  I think that
> > somehow it is supposed to be giving a warning, but not actually failing.
> > But it does really look like it fails.  We will look into it.
> >
> > Julia
> Thank you Julia,
> I think you are correct.  When I looked more closely at the error
> message, I saw that make ignored the failure code, and indeed, when I
> attempted to run my application that relies upon spach > 1.0.6 (the
> Linux backports tool), it appears to have worked.

That's great!  Sorry that the output is so misleading...

julia

>
> Sorry for the spam... I had reached the point where one too many
> things were going wrong and decided to just stop and ask for some
> help.
>
> Thanks again.
>
> --wpd
>
