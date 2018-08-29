From: moustafa@cmpsamurai.com (Moustafa Mahmoud)
Date: Wed, 29 Aug 2018 03:52:57 +0200
Subject: [Cocci]
	=?utf-8?q?Embedding_Meta-variables_in_added_Comments_usin?=
	=?utf-8?q?g_semantic_patches=D8=B2?=
In-Reply-To: <alpine.DEB.2.21.1808280350290.2313@hadrien>
References: <CAKCTf_bKa6MbcvLw=0r+pjXB-TrqAKAPyXhu+vZ=0vXih7i54Q@mail.gmail.com>
 <alpine.DEB.2.21.1808280350290.2313@hadrien>
Message-ID: <CAKCTf_YSXLYoP8u2q0TzcUGNZY1tqfYw46ubmz+RFht54hCB2Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thanks alot for your reply. I will look into this option .
I was hoping to use coccinelle to annotate some c code so that I would
later parse it to determine the program flow.

Is there a way to get more information from -show-ctrl-flow switch in
coccinelle ? It only shows "if" nodes without the expression s inside them
in dot graph ?

Thanks alot


On Tue, Aug 28, 2018, 12:53 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Tue, 28 Aug 2018, Moustafa Mahmoud wrote:
>
> > this semantic patch doesn't produce the required behavioir
> >
> > @annotate_if_conditions@
> > expression ex;
> > @@
> >
> > <+...
> > + /* ex */
> > if(ex){...}
> > ...+>
> >
> >
> > it produces the following
> >
> >      int x =5;
> >      int y =6;
> >      int m =funct();
> > +    /* ex */   // the required behavoir I need is  /* x */
> >      if(x)
> >      {
> > +       /* ex */
> >         if(y)
> >         {
> >             return 1;
>
> Sorry, it doesn't work.  Currently the only tihng you can do is use python
> to make an identifier metavariable that actually contains a comment, and
> then add that metavariable where you want your comments.  By your comments
> will have to have a ; after them, and are thus better made with // than
> with /* */, because an identifier is not a valid statement by itself.
> Instead you need an identifier followed by a semicolon.
>
> For using python to make an identifier metavariable please see
> demos/pythontococci.{c,cocci,res}.  Please write back if it is not clear.
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180829/e576f045/attachment.html>
