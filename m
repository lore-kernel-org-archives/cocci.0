From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Jan 2016 13:28:26 +0100
Subject: [Cocci] script code on metavariables
In-Reply-To: <alpine.DEB.2.10.1601181301450.2520@hadrien>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
 <569CBEB7.1030509@users.sourceforge.net>
 <alpine.DEB.2.10.1601181138430.2520@hadrien>
 <569CD3DF.2010600@users.sourceforge.net>
 <alpine.DEB.2.10.1601181301450.2520@hadrien>
Message-ID: <569CDA6A.5020005@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't know what is meant exactly by a method call, but anything that
> looks like a valid C expression is fine.  The code will not be interpreted
> by Coccinelle, only by the relevant scripting language, which is currently
> only OCaml.

Would an other wording fit also?

The returning of a boolean value should just work. Can the reference to
the C programming language be lifted already if an external script processor
will finally take care for the embedded source code?


> The restriction to being a C expression is only a parsing issue.

I imagine that there will be more dependencies to consider, won't it?


> No, it runs in the same thread as the rest of the processing.

Would it make sense occasionally to execute the predicate function
in parallel (by a dedicated thread or another background process)?

Regards,
Markus
