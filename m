From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 22 Sep 2012 16:43:22 +0200
Subject: [Cocci] Unwanted space added at end of line
In-Reply-To: <1348302555.11590.8.camel@ice-age.regit.org>
References: <1348302555.11590.8.camel@ice-age.regit.org>
Message-ID: <505DCE8A.9050403@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/22/2012 10:29 AM, Eric Leblond wrote:
> Hello,
> 
> I've just wrote a really simple SMPL (attached to the mail). It makes a
> modification on the code which is the following:
> 
> - if (x == NULL) S1
> + if (unlikely(x == NULL)) S1
> 
> The result is semantically correct but there is spaces at end of line as
> shown in the example below:
> 
> @@ -173,8 +173,8 @@ DefragContextNew(void)
>      DefragContext *dc;
>  
>      dc = SCCalloc(1, sizeof(*dc));
> -    if (dc == NULL)
> -        return NULL;<- no space
> +    if (unlikely(dc == NULL))
> +        return NULL;   <- 4 space here 
> 
> I've tried to look at coccinelle code but I'm unable to find a way to a
> solution.

A simple solution is to take the statment out of the diff. It is generally a
good idea to try to minimize the parts which are removed in one line but added
back in the next line since everything in the plus part of the diff will be
send through the pretty printer which may cause the code to be re-formatted

E.g. in your case a minimized cocci patch could look like this:

if (
+unlikely(
 x == NULL
+)
 ) S1

- Lars
