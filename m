From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 7 Feb 2016 09:43:58 +0100
Subject: [Cocci] The Coccinelle repository on GitHub
In-Reply-To: <20160206213356.GA15592@pl-59055.rocqadm.inria.fr>
References: <20160205202627.GA9705@pl-59055.rocqadm.inria.fr>
 <56B60D67.3080802@users.sourceforge.net>
 <20160206213356.GA15592@pl-59055.rocqadm.inria.fr>
Message-ID: <56B703CE.9040704@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The two repositories are totally incompatible.

Thanks for another clarification around the handling of a previous partial
and the complete software development history.


>> Are there any chances to achieve that a command like "git checkout master
>> && git pull" will also work without merge conflicts (if the suggested fresh
>> software copy would be omitted)?
> 
> No chances at all. No merge possibility. The former repository needs to
> be deleted and the new one cloned.

Thanks also for this information.


> Not doing so would result in a big mess.

Now I find that there is a need to clarify further software transitions
and data migrations for pull requests, isn't it?
https://github.com/coccinelle/coccinelle/pulls?q=is%3Apr+is%3Aclosed

1. Would you like to look for possibilities to keep cross references
   consistent anyhow?

2. From which Git repositories are you going pull the next changes?

3. How should a potential confusion be avoided for developers
   who dared to try anything out already in their personal topic branches?
   https://github.com/coccinelle/coccinelle/network/members

Regards,
Markus
