From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Aug 2017 19:08:22 +0200 (CEST)
Subject: [Cocci] isomorphism for &(structure)->field vs struct.field
In-Reply-To: <CAGXu5jJygEODLuphzbxgiUQ_Box3LZy1kOBiHS7Fp5jAkpOVGQ@mail.gmail.com>
References: <CAGXu5jJygEODLuphzbxgiUQ_Box3LZy1kOBiHS7Fp5jAkpOVGQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708181906240.17742@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 Aug 2017, Kees Cook wrote:

> I'd like to have a rule that would match both:
>
> function(ptr);
> ptr->field = 7;
>
> and
>
> function(&obj);
> obj.field = 7;
>
> to produce:
>
> new_function(ptr, 7);
>
> and
>
> new_function(&obj, 7);
>
> respectively. The internal isomorphisms don't seem to cover this? Or
> I'm maybe doing something wrong?

There is no isomorphism for that.  Perhaps you cold live with the
following?

@@
expression x,e;
@@

-f
+g
  ( \(&x\|x\)
+, e
  );
- \(x.field\|x->field\) = e;

julia
