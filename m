From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 26 Apr 2013 18:25:02 +0800 (SGT)
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <517A53C5.4030902@users.sourceforge.net>
References: <5134C654.3050706@users.sourceforge.net>
 <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
 <5138B81B.2040100@users.sourceforge.net>
 <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
 <5138C95F.8010608@users.sourceforge.net>
 <5144D0F8.3040302@users.sourceforge.net> <20130426081434.GA3645@redhat.com>
 <517A4495.20406@users.sourceforge.net> <20130426091622.GC1381@redhat.com>
 <517A4A93.1040405@users.sourceforge.net> <20130426095205.GD1381@redhat.com>
 <517A53C5.4030902@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1304261816530.1985@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 26 Apr 2013, SF Markus Elfring wrote:

>
> > It's NOT by badgering Coccinelle upstream
>
> If Julia will show more willingness to handle patches for the build system, I
> am going also to invest more efforts into concrete fixes.
>
>
> > and trying to get other people to argue your case for you.
>
> I do not want that, too. But other software developers might have got a higher
> reputation so that their update suggestions or source code review advices get
> easier accepted than change requests from me.

My point of view regarding the build system is that, on the one hand, at
the moment, I don't have any local resources with expertise in build
systems and on the other hand the build setup is extremely critical.
So I am not currently willing to make changes without an actual need from
a user.  An actual need would be a case where it is impossible to build
Coccinelle in any way on a given machine.  It is not a case where eg out
of tree builds don't work or parallel builds don't work.  In those cases,
one can easily avoid the problem by building in another way.

If several people want to work on and validate any solution that adds some
such inessential functionality, then I might consider integrating the
change.  But I don't have the expertise to evaluate such patches myself,
so I won't integrate such patches if they have only been tested by the
submitter.

This doesn't apply to ML patches.  I have received several patches adding
support for various strange C extensions, and I have no problem with
integrating them.  The risk is lower and the potential benefit is higher.

julia
