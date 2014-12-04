From: francois.berenger@inria.fr (Francois Berenger)
Date: Thu, 04 Dec 2014 11:43:59 +0100
Subject: [Cocci] it would be nice if spdiff also ships with coccinelle
 in future releases
In-Reply-To: <CA+RMdsmMp2wp5Mx-f2kknw-THeC_pRUbj-e8Qv5HQtBhAog9bA@mail.gmail.com>
References: <547F3A64.2060002@inria.fr>
 <CA+RMdsmMp2wp5Mx-f2kknw-THeC_pRUbj-e8Qv5HQtBhAog9bA@mail.gmail.com>
Message-ID: <54803AEF.9050207@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/04/2014 11:41 AM, Jesper Andersen wrote:
> Hi,
>
> On Wed Dec 03 2014 at 17.29.24 Francois Berenger
> <francois.berenger at inria.fr <mailto:francois.berenger@inria.fr>> wrote:
>
>     Also, we could have a single package in OPAM for both cocci and spdiff,
>     instead of the current situation with two packages (that I had to
>     create).
>
>
> It would be cool if spdiff could use the system-wide installed version
> of coccinelle. What would you think, is that possible? (I have not
> looked at how one could handle this using OPAM)

OPAM does not install things system-wide (in a default setup).

OPAM only touches things under your ~/.opam directory.

> I'm not sure Julia would want to include spdiff in coccinelle, but I can
> go ahead and ask her.

Yes, this one is maybe a bigger/more fundamental problem.

-- 
Regards,
Francois.
