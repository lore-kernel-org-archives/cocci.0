Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7A4CD6E44
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=7LoK0u7LXJnmLoxtEGyvCcNTHN4ScvY/448EGJxrjW8=;
  b=R0xoSZY1+qDHBGMY36H0RmOgGffM51upV6wkmx6hv3ZVdlJt+IOC2T56
   Idg1/l0k325WADogOwMTCTaUNvfT1XwAxbjTWBXUG9sLUQxbGMmUQWHT2
   zwMPoP8Dtdp+AHENTBaTXRfH27c9dWxvcdnvGu8Bn1Y++2FpS3DEh2b5R
   g=;
X-CSE-ConnectionGUID: X2UIKYpYSQKWaLVUIcTNZg==
X-CSE-MsgGUID: 8WivuVqVQCG5kLHOObsFKw==
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
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278669723"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 12:49:59 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 423FE82671; Thu, 28 May 2026 12:49:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A95D482667
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 12:49:51 +0200 (CEST)
X-CSE-ConnectionGUID: 9ONI9EzxQO2VXat4FnsJbQ==
X-CSE-MsgGUID: eiP2Q/T/TcK8gD5YnkX1jA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="147812660"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:49:51 +0200
Date: Thu, 28 May 2026 12:49:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Pierrick Philippe <pierrick.philippe@irisa.fr>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
In-Reply-To: <43e1b679-ed16-4fd0-8a73-7b5159bff321@irisa.fr>
Message-ID: <7f3572e6-61b2-ca57-5dfd-8aa44256f7bd@inria.fr>
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr> <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr> <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr> <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de> <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de> <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr> <ad06211-6441-9568-e643-c39df9bf8494@inria.fr> <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr> <4221c671-682-68de-9a94-1634364b6685@inria.fr>
 <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de> <e919c230-4996-43af-9a2c-ce025399d35e@irisa.fr> <041a14c-d1ee-7181-a617-82b4b294b6fa@inria.fr> <f3b5783f-34cd-430d-be81-a23ff30f4a86@irisa.fr> <5a7e76-418c-6b3c-41a8-6156589441e@inria.fr>
 <43e1b679-ed16-4fd0-8a73-7b5159bff321@irisa.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-656495293-1779965391=:10822"
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3546
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/jKIaLRpMCB68KP5uzvYRcA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-656495293-1779965391=:10822
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 28 May 2026, Pierrick Philippe wrote:

> On 5/28/26 10:21, Julia Lawall wrote:
> > On Thu, 28 May 2026, Pierrick Philippe wrote:
> >> On 5/28/26 09:48, Julia Lawall wrote:
> >> I have tried it, and spatch was complaining for some reason.
> >> Though it might be to my lack of experience with SmPL.
> >> I can provide the output if needed.
> > Please provide the semantic patch used and the resulting output.
>
> Sure, here is the output of `spatch --sp-file ./test-python.cocci
> ./test-struct.c -debug`:
>
> ```
> init_defs_builtins:
> /nix/store/40c99rw6w18kbf89qjqampp7m672a773-coccinelle-1.3.0/lib/coccinelle/standard.h
> -----------------------------------------------------------------------
> processing semantic patch file: ./test-python.cocci
> with isos from:
> /nix/store/40c99rw6w18kbf89qjqampp7m672a773-coccinelle-1.3.0/lib/coccinelle/standard.iso
> -----------------------------------------------------------------------
> @searching_struct_scalar@
> expression E1, E2;
> identifier F, X;
> initialiser I;
> type T;
> @@
> T F = I;
> ...
> (
> memcmp(&F.X, E1, E2)
> |
> memcmp(E1, &F.X, E2)
> )
>
> @script:python generation_struct_scalar@
> f << searching_struct_scalar.F;
> x << searching_struct_scalar.X;
> content;
> @@
> coccinelle.content = cocci.make_ident("__attribute__((myattr(\"" + x +
> "\"))) ")
>
> @replacement_struct_scalar@
> expression searching_struct_scalar.E1, searching_struct_scalar.E2;
> identifier searching_struct_scalar.F, searching_struct_scalar.X,
> generation_struct_scalar.content;
> initialiser searching_struct_scalar.I;
> type searching_struct_scalar.T;
> @@
> T
> +content
>  F = I;

You have declared content as an identifer and added it into a position
where an identifier is not allowed.  My suggestion was something like:

coccinelle.content = "\"" + x + "\""

Or whatever is appropriate in pything for putting the value of x in string
quotes.  Then in the replacement rule you can put the whole
__attribute((...)) construction.

julia

> ...
> (
> memcmp(&F.X, E1, E2)
> |
> memcmp(E1, &F.X, E2)
> )
>
> plus: parse error: 
>   File "./test-python.cocci", line 30, column 1, charpos = 629
>   around = 'F',
>   whole content =  F = I;
> ```
>
> Seems like the issue is in the rule `replacement_struct_scalar`.
>
> >
> > thanks,
> > julia
>
--8323329-656495293-1779965391=:10822--
