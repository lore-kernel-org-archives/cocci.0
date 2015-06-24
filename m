From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 24 Jun 2015 15:41:15 +0200
Subject: [Cocci] new release: 1.0.1
In-Reply-To: <alpine.DEB.2.10.1506180654120.2663@hadrien>
References: <alpine.DEB.2.10.1506180654120.2663@hadrien>
Message-ID: <20150624134115.GA5698@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 18 Jun 2015, Julia Lawall wrote:

> Main changes:
> 
> * There is a --use-gitgrep option for using git grep to preselect files.
> I'm not sure about the exact performance tradeoffs.
> 
> * Small improvement on the handling of "default:" in a switch.
> 
> * A change in the treatment of ... in functions that contain loops.  This
> could potentially cause a performance problem, although I have not
> observed it.  The previous version was incorrect, though.  Some further
> performance improvements could be possible.
>
just noticed that git pull says "Already up-to-date."
but there is no 1.0.1 tag ?

url = https://github.com/coccinelle/coccinelle - wrong repo ?

thx!
hofrat
