From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 25 Feb 2014 10:16:48 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <530C5E18.1020800@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1402251014170.2080@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I can also adjust the search approach like the following.
>
> @safety_check@
> identifier work, input;
> type data_type;
> position pos;
> statement is, es;
> @@
>  void work at pos(...,data_type input,...)
>  {
>   ...
> ( if (input) is
> | if (likely(input)) is
> )
>   else es

This is not allowed.  Inside a disjunction you need to have complete
terms.

>   ...
>  }
>
>
> > I would think you only want to find cases where the function does nothing
> > until it tests input and aborts the function is the value is 0.
>
> I guess that the interpretation of "nothing relevant" will need further
> considerations, won't it?
>
>
> > So you only want the return case.
>
> Not "only" this one ...
>
> I have got a feeling for a need to introspect the else branch for useful
> properties. I am unsure about better analysis of the metavariable "es" with the
> semantic patch language.

I'm not sure to understand your goal.  If the code currently has:

if (x != NULL)
   call(x);

then the developer does not want to execute any of the code within call if
x is NULL.  If you just check that there is a NULL test on x somewhere
within the definition of call, then that is not enough to ensure that
nothing is executed within call.  If you remove the NULL test, you could
drastically change the behavior of the program.

julia
