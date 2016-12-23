From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 23 Dec 2016 07:54:02 +0100
Subject: [Cocci] =?utf-8?q?=E2=80=A6_adding_missing_NULL_checks?=
In-Reply-To: <20161222225335.oeswg7cbcm76m3wr@fbsd-laptop.lan>
References: <20161216215537.p3ymxl3t6526af3i@fbsd-laptop>
 <ea7eadf2-080e-a0c1-5b86-c678e7d74484@users.sourceforge.net>
 <20161222225335.oeswg7cbcm76m3wr@fbsd-laptop.lan>
Message-ID: <efaaeecf-7897-d358-57ae-523d9f2df47e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Is there a clever way of conditionally making this change?

The answer depends on your desire how ?clever? (or sophisticated) an other approach
should become.

You could try to work with more disjunctions and rules in the semantic patch language.
This transformation might trigger a few target conflicts and further software
development challenges as you might become also aware of special needs and
corresponding advancements in technology.

How many software developers and source code reviewers care really about unused
(or ignored) return values from various function calls?

Regards,
Markus
