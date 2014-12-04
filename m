From: francois.berenger@inria.fr (Francois Berenger)
Date: Thu, 04 Dec 2014 11:17:15 +0100
Subject: [Cocci] What is the spatch file for this change and the
 corresponding spatch command line invocation
In-Reply-To: <alpine.DEB.2.10.1412031912430.2373@hadrien>
References: <547F4892.6080405@inria.fr>
 <alpine.DEB.2.10.1412031912430.2373@hadrien>
Message-ID: <548034AB.2070400@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

What is the spatch command line you used and which version of coccinelle 
are you using?

I tried this:

# apply.spatch is your exact proposal
spatch --sp-file apply.spatch test_before.c -o /dev/stdout

Then I see on stdout the exact same file than what's in test_before.c

On 12/03/2014 07:13 PM, Julia Lawall wrote:
> @@
> expression i;
> @@
>
> for ( ; ;
> - ++i
>      ) {
>    if (1) {
> +   ++i;
>      continue;
>    }
> }
>
> julia

-- 
Regards,
Francois.
