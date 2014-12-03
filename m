From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 3 Dec 2014 18:34:49 +0100
Subject: [Cocci] What is the spatch file for this change and
	the	corresponding spatch command line invocation
In-Reply-To: <547F4892.6080405@inria.fr>
References: <547F4892.6080405@inria.fr>
Message-ID: <20141203173449.GX25677@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Dec 03, 2014 at 06:29:54PM +0100, Francois Berenger wrote:
> Hello,
>
> I give up trying to write the spatch myself:
>
> Before file:
> ---
> int i;
>
> for ( ; ; ++i ) {
>   if (1) {
>     continue;
>   }
> }
> ---
>
> After file:
> ---
> int i;
>
> for ( ; ; ) {
>   if (1) {
>     ++i;
>     continue;
>   }
>   ++i;
> }
> ---
>
> All my trials don't work, not any change in the file appears
> if I try --in-place and -o fails because
> "-o can not be applied because there are no modified files"

Can you take the hands on tutorial before expecting folks to
write rules for you?

https://www.youtube.com/watch?v=buZrNd6XkEw

  Luis
