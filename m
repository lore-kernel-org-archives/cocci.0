From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 8 Nov 2017 21:02:12 +0800 (CST)
Subject: [Cocci] [PATCH] Coccinelle: make DEBUG_FILE option more useful
In-Reply-To: <CAK7LNASw=ECjKxwemiF904HeR5B_FUGGPxjZY3brH66iMs=9+Q@mail.gmail.com>
References: <1508061353-24744-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQMTptVYLu10uF+85OsuANbC7Fo0heD4t1ybpUE6Yh-gQ@mail.gmail.com>
 <alpine.DEB.2.20.1710260601520.17107@hadrien>
 <CAK7LNASw=ECjKxwemiF904HeR5B_FUGGPxjZY3brH66iMs=9+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711082102030.2268@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 7 Nov 2017, Masahiro Yamada wrote:

> 2017-10-26 13:02 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Thu, 26 Oct 2017, Masahiro Yamada wrote:
> >
> >> Hi Julia,
> >>
> >>
> >> 2017-10-15 18:55 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> >> > Make coccicheck checked for the existence of DEBUG_FILE on each semantic
> >> > patch, and bailed if it already existed.  This meant that DEBUG_FILE was
> >> > useless for checking more than one semantic patch at a time.  Now the check
> >> > is moved to the start of make coccicheck, and the 2> is changed to a 2>> to
> >> > append to the file on each semantic patch.  Furthermore, the spatch command
> >> > that is run for each semantic patch is also added to the DEBUG_FILE, to
> >> > make clear what each stdout trace corresponds to.
> >> >
> >> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >> >
> >>
> >> I think this is a good improvement,
> >> and looks almost good to me.
> >>
> >> Just one nit.
> >>
> >>
> >> >
> >> >  }
> >> >
> >> > +if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
> >> > +       if [ -f $DEBUG_FILE ]; then
> >> > +               echo "Debug file $DEBUG_FILE exists, bailing"
> >> > +               exit
> >> > +       fi
> >> > +       touch $DEBUG_FILE
> >>
> >> I think this "touch" is redundant.
> >>
> >> If the DEBUG_FILE does not exist, 2>> will automatically create it.
> >
> > Thanks very much for the feedback.  I will resubmit.
> >
> > julia
> >
> >
>
> Remove the redundant "touch"
> and applied to linux-kbuild/misc.

Thanks!

julia

>
>
>
> --
> Best Regards
> Masahiro Yamada
>
