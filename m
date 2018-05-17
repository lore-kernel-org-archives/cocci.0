From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 15:48:52 -0400
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <alpine.DEB.2.20.1805172125150.2273@hadrien>
References: <20180515203606.GA3687@redhat.com>
 <alpine.DEB.2.20.1805172125150.2273@hadrien>
Message-ID: <20180517194851.GA15887@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 09:28:00PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 15 May 2018, Jerome Glisse wrote:
> 
> > Hello,
> >
> > I am trying to modify an function pointer typedef something like:
> >
> > @@
> > @@
> > - typedef void (*toto_t)(int a, int b);
> > + typedef void (*toto_t)(int a, int b, int c);
> 
> This now works.  Currently, you need to remove the whole typedef and add
> it back, not just add the third argument as H?kon suggested.

Awesome ! :) Thank you for working on that.

> 
> >
> > But it seems spatch or the semantic does not handle function pointer.
> > Or simply that typedef is not well handled in the first place. Thing
> > like:
> >
> > @@
> > @@
> > - typedef int nombre;
> > + typedef unsigned nombre;
> 
> Was this just an experiment, or is it something you need?  I would imagine
> that the problem is that "unsigned" as a type by itself is not well
> supported.

This was just an experiment i did while trying to understand why my
function pointer typedef changes did not work. If i use long or any
basic ctype then it works.

Cheers,
J?r?me
