Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461DDC10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=f4HNxi1ReHpEGDqNYYei/hacUiVnY0r4NP094Y6KFKM=;
  b=V9KaoqHPemdOniX5sERg0sYjP0h6xj5+UbItJoFL+UZqC3RBtr3K1pyY
   oK2LOa8XH69fyeP4KrdQ4GUcynMochpJRRXBUEdXmqHLTXXaNju/2HRVU
   pAoL5SY5iVYzTKUA4CQuZWrBreaZPB5ODrdk5XJorvZqriH4JqU7Fo3ve
   c=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164650863"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 12:10:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7EA78E0138; Mon,  6 May 2024 12:10:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 14CC4E0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 12:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f4HNxi1ReHpEGDqNYYei/hacUiVnY0r4NP094Y6KFKM=;
  b=AP+cqHkKqYxPxO/S0qEAtMgCAW7YggIn0vOTh6x+hI38+AofRfg+F2tf
   KgW25CVe4YO3ZlO+154dyMlm5yid+4cLt5UsIlLCrehffhIR9v1WIweL2
   5qxvpnfFEfWWaOgc4n+vX2/PnCilsKSdmiseZJ249fxL5oxKtcD2hJncQ
   s=;
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164650859"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 12:09:59 +0200
Date: Mon, 6 May 2024 12:09:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Message-ID: <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1702
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/52305da6-998c-273c-c4cc-b8fdb1d161b%40inria.fr>



On Mon, 6 May 2024, Markus Elfring wrote:

> Hello,
>
> Source code parts can occasionally be repeated.
>
> * Loops
>   The control flow can contain ordinary loops.
>
> * Recursion
>   A function may be called by itself.
>
>
> Such constructs trigger special consequences also for further data processing
> with higher level technologies.
>
> + Computation tree logic
>
> + Linear temporal logic
>
>
> I am still looking for clarifications so that the Coccinelle software
> can be applied in safer ways.
>
>
> Regular expressions support some search operators for quantification.
> A notation is accordingly supported for the specification of a minimum number
> of matches which would be bigger than one item.
>
> I imagine that such functionality would be helpful also for the semantic patch language.
> How will the chances evolve to extend corresponding quantifiers anyhow?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/23f7738a7881b02d016d278ee293cfd4a126fcab/docs/manual/cocci_syntax.tex#L793
> https://github.com/coccinelle/coccinelle/blob/755250323b80f27701e78d325cc83509197b33b1/docs/manual/cocci_syntax.tex#L793
>
> I would appreciate if multiple occurrences of code elements can be better detected
> and transformed.

I have no intention of adding regular expressions.  Be more concrete about
what you are not able to do.

julia
