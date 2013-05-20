From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 20 May 2013 20:24:18 +0200
Subject: [Cocci] isomorphism with unlikely
In-Reply-To: <519A61A8.7010402@metafoo.de>
References: <20130520173406.GB5890@katana>
 <519A61A8.7010402@metafoo.de>
Message-ID: <20130520182415.GA6975@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> There is already an isomorphism for unlikely. But it is in one direction
> only, so 'unlikely(E)' in your cocci script will also match 'E', but 'E'
> wont match 'unlikely(E)'.

Okay, but I would then still need 'unlikely(!r)' and 'unlikely(r ==
NULL)' because the !r isomorphisms won't apply. I'd like to have both :)

> Btw. if you use 'statement S;' and 'if(...) S' instead of '{ ... }' you'll
> also be able to match if there is only a single statement without brackets
> after the if.

True, thanks! Slowly getting back to it...
