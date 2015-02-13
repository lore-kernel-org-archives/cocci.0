From: rminnich@gmail.com (ron minnich)
Date: Fri, 13 Feb 2015 02:04:17 +0000
Subject: [Cocci] replace long in parameter with int32
Message-ID: <CAP6exYKebNpiP039k-TApNxMD=QBwAmK=QXj30efboabD=D4cw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've done some searching but have not found this

I'd like to change all occurrences of things like this:
t f(..., long x, ...) {...}

such that long becomes int32.

I've been trying and failing, and have given up :-)

I am able to change it everywhere else, just not in functions.

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150213/189cb7ce/attachment.html>
