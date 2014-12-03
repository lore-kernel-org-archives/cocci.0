From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Dec 2014 19:13:50 +0100 (CET)
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
In-Reply-To: <547F4892.6080405@inria.fr>
References: <547F4892.6080405@inria.fr>
Message-ID: <alpine.DEB.2.10.1412031912430.2373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 3 Dec 2014, Francois Berenger wrote:

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

It's hard to know how much generality you want.  But just for the code you
have shown, the following code works fine for me:

@@
expression i;
@@

for ( ; ;
- ++i
    ) {
  if (1) {
+   ++i;
    continue;
  }
}

julia
