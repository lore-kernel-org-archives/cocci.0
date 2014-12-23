From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 23 Dec 2014 22:42:25 +0100
Subject: [Cocci] Dynamic construction of SmPL constraints
In-Reply-To: <alpine.DEB.2.10.1412231037320.2462@hadrien>
References: <54991C80.6000508@users.sourceforge.net>
 <alpine.DEB.2.10.1412231037320.2462@hadrien>
Message-ID: <5499E1C1.5070805@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I see that there are some development challenges when I would like
>> to construct SmPL constraints in the way that they will take the directory
>> hierarchy for a source file into account.
>> How can this functionality be achieved?
> 
> You always have the file name information available in a position
> variable.
> 
> Without knowing concretely what you want to do that is the only suggestion
> that I have.

I try to prepare my semantic patches for name space issues with the
C programming language. A few of my SmPL approaches should be applicable in
general ways so that I can avoid efforts at other places.

It seems that SmPL constraints are set up at start of the program "spatch".
I imagine that more fine-tuning will help to achieve safer and better
handling of relevant background information at the moment when a concrete
source file should be analysed.
The directory hierarchy should influence the identifier selection somehow,
shouldn't it?

Regards,
Markus
