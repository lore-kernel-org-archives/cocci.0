From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Jun 2014 06:41:48 +0100 (BST)
Subject: [Cocci] systemd m4 library complex systemd example,
 and coccinelle conversion
In-Reply-To: <CAB=NE6VSdCxNXWa0QsyrqF7iCBSR3vq+r1NJoZrX=-ADdmTvnw@mail.gmail.com>
References: <CAB=NE6VSdCxNXWa0QsyrqF7iCBSR3vq+r1NJoZrX=-ADdmTvnw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1406130641090.2578@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Lastly -- I was curious if anyone has looked into writing Coccinelle
> SmPL grammar rules to convert legacy init systems with systemd
> support. I suspect most unix daemons are rather simple and SmPL rules
> might be able to transform quite a bit of them. I don't expect
> Coccinelle might be able to catch the crazy daemons with corner cases
> as with xen, but you never know, coccinelle is always surprising me
> with its capabilities.

I don't know of anyone who has, but it seems like the sort of thing
Coccinelle is designed for.

julia
