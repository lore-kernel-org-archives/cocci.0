From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 17:34:07 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102162826.GS15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien> <20131102145412.GT15704@leaf>
 <alpine.DEB.2.02.1311021555360.2261@hadrien> <20131102155224.GX15704@leaf>
 <alpine.DEB.2.02.1311021656300.2261@hadrien>
 <20131102162826.GS15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021733060.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > You could have a separate rule for this case, but then there is still the
> > case where there are two nested ifs, etc.
>
> Right, hence why I'd really like coccinelle's control-flow handling to
> handle the case above.  I do want to match "return;" at the logical end
> of the function, in a control-flow sense, *without* taking into account
> that the "return;" itself is the logical end of the function in a
> control-flow sense, because I can't remove it unless the point it
> appears at would already be the logical end of the function.

I don't see a solution for this case...

julia
