From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Sun, 18 Nov 2012 00:16:38 +0100
Subject: [Cocci] rewrite C preprocessor
In-Reply-To: <CAP6exYJmah2MZkd5XSukArznvYbe3fn38Q9o5ppJDj7Z9JNd5Q@mail.gmail.com>
References: <CAP6exYJmah2MZkd5XSukArznvYbe3fn38Q9o5ppJDj7Z9JNd5Q@mail.gmail.com>
Message-ID: <CAACXqO9BuS70TtXvcLk1Y=DjibJHP8B0VEzeWs1V=a7K9L+5NQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 24 October 2012 23:59, ron minnich <rminnich@gmail.com> wrote:
> Somebody asked me about a way to semantically patch
> #ifdef X
> to
> #if configured(X)

As already suggested, a script in sed/perl should be able to give you a
quick result for a relative low investment, although it would likely not
distinguish comments/strings from code and possibly not be so robust,
so there is a need for manual inspection of the result.

If you want to write something that is more robust I would suggest taking
the source of stripcmt, http://www.bdc.cx/software/stripcmt/, and modify
that. The source of that tool is very simple, just complicated enough
to keep a states of being inside strings/comments, and then some code
to remove comments which you can remove and then just add some code to
recognise #ifdef X for your task.

BR H?kon L?vdal
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
