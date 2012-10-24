From: rminnich@gmail.com (ron minnich)
Date: Wed, 24 Oct 2012 14:59:39 -0700
Subject: [Cocci]  rewrite C preprocessor
Message-ID: <CAP6exYJmah2MZkd5XSukArznvYbe3fn38Q9o5ppJDj7Z9JNd5Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Somebody asked me about a way to semantically patch
#ifdef X
to
#if configured(X)

I'm not sure I can rewrite cpp bits in coccinelle, I failed on my
first few attempts, but .. can I?

ron
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
