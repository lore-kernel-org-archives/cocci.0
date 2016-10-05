From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 5 Oct 2016 19:21:49 +0200
Subject: [Cocci] Replacing one variable name with another
In-Reply-To: <87shsa7p71.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
Message-ID: <f49b95f0-071f-7c36-55cc-8dd02921e211@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> 2. ..and how would I go about if instead of the type, I want to replace
>    a variable name? (my_type *ptr --> my_type *pointer).

Would you like to try another small SmPL script out like the following?


@name_replacement@
@@
 my_type *
-ptr
+pointer
 ;


How will your software development experiments evolve for the desired
application of the semantic patch language?

Regards,
Markus
