From: sieler@allegro.com (Stan Sieler)
Date: Tue, 24 Feb 2015 17:27:46 -0800
Subject: [Cocci] EXN question
Message-ID: <F3E7ABF7-5E64-4AEF-B9CF-AE8CA0CE458B@allegro.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm new to coccinelle.  I've just run spatch over about 300,000 lines of compiling C programs.
and was curious what the following meant:

   ...
   HANDLING: ./misc/pasnet.c
   EXN:Failure("lexing: empty token")
   ...

I did a binary search exercise :) ... and got the error down to one line:

   foo ('');

where foo was not declared (and had not been used earlier).

So, why was this code in there?  (I.e., how could it compile in C?)

Because it was within "#if 0 / #endif"!

It was Pascal code that was still to be translated to C.  
Thus, it was "commented out" (not actually a comment, of course, but similar effect).

We were quite surprised that spatch / coccinelle isn't ignoring stuff
(I won't say "code", because it's often non-code English text)
within "#if 0 / #endif" blocks, and feel this is a design flaw.

(BTW, I'm not referring to a macro that happens to evaluate to 0 ...
it's the five characters "#", "i", "f", " ", "0")

So far, I've only tested for the "!E & C" case, and it caught none (until I injected one as a test ... it properly caught that).

thanks,

Stan Sieler
sieler at allegro.com
