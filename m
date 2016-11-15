From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Nov 2016 23:01:03 +0100 (CET)
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <a129fee0-aa3f-2bf6-dffe-d201c5e25622@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <a129fee0-aa3f-2bf6-dffe-d201c5e25622@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1611152300360.2060@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Nov 2016, SF Markus Elfring wrote:

> >> * Can SmPL rules be constructed from smaller parts by it?
> >
> > I don't understand what it would mean for syntax to or not to matter.
>
> I am curious if the included data need to be usable also alone in the
> SmPL sense.

I think that if you have multiple includes, later includes can refer to
rules in earlier includes.

julia
