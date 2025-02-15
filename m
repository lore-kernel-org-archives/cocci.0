Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9274CC021A0
	for <cocci@archiver.kernel.org>; Sat, 15 Feb 2025 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZzfnnrBUTpRlQF+n+sXmghKyicXYruPdrsJnkKrkymo=;
  b=KlM563qGTwClWBfUp4LoUv+rdXQBZfZIEdcf5HyjEFshnJBtgg2j+l4w
   hyvSUU3MfJgJdc6CXeFHQtfZcZSbWBhZ8XM/ONgY1KncqHPeohRy4FsfP
   KUjslAcD46Ir+deuzj9MscJIdTUAdGQU38rC/Qk73ASzO6WSv9/sLboaN
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208";a="208447567"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Feb 2025 20:17:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0223E0261; Sat, 15 Feb 2025 20:17:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5C036E0260
	for <cocci@sympa.inria.fr>; Sat, 15 Feb 2025 20:17:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZzfnnrBUTpRlQF+n+sXmghKyicXYruPdrsJnkKrkymo=;
  b=rZ/ciWcboGEIlvUi8LzjCdK0eJ88MX076lUR7Uh9f9byhtCjoKejqWoa
   6YV9Y1Ph1jWaeCX1BzhUsWNsKzgtargCEbXJqdX3eeQUaOx2Plr4pLemn
   r/0R5ZXUh1xPvZzkCE14++EoAX49QnPIiQJbgBFebNuBUsZkbKZjZvBFl
   k=;
X-IronPort-AV: E=Sophos;i="6.13,289,1732575600"; 
   d="scan'208";a="109201528"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 20:17:32 +0100
Date: Sat, 15 Feb 2025 20:17:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2502152014120.17391@hadrien>
References: <592e3d24-4d42-43c7-9874-8c8eb1e12deb@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-996400129-1739647052=:17391"
Subject: Re: [cocci] Adding statement after declarations with zero-length
 match after
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2417
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/alpine.DEB.2.22.394.2502152014120.17391%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-996400129-1739647052=:17391
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 15 Feb 2025, Mats Kindahl wrote:

>
> Hi again,
>
> Here is one case again that is stumping me. Suppose that we want to write an SmPL to replace dynamic allocations inside a function where the allocated object is not visible outside the function. For example, consider this example:
>
>       #include <stdio.h>
>       #include <stdlib.h>
>
>       struct magic {
>         int i_val;
>         float f_val;
>       };
>
>       extern void magic_init(struct magic *);
>
>       void foo_2(void) {
>         struct magic more = malloc(sizeof(struct magic));
>         more->i_val = 1;
>         printf("%d", more->i_val);
>         free(more);
>       }
>
> Here we want this to be rewritten to
>
>       void foo_2(void) {
>         struct magic more;
>         magic_init(&more);
>         more.i_val = 1;
>         printf("%d", more.i_val);
>       }
>
> However, if we for some reason return the pointer, we do not want it to be rewritten.
>
>       struct magic *foo_3(void) {
>         struct magic *ptr = malloc(sizeof(struct magic));
>         ptr->i_val = 1;
>         printf("%d", ptr->i_val);
>         return ptr;
>       }
>
> There are a few more cases, but this is the basics. In particular I ignore assigning to and from the variable as well as calling other functions, because this is not part of the problem right now. Note that I want the call to "magic_init()" to be
> after all the declarations.
>
> Using the following semantic script, we want to capture these cases and replace it with a stack allocation. This requires rewriting internal references as well, so we have a piece at the end that updates the references. Here I use the pattern of
> catching the case with a base rule, and then using that in a dependent rule. This allows be to capture the malloc call to a local idexpression but find the identifier when it is being declared so that I can replace it.
>
>       @base exists@
>       type T;
>       local idexpression T *var;
>       position p1;
>       @@
>         var@p1 = malloc(sizeof(T))
>         ... when forall
>             when != return var;
>
>       @depends on patch exists@
>       type base.T;
>       position base.p1, p2;
>       identifier var, fld;
>       statement S,S1;
>       @@
>       (
>       - T@p2 *var;
>       + T var;
>         ...
>       - var@p1 = malloc(sizeof(T));
>       + magic_init(&var);
>       |
>       - T@p2 *var@p1 = malloc(sizeof(T));
>       + T var;
>         ... when != S
>       + magic_init(&var);
>         S1
>       )
>         ... when any
>       (
>       - free(var);
>       |
>       - *var
>       + var
>       |
>       - var->fld
>       + var.fld
>       |
>       - var
>       + &var
>       )

You can try

(
+ magic_init(&var);
  S1 & <... ( - free(var); | and so on ) ...> )
&
<...
(
- free(var);
|
  // other cases
)
...>
)

I would suggest to separate the second rule into two, which will require
duplicating the first rule, because you can't inherit a position over a
change.  I will play around with it shortly and get back to you.

julia



>
> However, since I match S1 after the added "magic_init(&var)", this means that the statement "more->i_val = 1;" does not get a replacement and the result is this:
>
>       mats@abzu:~/lang/cocci/hacks$ spatch -D patch --cocci-file elim-malloc-free.cocci code/dynalloc.c
>       init_defs_builtins: /usr/lib/coccinelle/standard.h
>       (ONCE) Expected tokens malloc
>       HANDLING: code/dynalloc.c
>       diff =  
>       diff -u -p a/dynalloc.c b/dynalloc.c
>       --- a/dynalloc.c
>       +++ b/dynalloc.c
>       @@ -9,10 +9,10 @@ struct magic {
>       extern void magic_init(struct magic *);
>        
>       void foo_2(struct magic *out) {
>       -  struct magic *ptr = malloc(sizeof(struct magic));
>       +  struct magic ptr;
>       +  magic_init(&ptr);
>         ptr->i_val = 1;
>       -  printf("%d", ptr->i_val);
>       -  free(ptr);
>       +  printf("%d", ptr.i_val);
>       }
>
> I've tried various constructions, including:
>
>  *  Skipping S1, but it insists that it needs a token to attach to.
>  *  Using a ( ... & ... ) to match a statement and do the replacement, but it insists that it needs a token to attach to.
>  *  Using declaration list before, but again, it needs a token to attach to.
>
> In essence, I need some kind of "zero-length match" that can follow the replacement.
>
> Any suggestions?
>
> Best wishes,
> Mats Kindahl
>
>
>
--8323329-996400129-1739647052=:17391--
