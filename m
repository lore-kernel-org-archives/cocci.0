From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 7 Apr 2013 13:43:58 +0200 (CEST)
Subject: [Cocci] 1.0.0-rc17: Further fine-tuning for the build system?
In-Reply-To: <516158D8.7040304@users.sourceforge.net>
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
Message-ID: <alpine.DEB.2.02.1304071340020.1951@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 7 Apr 2013, SF Markus Elfring wrote:

> >> Who does maintain the affected build specification and corresponding
> >> configuration scripts now?
> >
> > No one.
>
> Your answer surprises me. Are you the project leader for this software?

Yes, but build systems are very tricky and entirely out of my expertise.
As long as the system builds in some way, I don't see the need for
supporting every possible exotic combination.  Notably, building the
software from some directory other than the one in which the software is
located seems completely unnecessary, as far as I can see.

> Would you like to integrate any update suggestions for this area from me into
> your source code repository?

Perhaps, but perhaps not.  I don't want to make changes that are
inessential and that I don't understand.  Any thing that one person
proposes would have to be reviewed by someone else.

julia
