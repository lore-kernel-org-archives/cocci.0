From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 May 2018 22:53:36 +0200 (CEST)
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <CAACXqO_T_zSk-cP0aCb02qTVUGfdSpPX-ngSzket2ANNz8sw-A@mail.gmail.com>
References: <20180515203606.GA3687@redhat.com>
 <CAACXqO_T_zSk-cP0aCb02qTVUGfdSpPX-ngSzket2ANNz8sw-A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1805152252500.2532@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 May 2018, H?kon L?vdal wrote:

> It's been a while since I used coccinelle, but I think to remember that you must
> (and in any case should) keep the non-changing parts outside of the
> +/- lines, e.g.
>
> @@
> @@
>          typedef void (*toto_t)(int a, int b
> +        , int c
>          );

I think that typedefs of function pointers just don't work.  It is looking
for typedef type name;.  I can try to fix this.

julia

>
> etc
>
> BR H?kon L?vdal
>
> On 15 May 2018 at 22:36, Jerome Glisse <jglisse@redhat.com> wrote:
> > Hello,
> >
> > I am trying to modify an function pointer typedef something like:
> >
> > @@
> > @@
> > - typedef void (*toto_t)(int a, int b);
> > + typedef void (*toto_t)(int a, int b, int c);
> >
> > But it seems spatch or the semantic does not handle function pointer.
> > Or simply that typedef is not well handled in the first place. Thing
> > like:
> >
> > @@
> > @@
> > - typedef int nombre;
> > + typedef unsigned nombre;
> >
> > also fails to work. But if typedef is use with struct then it works.
> > For instance:
> >
> > @@
> > @@
> > - typedef struct {int a;} nombre;
> > + typedef struct {unsigned a;} nombre;
> >
> > Do work. Looking at declaration grammar i do not see why the former
> > does not work. I am using fedora 27 coccinelle 1.0.6 if that matters.
> >
> > Is this a known limitation or am i writting it wrong ?
> >
> > Thank you for any input on this,
> > J?r?me
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
