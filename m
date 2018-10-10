From: timur@kernel.org (Timur Tabi)
Date: Wed, 10 Oct 2018 10:33:41 -0500
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <alpine.DEB.2.21.1810101010060.2477@hadrien>
References: <alpine.DEB.2.21.1810100741210.2477@hadrien>
 <9e5331dd-ca41-845b-3852-29941fde1652@users.sourceforge.net>
 <alpine.DEB.2.21.1810101010060.2477@hadrien>
Message-ID: <CAOZdJXXuDq12TC+ge+YedmTC1UjtFby4H=nN5t8TE8kFomtU2A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 10, 2018 at 3:11 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> I think that there are enough keywords already.  Perhaps allowing no
> pattern could be permitted, but the problem seems rare.

Allowing no pattern would be nice, and would make compound booleans
easier to implement.
