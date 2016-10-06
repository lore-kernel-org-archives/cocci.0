From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 6 Oct 2016 22:35:45 +0200 (CEST)
Subject: [Cocci] spatch: dealing with macro calls in structures
In-Reply-To: <CA+BoTQm9L8vK3Daj+rbWWMVC3dVki9jicdmnHFvp1mjr-=_3=Q@mail.gmail.com>
References: <CA+BoTQm9L8vK3Daj+rbWWMVC3dVki9jicdmnHFvp1mjr-=_3=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1610062234020.5301@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 6 Oct 2016, Michal Kazior wrote:

> Hi,
>
> I've been struggling to get spatch to parse the following code properly:
>
> struct foo {
>         int hello;
>         BAR(int) world;
> };
>
> int bar(int wut) {
>         BAR(int) world;
>         return 0;
> }
>
> My cocci is:
>
> @@ @@
> * struct foo { ... };
>
> @@ @@
> * int bar(...) { ... }
>
> If I specify -macro_file which includes:
>
> #define BAR(x)
>
> With v1.0.6 I only get:
>
> -int bar(int wut) {
> -       BAR(int) world;
> -       return 0;
> -}
>
> (i.e. "struct foo" is not recognized)
>
> v1.0.4 gives me nothing.
>
> If I specify -macro_file which includes:
>
> #define BAR(x) x
>
> I get nothing from both 1.0.4 and 1.0.6 except a complaint "try to
> delete an expanded token: int".
>
> Is this expected/known?

Yes.  Unfortunately you cannot transform macro expanded code.  I think
that this issue is that it would be hard to know what to do if the code
was partially deleted.  It could be nice to allow completely deleting it,
but probably the information about whether that is the case is not
avalable.

julia

>
>
> Micha?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
