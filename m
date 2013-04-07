From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Apr 2013 14:11:29 +0200 (CEST)
Subject: [Cocci] 1.0.0-rc17: Further fine-tuning for the build system?
In-Reply-To: <5161618D.7050505@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
 <5134C654.3050706@users.sourceforge.net>
 <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
 <5138B81B.2040100@users.sourceforge.net>
 <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
 <5138C95F.8010608@users.sourceforge.net>
 <5144D0F8.3040302@users.sourceforge.net>
 <CANrVCd2jbGE2X+C6K9s=VanN_CquDp98f2Ne6fYOBAJt+nU8Yg@mail.gmail.com>
 <51614F9A.8000504@users.sourceforge.net>
 <alpine.DEB.2.02.1304071302110.1951@hadrien>
 <5161551D.3040108@users.sourceforge.net>
 <alpine.DEB.2.02.1304071319140.1951@hadrien>
 <516158D8.7040304@users.sourceforge.net>
 <alpine.DEB.2.02.1304071340020.1951@hadrien>
 <5161618D.7050505@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304071410400.1951@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 7 Apr 2013, SF Markus Elfring wrote:

> >> Are you the project leader for this software?
> >
> > Yes, but build systems are very tricky and entirely out of my expertise.
>
> I can eventually help to become used to the usual software development in this
> application area.
>
>
> > As long as the system builds in some way, I don't see the need for
> > supporting every possible exotic combination.
>
> I hope that mistakes will be fixed in the near future.
>
>
> > Notably, building the software from some directory other than the one
> > in which the software is located seems completely unnecessary, as far
> > as I can see.
>
> If you want to improve the Autotools setup, you will get this feature easily.
> The usefulness of "out-of-source builds / parallel build trees" might become
> obvious if more configuration variants will be considered for the software
> generation.
>
>
> > I don't want to make changes that are inessential and that I don't understand.
>
> Would you like adjust Automake details?
>
> How do you think about to start corrections with the selection of corresponding
> make file names?
>
>
> > Any thing that one person proposes would have to be reviewed by someone else.
>
> Would Rene perform such review tasks eventually since he was involved as a
> Github committer?

I don't think so.  The required expertises are quite different.

julia
