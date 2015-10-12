From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Mon, 12 Oct 2015 23:43:14 +0200
Subject: [Cocci] elision of unneeded parens
In-Reply-To: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
References: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
Message-ID: <CA+MoWDp13SaQHQSCkf50WvQWMB1E3v_0kTFs94HbJ3onw4-SuA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Oct 12, 2015 at 11:38 PM, ron minnich <rminnich@gmail.com> wrote:
> I've had someone request something and I want to show them how cool
> coccinnelle is. If only I were smart enough!
>
> There are lots of things like this:
> if ((a == b) && (c != e))
>
> which I'd like to turn in to
> if (a == b && c == d) ...
Where does d comes from?
