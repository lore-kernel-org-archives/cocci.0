From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 20 Dec 2016 20:45:26 +0100
Subject: [Cocci] =?utf-8?q?=E2=80=A6_adding_missing_NULL_checks?=
In-Reply-To: <20161216215537.p3ymxl3t6526af3i@fbsd-laptop>
References: <20161216215537.p3ymxl3t6526af3i@fbsd-laptop>
Message-ID: <ea7eadf2-080e-a0c1-5b86-c678e7d74484@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> need to put another copy of that at the end of the rule with  ? in front
>> of it.  So that it stops when it comes to that again.
>
> And now it's working just fine.

I became also curious on how the discussed source code transformation can
really work. I imagine that there are still some software development challenges
left over for further considerations.

* A filter criterium like ?T = strdup(...);? was specified.
  How do you think about to use a SmPL disjunction (or an advanced SmPL constraint
  on a metavariable with the type ?identifier? instead)?

* Can the function call ?pkg_emit_errno? become a bit more generic by passing
  a string from previously matched data?

* Would you like to check any more cases so that the technology ?data flow analysis?
  will be also needed here?

Regards,
Markus
