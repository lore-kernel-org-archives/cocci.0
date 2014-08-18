From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 18 Aug 2014 11:57:07 +0200
Subject: [Cocci] cocci: char* indexing style for linux
In-Reply-To: <alpine.DEB.2.10.1408180446550.2548@hadrien>
References: <1408219616.2683.101.camel@joe-AO725>
 <1408222763.2683.107.camel@joe-AO725>
 <alpine.DEB.2.10.1408170510420.2599@hadrien>
 <1408280475.17489.4.camel@joe-AO725> <53F0D3CB.4000803@users.sourceforge.net>
 <1408292542.17489.11.camel@joe-AO725>
 <alpine.DEB.2.10.1408171241450.2520@hadrien> <53F1BB55.8080008@metafoo.de>
 <alpine.DEB.2.10.1408180446550.2548@hadrien>
Message-ID: <53F1CDF3.5010105@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/18/2014 11:49 AM, Julia Lawall wrote:
> Actually, isn't the whoe structure field the wrong way to go about it
> here?  Don't we just want a pointer-typed expression, of whatever form it
> has?  That will unfortunately require lots of type information, but I
> don't see how to do it otherewise, because any kind of variable or
> structure field reference can also be an integer.  There isno reason why
> eg the structure field reference is the array.
>
> expression *e; matches a pointer.

The problem is that (foo->bar + 10) with foo->bar being a pointer is still a 
expression of the pointer type and so e will match the whole expression 
rather than just matching foo->bar.
