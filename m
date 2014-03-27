From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 27 Mar 2014 14:41:48 +0100
Subject: [Cocci] How to exclude volatile data accesses in expressions
	with SmPL?
In-Reply-To: <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
Message-ID: <53342A9C.9070406@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Not sure what you mean by extended.  There are indeed some other functions 
> in Linux that perform NULL tests before doing anything, and thus they 
> don't really need a null test around them.

I have got another concern for a corresponding implementation detail.
How can a constraint be specified for the filter in the semantic patch
so that the expression refers only to non-volatile data?
Is it a software development challenge to exclude accesses on volatile
data elements eventually from the suggested deletion of condition checks?
https://en.wikipedia.org/wiki/Volatile_variable#In_C_and_C.2B.2B

Regards,
Markus
