From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 10 Sep 2014 18:30:27 +0200
Subject: [Cocci] Conversion of similar function calls into one with a
	longer parameter
In-Reply-To: <87fvfztqzq.fsf@rasmusvillemoes.dk>
References: <87fvfztqzq.fsf@rasmusvillemoes.dk>
Message-ID: <54107CA3.40708@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm trying to write a semantic patch to convert consecutive seq_puts()
> calls into a single one, with the string literals concatenated.
> My attempt below works fine when there are exactly two seq_puts() calls,
> but fails when there are more.

How do you think about to process the corresponding syntax and control flow
graph by interfaces for the programming language "OCaml"?
Would it be safer to reuse the available API for such an application where
several similar function calls should be merged together?

Regards,
Markus
