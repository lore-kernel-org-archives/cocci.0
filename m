From: jglisse@redhat.com (Jerome Glisse)
Date: Wed, 16 May 2018 11:13:46 -0400
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <20180515212659.GB3687@redhat.com>
References: <20180515203606.GA3687@redhat.com>
 <CAACXqO_T_zSk-cP0aCb02qTVUGfdSpPX-ngSzket2ANNz8sw-A@mail.gmail.com>
 <alpine.DEB.2.20.1805152252500.2532@hadrien>
 <20180515212659.GB3687@redhat.com>
Message-ID: <20180516151345.GA2994@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, May 15, 2018 at 05:26:59PM -0400, Jerome Glisse wrote:
> On Tue, May 15, 2018 at 10:53:36PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Tue, 15 May 2018, H?kon L?vdal wrote:
> > 
> > > It's been a while since I used coccinelle, but I think to remember that you must
> > > (and in any case should) keep the non-changing parts outside of the
> > > +/- lines, e.g.
> > >
> > > @@
> > > @@
> > >          typedef void (*toto_t)(int a, int b
> > > +        , int c
> > >          );
> > 
> > I think that typedefs of function pointers just don't work.  It is looking
> > for typedef type name;.  I can try to fix this.
> > 
> 
> Above does not work either. The error is same roughly spatch complains
> that it matches whole content ... I have a workaround, namely abusing
> gcc which accept:
> 
> typedef void toto_t(int a, int b);
> 
> For function pointer typedef and then coccinelle on function declaration
> do work. Still it would be nice if coccinelle can understand function
> pointer typedef.

Ok my work around does work that well, it seems gcc allow this abuse
only for function parameter type, it can not be use as a type inside
a structure and so it doesn't cover all cases i am dealing with.

Is there a way to modify code using python inside coccinelle ? I have
seen example that print thing inside coccinelle but i haven't not seen
an example that use coccinelle to match something and then do changes
to the code using python.

I am guessing i can open the file and use the position information to
do that but was wondering if there is already helper provided for that.

Cheers,
J?r?me
