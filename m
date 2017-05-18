From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 18 May 2017 15:00:35 +0200
Subject: [Cocci] Checking source code (including optional parts) with
	SmPL
In-Reply-To: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
References: <c77fb009-04c5-c381-e016-549cd7592059@users.sourceforge.net>
Message-ID: <02b53afb-5d87-e15f-7862-b888bb102bca@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I would like to clarify the possibilities for corresponding software extensions
a bit more.
The Coccinelle software provides also the search operator ?question mark? which
denotes code on a specific line as optional.
https://github.com/coccinelle/coccinelle/blob/9b5e00862900b0daadf1819a6894d31544a3ba34/docs/manual/cocci_syntax.tex#L1067

The scope of the special code there is only the marked line so that I see some
software development challenges to pack desired search filters into one line.

* How often do you check the handling for optional parts?

  - Do you find it relevant to check for the assignment of an error code to an
    other variable?

  - Are special constraints needed for additional function calls?


* How are the chances to improve readability and maintainability for SmPL code?

Regards,
Markus
