From: luca@coelho.fi (Luca Coelho)
Date: Tue, 11 Sep 2018 11:08:37 +0300
Subject: [Cocci] Weird problem trying to match code inside a function
Message-ID: <fa1892a1698ad83235d455a947c354a54fa34c1d.camel@coelho.fi>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I bumped in to another weird problem.  I'm trying to match some code
inside a function that has a specific struct as a parameter, but I
can't get it to work.

This is cocci code I tried first: 

http://pastebin.coelho.fi/6f8f346822a7c99e.txt

And this is the file I'm trying to match:

http://pastebin.coelho.fi/f73f542932add1c6.txt

The led activate op changed from being a function that returns void to
one that returns int and I had to backport that.

The strange thing is that if I have only the first rule, it works fine,
but when I add the second rule it fails.

I can make it work if I match the entire code, without trying to match
the function in the first rule:

http://pastebin.coelho.fi/46c18ce890330d57.txt

And this is fine for me now, but I'm really curious as to why I had the
problem with my first implementation...

Can you shed some light?

--
Cheers,
Luca.
