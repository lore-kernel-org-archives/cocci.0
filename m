From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Sat, 6 Feb 2016 22:33:56 +0100
Subject: [Cocci] The Coccinelle repository on GitHub
In-Reply-To: <56B60D67.3080802@users.sourceforge.net>
References: <20160205202627.GA9705@pl-59055.rocqadm.inria.fr>
 <56B60D67.3080802@users.sourceforge.net>
Message-ID: <20160206213356.GA15592@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,
SF Markus Elfring (2016/02/06 16:12 +0100):
> > For those of you who were downloading Coccinelle from GitHub, we recommaend
> > that you remove your current clone of the GitHub repository and do a fresh
> > 
> > git clone https://github.com/coccinelle/coccinelle.git
> 
> Do try to indicate that the previous GitHub repository was not really compatible
> with the repository for the complete software development history?

Absolutely. The two repositories are totally incompatible.

> Are there any chances to achieve that a command like "git checkout master
> && git pull" will also work without merge conflicts (if the suggested fresh
> software copy would be omitted)?

No chances at all. No merge possibility. The former repository needs to
be deleted and the new one cloned. Not doing so would result in a big
mess.

S?bastien.
