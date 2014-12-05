From: joe@perches.com (Joe Perches)
Date: Fri, 05 Dec 2014 07:54:34 -0800
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <87tx1a6sdp.fsf@rasmusvillemoes.dk>
References: <1417741951.2721.30.camel@perches.com>
 <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
 <1417764516.2721.37.camel@perches.com> <87tx1a6sdp.fsf@rasmusvillemoes.dk>
Message-ID: <1417794874.2721.57.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-12-05 at 16:14 +0100, Rasmus Villemoes wrote:
> Hardcoding the function name in a literal string also makes typos (or
> copy-pastos) possible. I extended Julia's code to allow a small edit
> distance. Requires the Levenshtein python module (on debian, apt-get
> install python-levenshtein). It's not terribly slow, but to be really
> useful I (or someone) would need to reduce the number of false positives.

I agree with Julia, cool, thanks.
