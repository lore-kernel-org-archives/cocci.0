Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B560D6EC08
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2024 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rXQTNIEJk0D8hYQLvd0UY6IRwln349VR0O9+AjpBQIU=;
  b=KuBzKZy+aABbRm3/ffm5/r6i/X/fvZIotXlfWf08FTY0m7HyI4PFP1k1
   ypNOvEjyY/iUQ/ZRCcE7U2v8w0mJbKXIOxI+Vh4x92P2az7Si2BRODzM/
   FPPJENUX5Oafx7u7h1M3CUp1ZQ3LHaCunM6GPaZhr4R0lIFuaD3fAnskK
   s=;
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
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="196518056"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2024 14:18:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D793E0D1D; Fri, 29 Nov 2024 14:18:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0796DE00B6
	for <cocci@sympa.inria.fr>; Fri, 29 Nov 2024 14:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=rXQTNIEJk0D8hYQLvd0UY6IRwln349VR0O9+AjpBQIU=;
  b=LC2AaWGguqOv15DppJ0mB2VCmE9UAw8w2iZQry7Yy95YYUbXDT4GyngQ
   NyVn0xF/8Lsn14sX9WHbjTdpGwh/yt5HiV6GU+snzGQPI1GHAAX/dj6o6
   pXdhZK4nOUKL0Xx6ikCdW3lUcnUFprRXrNzNxROFV0k5arR4cxhC6n0Dt
   8=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728943200"; 
   d="scan'208";a="103002471"
Received: from dt-desouza.paris.inria.fr (HELO [128.93.67.77]) ([128.93.67.77])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 14:18:30 +0100
Message-ID: <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Date: Fri, 29 Nov 2024 14:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
 <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2140
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/667e5848-a8e4-4308-a464-006800039029%40inria.fr>

Christian, thanks for the patch. Feel free to ignore Markus's comments, 
he is not a maintainer and as usual, his questions don't make a ton of 
sense.

On 11/29/24 13:38, Markus Elfring wrote:
> …
>> +++ b/scripts/coccinelle/api/capable_order.cocci
> …
>> +@ depends on patch@
>> +identifier F = { capable, ns_capable, sockopt_ns_capable };
>> +binary operator op,op1,op2;
> …
>> +-  F@p(EL) op E
>> ++  E op F(EL)
> …
>
> It can be amazing how many source code places can be handled by such
> a transformation approach already.
> I hope that corresponding data processing requirement analyses will trigger
> further collateral evolution.
> You propose to use the metavariable types “expression” and “binary operator”.
> These filters have got the potential to match more source code than it would be
> intended here.
> The length of computations behind a selected operator is not really restricted.
> Such expressions can probably contain varying operator chains.
> There is a desire to split the affected code into subexpressions.
> Special development challenges are involved accordingly.
> I find it safer and more promising to use scripting interfaces for this use case.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/620463b4bfb8bdc5c99dabfdfa337b34cbaa9ef1/docs/manual/cocci_syntax.tex#L655
>
> Unfortunately, required programming interfaces (for OCaml and Python) probably
> need significant improvements.
>
> Regards,
> Markus
