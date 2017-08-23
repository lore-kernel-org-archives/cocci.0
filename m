From: derek@knosof.co.uk (Derek M Jones)
Date: Wed, 23 Aug 2017 16:48:58 +0100
Subject: [Cocci] parsing of C code
In-Reply-To: <alpine.DEB.2.20.1708230827550.3212@hadrien>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
 <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
 <alpine.DEB.2.20.1708230827550.3212@hadrien>
Message-ID: <7e9b2398-24fb-859a-b989-04701a823725@knosof.co.uk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia,

> The Linux kernel has some declarations like
> 
> type fn(a1, a2) >
> with no trailing ; followed by a function definition.  This gives a parse
> error on a1.  In the previous version, Coccinelle was able to recover an

The K&R style.  Perfectly legal C.

> Basically the recovery process is focused on finding a { in column 0 and
> then a } in column 0, and then it goes on after that.  But it can go
> backwards sometimes, because a parsing problem can cause a parsing attempt
> to read too far, into the next function.

Skip to ; is a remarkably effective syntax error recovery strategy.


-- 
Derek M. Jones           Software analysis
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
