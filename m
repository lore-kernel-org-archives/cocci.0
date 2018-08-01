From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Aug 2018 08:17:46 +0200 (CEST)
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <d7969956-e440-3dad-4d88-da39b8809148@users.sourceforge.net>
References: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
 <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
 <650a688e-b34d-4944-9484-249da36fb1c3@nvidia.com>
 <d7969956-e440-3dad-4d88-da39b8809148@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1808010813480.2753@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> How do you think about to improve the replacement specification a bit more
> by combining the variants A  till D into a single SmPL rule which will use
> a nested SmPL disjunction?

I haven't actually looked at the semantic patch code, but I would point out
that making a disjunction is not always a good idea.  The semantics of a
disjunction is that if an earlier pattern matches, then the later patterns
are not considered.  The semantics of a succession of rules is that later
patterns are applied to the result of earlier patterns.  These are clearly
not the same things.  At the expression level, ensuring that subsequent
patterns don't apply if earlier ones do entails quite a lot of work, so a
disjunction may not be very efficient.  This performance issue is much less
at the statement level.

If there are no semantics or performance issues involved, then I would be
inclined to think that the way the person first decided to write the rule is
the best way, because that is how they thought about the problem.

julia
