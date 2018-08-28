From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 28 Aug 2018 03:53:32 -0700 (PDT)
Subject: [Cocci]
 =?iso8859-6?q?Embedding_Meta-variables_in_added_Comments_?=
 =?iso8859-6?q?using_semantic_patches=D2?=
In-Reply-To: <CAKCTf_bKa6MbcvLw=0r+pjXB-TrqAKAPyXhu+vZ=0vXih7i54Q@mail.gmail.com>
References: <CAKCTf_bKa6MbcvLw=0r+pjXB-TrqAKAPyXhu+vZ=0vXih7i54Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808280350290.2313@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 28 Aug 2018, Moustafa Mahmoud wrote:

> this semantic patch doesn't produce the required behavioir
>
> @annotate_if_conditions@
> expression ex;
> @@
>
> <+...
> + /* ex */
> if(ex){...}
> ...+>
>
>
> it produces the following?
>
> ? ? ?int x =5;
> ? ? ?int y =6;
> ? ? ?int m =funct();
> +? ? /* ex */? ?// the required behavoir I need is? /* x */
> ? ? ?if(x)
> ? ? ?{
> +? ? ? ?/* ex */
> ? ? ? ? if(y)
> ? ? ? ? {
> ? ? ? ? ? ? return 1;

Sorry, it doesn't work.  Currently the only tihng you can do is use python
to make an identifier metavariable that actually contains a comment, and
then add that metavariable where you want your comments.  By your comments
will have to have a ; after them, and are thus better made with // than
with /* */, because an identifier is not a valid statement by itself.
Instead you need an identifier followed by a semicolon.

For using python to make an identifier metavariable please see
demos/pythontococci.{c,cocci,res}.  Please write back if it is not clear.

julia
