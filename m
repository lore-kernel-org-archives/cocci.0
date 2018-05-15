From: jglisse@redhat.com (Jerome Glisse)
Date: Tue, 15 May 2018 17:26:59 -0400
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <alpine.DEB.2.20.1805152252500.2532@hadrien>
References: <20180515203606.GA3687@redhat.com>
 <CAACXqO_T_zSk-cP0aCb02qTVUGfdSpPX-ngSzket2ANNz8sw-A@mail.gmail.com>
 <alpine.DEB.2.20.1805152252500.2532@hadrien>
Message-ID: <20180515212659.GB3687@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, May 15, 2018 at 10:53:36PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 15 May 2018, H?kon L?vdal wrote:
> 
> > It's been a while since I used coccinelle, but I think to remember that you must
> > (and in any case should) keep the non-changing parts outside of the
> > +/- lines, e.g.
> >
> > @@
> > @@
> >          typedef void (*toto_t)(int a, int b
> > +        , int c
> >          );
> 
> I think that typedefs of function pointers just don't work.  It is looking
> for typedef type name;.  I can try to fix this.
> 

Above does not work either. The error is same roughly spatch complains
that it matches whole content ... I have a workaround, namely abusing
gcc which accept:

typedef void toto_t(int a, int b);

For function pointer typedef and then coccinelle on function declaration
do work. Still it would be nice if coccinelle can understand function
pointer typedef.

J?r?me
