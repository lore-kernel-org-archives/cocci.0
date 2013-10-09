From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Oct 2013 15:52:18 +0200 (CEST)
Subject: [Cocci] problem with a (contorted) macro
In-Reply-To: <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
References: <1381311937.3213.23.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1310091155210.2237@hadrien>
 <1381324407.3213.42.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1310091549140.2237@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Actually, the problem is not really what it would seem...

The if rule applies, and then the unparser does not know where to put the
close brace (for some reason), so it puts it in the leftmost column.
Then when the parser tries to parse the result, it fails on its first
parsing attempt (normal), because it does not take into account the TRNIV1
macro definition.  Before its second attempt, it resynchronizes, which
amounts to finding a close brace in the leftmost column.  Now the function
is cut in half, and is completely unparseable.

I will see how to put the added brace in the right place, or at least not
in the leftmost column.

julia
