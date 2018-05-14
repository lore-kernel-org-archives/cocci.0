From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 14 May 2018 21:41:46 +0200 (CEST)
Subject: [Cocci] Checking the support for source code transformations
 with special characters
In-Reply-To: <9507e4af-3a80-f691-e75a-e4ddec1548c8@users.sourceforge.net>
References: <704e29ae-bd49-6b84-eb96-45f6d3ad004e@users.sourceforge.net>
 <alpine.DEB.2.20.1805141632540.17398@hadrien>
 <03b3476d-083f-216b-bfef-03b0b1b25d21@users.sourceforge.net>
 <alpine.DEB.2.20.1805141714300.17398@hadrien>
 <9507e4af-3a80-f691-e75a-e4ddec1548c8@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805142139440.2739@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 14 May 2018, SF Markus Elfring wrote:

> >> I have noticed a moment ago that a blank line is not marked by the SmPL
> >> asterisk operator (for a small source code example) so far.
> >>
> >> Can such whitespace characters be also preserved there anyhow?
> >
> > No.  Whitespace is never preserved in metavariables.
>
> How does such information fit to the following wording in the documentation?
> https://github.com/coccinelle/coccinelle/blob/848f85e256516330c06f5fd8dc782b854ed9aa03/docs/manual/introduction.tex#L4
>
> ?? automate repetitive source-to-source style-preserving program transformations ??

When Coccinelle adds code, it makes an effort to conform to the
indentation of the context in which the code is placed, not the context
from which the code was removed.  The goal is to preserve the stule of the
code as a whole.

julia
