Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46474CD5BDE
	for <cocci@archiver.kernel.org>; Wed, 27 May 2026 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LPRUOQ69fE/aQi4AmuiLSgcoBYv2BZ2ybVx7i5PAKhc=;
  b=SsBfdY5+/U4hKLFeTsvjhYbXS9w8WG5l+pMHoNhTXPRUSIJolgNsx+Ri
   e8ADhRHz+d6ynQH8+8pwgN8Ma6f7LZOeGAXcYX4Hw+URehbGsX8mzMjYG
   89XdfdZrt7sey0weD2nGXgiAnx/+tFaVz2S6svxEAXaH6vEqu810AZRHH
   o=;
X-CSE-ConnectionGUID: ofenJmmqRRSgMVZZtI1Ojw==
X-CSE-MsgGUID: 4fdzCb9qQjqFI9ksxQCCVQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="278433465"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2026 10:59:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7B491815B4; Wed, 27 May 2026 10:59:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5DC79812BF
	for <cocci@sympa.inria.fr>; Wed, 27 May 2026 10:59:55 +0200 (CEST)
X-CSE-ConnectionGUID: Eut3pIHtTEWuK6UjEApp3Q==
X-CSE-MsgGUID: RpJ7nJLyR4STptnBJ93OPw==
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="278433413"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:59:55 +0200
Date: Wed, 27 May 2026 10:59:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
In-Reply-To: <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr>
Message-ID: <ad06211-6441-9568-e643-c39df9bf8494@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr> <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr> <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de> <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de> <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-146413871-1779872395=:3627"
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3527
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/xkNOtuAhVhyUMKMqYUXGTw>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-146413871-1779872395=:3627
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 27 May 2026, Pierrick Philippe wrote:

> Hi Markus and Julia,
>
> I hope you are doing well.
>
> I am now trying to work with structures and basically here is the patch
> I'd like to generate:
>
> ```diff
> struct foo {
>     int x;
>     int y;
> };
> int main(void) {
> -   struct foo f = { 42, 42 };
> +  struct foo __attribute__((myattr (("x")))) f = { 42, 42 };
>     int b;
>     int *c = &b;
>     int z = memcmp(&f.x, c, sizeof(int));
>     return z;
> }
> ```
>
> I used the following semantic patch which is successfully parsed, but
> not generating any diff:
>
> ```cocci
> @attribute_struct_scalar_type@
> expression E, E1, E2;
> type T;
> identifier F, X;
> @@
> -T F = E;
> +T __attribute__((myattr(("X")))) F = E;
> ...
> memcmp(&F.X, E1, E2)
> ```

I think that the problem is that { ... } is not actually an expression in
C.  It's a strange thing that can only exist as part of a declaration.

But you don't want to change it, so you don't need a metavariable for it.

Just write:

- T F =
+ T __attribute__((myattr(("X")))) F =
  { ... };

Lots of other decompositions are possible.  For example you can also
write:

T
+ __attribute__((myattr(("X"))))
  F = { ... };

julia

>
> The idea is essentially the same than in my previous email, although
> here I'm working with field access.
> The semantic patch is clearly inspired from a previous version for
> integer or float which was successfully parsed and spatch was generating
> the expected diff.
>
> Also, from what I understand from the docs, metavariables of type
> `field` target field declaration (meaning within the structure type
> definition specifically).
> And I could not wrap my head around a way to use it to achieve my goal here.
> I also tried to used a quite simple semantic patch, which was still not
> generating any diff and raising a warning ("should f be a metavariable?").
> And I do not understand why this one is not working since there are
> basically no metavariables outside the three expressions.
> Here is the semantic patch in question:
>
> ```cocci
> @attribute_struct_scalar_type_dummy@
> expression E, E1, E2;
> @@
> -struct foo f = E;
> +struct foo __attribute__((myattr(("x")))) f = E;
> ...
> memcmp(&f.x, E1, E2)
> ```
>
> In any case, thank you for your time and your previous answers.
>
> Pierrick
>
>
--8323329-146413871-1779872395=:3627--
