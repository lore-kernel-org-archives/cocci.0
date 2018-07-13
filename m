From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 13 Jul 2018 17:25:39 +0200
Subject: [Cocci] Coccinelle: change strncpy+truncation to strlcpy
In-Reply-To: <4b9986b2-957a-081a-038e-afc5acf0bfdd@users.sourceforge.net>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <4b9986b2-957a-081a-038e-afc5acf0bfdd@users.sourceforge.net>
Message-ID: <20180713152539.GB14190@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SF Markus Elfring wrote on Fri, Jul 13, 2018:
> > +msg = "SUGGESTION: strncpy followed by truncation can be strlcpy"
> > +coccilib.report.print_report(p[0],msg)
> 
> I would prefer to omit an intermediate Python variable (similar to the previous
> SmPL rule) just for the simple display of such a message.
> 
> +coccilib.report.print_report(p[0],
> +                             "SUGGESTION: strncpy followed by truncation can be strlcpy.")

Out of curiosity, is the performance cost of using an intermediate
variable high in spatch?
I personally do not mind either way, but that does make for a pretty
long line once indented and I know many who would prefer the initial
version.

> > +-strncpy at p(
> > ++strlcpy(
> > +  dest, src, sz);
> 
> How do you think about to adjust another SmPL code transformation specification
> like the following?
> 
> +-strncpy at p
> ++strlcpy
> +        (dest, src, sz);

This also came from the example I picked, but if this does not make a
difference as it sounds like I will update to that.

-- 
Dominique Martinet
