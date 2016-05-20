From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 20 May 2016 13:45:37 +0200
Subject: [Cocci] [PATCH v2 3/3] coccinelle: add control flow
	documentation
In-Reply-To: <1463699336-16151-4-git-send-email-mcgrof@kernel.org>
References: <1463699336-16151-1-git-send-email-mcgrof@kernel.org>
 <1463699336-16151-4-git-send-email-mcgrof@kernel.org>
Message-ID: <4cc6861a-ecf6-7996-7b13-2cf0e803691c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +	#spatch --control-flow-to-file flow1.c

Do you really want to add such commands as comment lines of this make file?


> +Rules describe a property which Coccinelle must match, when the property
> +described is matched the rule is considered successful. Program control
> +flows vary, a control flow describes a possible run time path taken by
> +a program.

How do you think about an other wording?

+ ? match.
+ A rule is considered successful when the described property is matched.
+ Properties belong to varying program control flows.
+ A control flow describes a possible run time path taken by a program.


> +When using Coccinelle you often want to be able to express certain code
> +within certain types of control flows. Typically you will use ellipses
> +("...") to indicate to Coccinelle anything can be present between
> +consecutive statements.

Another alternative?

+ ? flows.
+ You would like to use placeholders at some places usually.
+ Typically you will use ellipses ("...") for the indication
+ that any source code can be present between consecutive statements.


> +The context of the rule provides no other guidlines to Coccinelle to hint

Do involved guidelines need another fix?


> +For instance, if we only wanted to remove call calls to c() but which also

Is the "call" mentioned too often here?


> +There are two possible modifiers to the control flow for ellipses, one
> +is to annotate that statements in between ellipses are optional (<... ...>),

Will it be better to use an enumeration (with bullet points)?


> +or that the statements in between must be present at least once (<+... ...+).

Would you like to add a closing angle bracket here?


> +The program flow1.1 has a linear control flow, it has no branches. The main
> +routine has a McCabe cyclomatic complexity of 1. The McCabe cyclomatic
> +complexity can be computed using

Another description approach?

+ ? branches.
+ Each flow can also be categorised by the metric "McCabe cyclomatic complexity"
+ which can be computed ? .


> +Rules can also be not be successful if requirements do not match
> +when a rule name is followed by "depends on XXX". When "depends on is used

More fine-tuning?

+ The match success is also affected by the rule dependency specification.
+ When "depends on" is used


> +it means the rule should only apply if rule XXX matched with the current
> +metavariable environment. Alternatively, "depends on ever XXX" can be used
> +as well, this means this rule should apply if rule XXX was ever matched at
> +all. A counter to this use is "depends on never XXX", which means that this
> +rule should apply if rule XXX was never matched at all.

Other enumeration format?

Regards,
Markus
