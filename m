From: timur@kernel.org (Timur Tabi)
Date: Fri, 27 Jul 2018 15:52:32 -0500
Subject: [Cocci] Perforce support,
 or generating list of files that would be changed?
In-Reply-To: <alpine.DEB.2.20.1807262241320.6047@hadrien>
References: <CAOZdJXXmFPuZFmeaJcB4V5+biQ3DBFZTyam452BgyV9MLgnP4Q@mail.gmail.com>
 <alpine.DEB.2.20.1807262225450.6047@hadrien>
 <CAOZdJXXY-kD+6=gDD8fBgPNNFKe5g_=2GLV-zYi54k2AVD1pLQ@mail.gmail.com>
 <alpine.DEB.2.20.1807262241320.6047@hadrien>
Message-ID: <CAOZdJXUnTYD8vdyjsQPqFfEzvSt=CYhC2tBmnQ+kkonz8JBpLw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 26, 2018 at 3:42 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> Coccinelle can make a list of relevant files, but there is not a guarantee
> that the rule will actually match on those files.  The option is
> --selected-only.

Thanks, that works.  I also discovered that this works:

spatch --very-quiet --dir .   | lsdiff --strip 1
