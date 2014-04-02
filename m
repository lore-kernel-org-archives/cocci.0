From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 02 Apr 2014 09:19:46 +0200
Subject: [Cocci] Clarification for source code style reformatting
In-Reply-To: <1396374174.21529.93.camel@joe-AO722>
References: <1396374174.21529.93.camel@joe-AO722>
Message-ID: <533BBA12.1040105@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The output is apparently correct and compilable.
> It is just not kernel style.  I'm not sure there
> is a defect really, just wanted to bring it up.
> 
> Maybe the first transform could be better written.

It seems that the shown differences in source code formatting come from your
first semantic patch rule.
Does your update suggestion fit to implementations of functions which had a
non-void return type before?


> $ cat void_return.cocci
> @@
> identifier func;
> expression S;
> @@
> void func(...) {
> ...
> 	if (...)
> -		return S;
> +		{ S; return; }
> ...
> }

I have got another view for further consideration around similar SmPL approaches.

You expect that the adjusted source code should fit to the Linux coding guidelines.
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/Documentation/CodingStyle?id=b57a0505e750b3d7b2d39e9823b276d8ca1a08fe

I guess that would mean here that the opening curly brace should be placed at
the end of the "if line".
But: Does your SmPL approach express a desire to leave this source code line
unchanged?

Does the behaviour from the tool "spatch 1.0.0-rc14" come closer to your
expectations for this use case?
Does your example show an interesting target conflict?

Various software developers have got strong opinions about the recommended
source code formatting.
http://en.wikipedia.org/wiki/Programming_style

Is there a need to make the "pretty-printing strategy" configurable for the
Coccinelle software?
http://en.wikipedia.org/wiki/Prettyprint#Programming_code_formatting_and_beautification

Regards,
Markus
