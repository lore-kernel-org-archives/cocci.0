From: haohaiziround@hotmail.com (ZhouYuan)
Date: Thu, 7 May 2015 10:32:46 +0800
Subject: [Cocci] Question about the use of "...when !=" in SmPL
Message-ID: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,
I have met many problems when I try to use the clause of "when".
For example, I want to check whether there is an default statement in switch, I wrote the Semantic Patch as following: 
@rule at function F;position p;expression E, E1;statement S, S1;@@F at p (...){switch (E) {...when != default: S}}
@script: python at p<<rule.p;@@print p[0].file, p[0].line
and I got the result after running it:
Fatal error: exception Failure("minus: parse error:  = File "ex7.cocci", line 9, column 0,  charpos = 93    around = '...', whole content = ...when != default: S")
Also, another example can be witnessed here. I wrote another patch to check whether there is an "else" after  "if" statement:
@rule534 at function F;position p;statement S1, S2;@@F at p (...){if (...) S1...when != else S2}
But i also got the same "minus: parse error"@the line of when.
I would be so appreciated if someone could give me some suggestions about what is wrong in my Patch and how to use when correctly.
Thank you so much!
Best regards,Yuan  		 	   		  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150507/d047f761/attachment.html>
