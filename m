Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A1AE77188
	for <cocci@archiver.kernel.org>; Fri,  3 Jan 2025 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=bgy8KpAk3IKGApnBZZVVFJKZbIXeRsPQu4tj+FC8Yss=;
  b=baKZD8+jzGda3naro1bGdb+7GyevFZF8OknnBDdQ2jvHYgQemawq+S4M
   JuVYFKVPPINZRH0+VerNjHZkDqhnZ+XUyMlympjp3qjX/uM5Ye5P7Xty7
   bbfArjD5P4XwJmtLxa4po8hz/1NYXHP0Y9M8CHCFFMSjbn1GeU/UX30s1
   0=;
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
X-IronPort-AV: E=Sophos;i="6.12,286,1728943200"; 
   d="scan'208";a="201325361"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jan 2025 12:36:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 161E5E007A; Fri,  3 Jan 2025 12:36:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 977CEE0077
	for <cocci@sympa.inria.fr>; Fri,  3 Jan 2025 12:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bgy8KpAk3IKGApnBZZVVFJKZbIXeRsPQu4tj+FC8Yss=;
  b=SEV1c48xBc3qyZzNQBAyVuo39WVkNej4xHl8r6ZY2LuTAyTyl2j2CH5d
   bcA2Y/9ZfgoJyWGVvUR4+4TPT1NR36sCrfLkWP2ZGGGTT8w1Wthq02f2d
   tPPPl+RZ07Tzpz+dDGxA/A4HgJA6fKlvJs3Djbspc4DkrsUMxln1fb8iE
   I=;
X-IronPort-AV: E=Sophos;i="6.12,286,1728943200"; 
   d="scan'208";a="201325357"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 12:36:38 +0100
Date: Fri, 3 Jan 2025 12:36:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Mats Kindahl <mats.kindahl@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <3938a0d1-64c6-438f-a689-2714da8cf0b6@gmail.com>
Message-ID: <9740965-4f83-6428-65c4-4f4e3544faa3@inria.fr>
References: <3938a0d1-64c6-438f-a689-2714da8cf0b6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1808439647-1735904198=:3367"
Subject: Re: [cocci] Matching and replacing array types in sizeof()
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2196
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/9740965-4f83-6428-65c4-4f4e3544faa3%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1808439647-1735904198=:3367
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 3 Jan 2025, Mats Kindahl wrote:

>
> Hi again,
>
> Here is yet another problem I ran into.
>
> I would like to replace malloc() of an array with calloc() instead, but I cannot match the array type in this code:
>
>       #include <stdlib.h>
>       #include <string.h>
>
>       int main() {
>         int* mem = malloc(sizeof(int[2]));
>         memset(mem, 1, sizeof(int[2]));
>       }
>
> I tried with this semantic patch:
>
>       @@
>       type T;
>       constant C;
>       @@
>       - malloc(sizeof(T[C]))
>       + calloc(C, sizeof(T))
>
> But it gives a parse error:
>
>       mats@abzu:~/lang/cocci/tests$ spatch --debug --cocci-file array_type.cocci code
>       init_defs_builtins: /usr/lib/coccinelle/standard.h
>       -----------------------------------------------------------------------
>       processing semantic patch file: array_type.cocci
>       with isos from: /usr/lib/coccinelle/standard.iso
>       -----------------------------------------------------------------------
>       @@
>       type T;
>       constant C;
>       @@
>       - malloc(sizeof(T[C]))
>       + calloc(C, sizeof(T))
>
>       minus: parse error:  
>        File "array_type.cocci", line 5, column 17, charpos = 43
>        around = '[',
>        whole content = - malloc(sizeof(T[C]))
>
> I have also tried replacing the "T[C]" with "(T)[C]" and even tried just matching "T[...]" and "(T)[...]" in the hope that the parser is just not able to handle the type, no no avail.
>
> This parses fine in a normal compiler, so I suspect the Cocci parser is missing this case (looking at the code I see nothing similar to the direct-abstract-declarator from the C99 standard), so are there any
> alternative way to deal with this?

It's indeed quite possible that this case is not handled.  In the short
term, you can use python code.

@r@
type t : script:python() { ... };
@@

malloc(sizeof(t))

@script:python s@
t << r.t;
@@

coccinelle.ty = ...
coccinelle.sz = ...

@@
type r.t;
type s.ty;
expression s.sz;
@@

- malloc(sizeof(t))
+ calloc(C, sizeof(T))

The first ... should be python code to recognize the pattern of T[C].
The ones in the python script should extract the T and C from that code.

You would have to check to the extent that you want that T is a type and C
is a constant.

It's a bit clunky, but it eliminates the need to wait for the fix.  I will
try to fix it soon, though.

julia
--8323329-1808439647-1735904198=:3367--
