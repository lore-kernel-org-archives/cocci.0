From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 May 2018 09:21:41 +0200 (CEST)
Subject: [Cocci] convert if (x) stmt to if (x) {stmt}
In-Reply-To: <f9593244-a490-295b-537d-5dcc5e1017d5@users.sourceforge.net>
References: <alpine.DEB.2.20.1805162139340.3296@hadrien>
 <f9593244-a490-295b-537d-5dcc5e1017d5@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805170919390.4571@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 17 May 2018, SF Markus Elfring wrote:

> >> I would suggest to proceed carefully...
> >
> > In each rule that contains S1, you first could replace the S1 by e;
> > where e is an expression metavariable.
>
> Please reconsider this suggestion.
>
> * I guess that there can statements occur which are not expressions.
>
> * Should return values trigger any more software development concerns?

I don't think you understood the idea at all.  The rule will likely make
hundreds or throusands of changes.  There is little risk in the case of
e;.  Getting all of those cases out of the way first will reduce the size
of the result that has to be checked carefully.

julia



>
>
> > Then you could commit that, and then run the original rule,
> > thus being able to focus on the more complex results.
>
> The application of additional SmPL script variants can help.
> I am curious on how the fine-tuning of corresponding implementation details
> will evolve further.
>
> Regards,
> Markus
>
