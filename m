From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Dec 2012 10:36:26 +0100 (CET)
Subject: [Cocci] Adding names to arguments in function prototypes
In-Reply-To: <CAACXqO_J90_i++zeP+Eb1jz-2Ce5rkvqBKnGKbTwE8cwphNupg@mail.gmail.com>
References: <CAACXqO_0dmB+CvJA+DgtnNcOpc2NKHdj9YK-+0uz2ur8q9Gg_A@mail.gmail.com>
 <alpine.DEB.2.02.1212051027460.2115@hadrien>
 <CAACXqO_J90_i++zeP+Eb1jz-2Ce5rkvqBKnGKbTwE8cwphNupg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1212051036060.2115@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 5 Dec 2012, H?kon L?vdal wrote:

> On 5 December 2012 10:28, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > Looking quickly, I think you need to inherit the parameter list length n
> > from one rule to the next.  In the rules after the first one, put rule1.n,
> > not just n.
>
> Thanks, that sounds reasonable. However it made no difference for
> neither abc.c nor xyz.c.

OK, thanks.  I will look into it.

julia
