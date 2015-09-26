From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Sep 2015 13:43:47 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <alpine.DEB.2.10.1509261154500.2737@hadrien>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
 <56041BE5.5010005@users.sourceforge.net> <56051D2B.5040802@samsung.com>
 <56064D0B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <56066866.1060602@users.sourceforge.net>
 <alpine.DEB.2.10.1509261144270.2737@hadrien>
 <56066AD4.9060306@users.sourceforge.net>
 <alpine.DEB.2.10.1509261154500.2737@hadrien>
Message-ID: <560684F3.9090700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> The connection between the SmPL specification "f(...)@e" and the desired return type
>> was not obvious for me so far.
> 
> The nearest enclosing expression of the ) is the whole function call itself.

Thanks for your explanation.

Now I guess that the enclosing context is a particular function implementation
where specific calls are performed, isn't it?


> e will thus match the entire expression.  e is declared to have type t

Did you omit this detail in your suggestion a moment ago?


> (where t is in practice signed int or whatever one wants to check for).

How do you think about reuse another data type enumeration there?


How would you like to manage names for functions which are not defined
in the current source file?

Regards,
Markus
