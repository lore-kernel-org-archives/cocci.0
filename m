From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 24 Feb 2014 16:58:15 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.10.1402241616500.2074@hadrien>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241616500.2074@hadrien>
Message-ID: <530B6C17.4090407@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> This example does not fit to my expectation because it seems that the function
>> implementation does not refer to the passed values.

I must correct my conclusion here. One function parameter is actually used in
the condition "!stack" while the second parameter is forwarded to other function
calls.
Is this source code line 83 handled by a SmPL isomorphism?


> In your case, I think you want to be completely sure that regardless of
> the execution path chosen, the test is performed.  So you should put when
> string after the first ... (ie the one after the first { ).

I'm sorry. I do not really understand your suggestion.

Regards,
Markus
