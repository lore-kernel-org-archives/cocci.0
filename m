From: skunk@iSKUNK.ORG (Daniel Richard G.)
Date: Fri, 26 Jun 2015 00:33:06 -0400
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <558B9B75.2080006@users.sourceforge.net>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506240934280.2553@hadrien>
 <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
 <558B9B75.2080006@users.sourceforge.net>
Message-ID: <1435293186.3377577.308083673.65A335EF@webmail.messagingengine.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2015 Jun 25 08:11+0200, SF Markus Elfring wrote:
> > Could some ifdefs be selectively evaluated/ignored for parsing
> > purposes?
>
> Would you like to consider any software improvements for the skipping
> of source code analysis around specific parts?
> https://github.com/coccinelle/coccinelle/issues/20

If by "consider" you mean "support," then sure. If "implement," then,
well, OCaml isn't my strong suit :]

The magic coccinelle:skip comments are an interesting feature I was not
aware of; that should prove useful. But I would like the ability to
ignore certain sections of code that is based on existing preprocessor
conditionals, since it would be counterproductive to require adding
extra annotations that amount to the same thing.


--Daniel


-- 
Daniel Richard G. || skunk at iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
