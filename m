From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 04 Feb 2015 09:29:42 +0100
Subject: [Cocci] Software evolution after Coccinelle 1.0.0-rc24?
In-Reply-To: <alpine.DEB.2.02.1502032259220.2026@localhost6.localdomain6>
References: <alpine.DEB.2.02.1502032259220.2026@localhost6.localdomain6>
Message-ID: <54D1D876.2070305@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Now it is also possible to match a global variable,
> by saying "global expression x;".

Would you like to refer to "idexpression" here?


> It is now possible to disable this behavior,
> by putting disable prototypes in the rule header.

Which software release will mention this functionality also in the manual?


> Because of the conflict with the ... notation of Coccinelle,
> the ... of C is written ...... (6 dots) in a semantc patch.

How do you think about to support also two ellipsis characters
(Unicode: 0x2026) there?


> --jobs <int>: Run the specified number of jobs in parallel.

This addition is nice.


> This option is not compatible with the use of an initialize or finalize
> rule in the semantic patch.

I find that this limitation will need more explanations.

How do the calls to the script interpreters for OCaml and Python fit into
the current architecture around process parallelism?


> This option furthermore creates a temporary directory in the directory
> from which spatch is executed that has the name of the semantic patch
> (without its extension) and that contains stdout and stderr files generated
> by the various processes.

Will it become possible to specify alternative paths for such
temporary work directories?


Further update suggestions:
* When will the parameter "parse-handler" be described also in the documentation
  source file "spatch_options.tex"?

* Would you like to fix another dangling link for the topic "Tips and Tricks"?
  http://coccinelle.lip6.fr/docs/main_grammar015.html

Regards,
Markus
