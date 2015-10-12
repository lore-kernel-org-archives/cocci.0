From: rminnich@gmail.com (ron minnich)
Date: Mon, 12 Oct 2015 21:45:44 +0000
Subject: [Cocci] elision of unneeded parens
In-Reply-To: <CA+MoWDp13SaQHQSCkf50WvQWMB1E3v_0kTFs94HbJ3onw4-SuA@mail.gmail.com>
References: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
 <CA+MoWDp13SaQHQSCkf50WvQWMB1E3v_0kTFs94HbJ3onw4-SuA@mail.gmail.com>
Message-ID: <CAP6exYLMymc3OeLMDJfvu5xkPUZe8UGRDNGfufMM-c=VUONd9A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

wow, I can't type.

Let me say it more sensibly, even if wrong :-)
[[[ I know this is wrong, it's kind of "what I want it to do" ]]]

@@
expression E1, E2;
statement S;
function f;
@@
f(...){<...
-if ((E1) && (E2))
+if (E1 && E2)
S
...> }

Is that any more sensible?

thanks

ron

On Mon, Oct 12, 2015 at 2:43 PM Peter Senna Tschudin <peter.senna@gmail.com>
wrote:

> On Mon, Oct 12, 2015 at 11:38 PM, ron minnich <rminnich@gmail.com> wrote:
> > I've had someone request something and I want to show them how cool
> > coccinnelle is. If only I were smart enough!
> >
> > There are lots of things like this:
> > if ((a == b) && (c != e))
> >
> > which I'd like to turn in to
> > if (a == b && c == d) ...
> Where does d comes from?
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20151012/ed61135b/attachment.html>
