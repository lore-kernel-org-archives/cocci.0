Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C04D59F52
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2024 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pEe6R0NpLJBHYoM1sXU5SoLHI1CzzS2KgvH3MS+q4ok=;
  b=Fr9LuW7FgzBM/9wWD2+yNMFcD9XbMGGfvmCk9M96T7GuK+IRrQJEiHqk
   1CCPTgQiwDCa0FOgFWmZ6Gnoadt0qq8dCpVfRmoDC8aWnG18LsKgIrQnF
   3Q1NsSxScCgvX32dC6izzE2VqAfnmMm7XBNWPMlgNofgeRZ37t5TePHyY
   A=;
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
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="192582438"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2024 17:58:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85E0BE0D1D; Wed,  6 Nov 2024 17:58:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 46E19E00B7
	for <cocci@sympa.inria.fr>; Wed,  6 Nov 2024 17:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pEe6R0NpLJBHYoM1sXU5SoLHI1CzzS2KgvH3MS+q4ok=;
  b=n12YetFFDScDtd9Vlw+06Me9t9XbaFADMvQ3bJ42azHM6kb66snhmZ5Z
   +hWhsoiRIqO6DtLBQAtXA5k5idpcP6IM+GhYcnNeYlY011/oMDn9Zhlou
   qL9173+I80cGPMORWsf+T+2ACCQ1i781piqR5uoo4lijmYSzxWmZBWQ7q
   g=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="100931530"
Received: from dt-desouza.paris.inria.fr (HELO [128.93.67.77]) ([128.93.67.77])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:58:43 +0100
Message-ID: <0a6cf23a-eec9-4e80-afba-e8f8409c1085@inria.fr>
Date: Wed, 6 Nov 2024 17:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <c07553fd-4c04-4f5c-a72e-a71fb1e66c38@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <c07553fd-4c04-4f5c-a72e-a71fb1e66c38@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Generating parse trees?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1972
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/0a6cf23a-eec9-4e80-afba-e8f8409c1085%40inria.fr>

On 11/6/24 17:20, Markus Elfring wrote:
> Hello,
>
> How do you think about to improve the collaboration with data processing tools
> that can generate parse trees?
> https://en.wikipedia.org/wiki/Parse_tree

Hi Markus,

Thanks for the suggestion. Unfortunately, many of the features you 
suggest would take significant development time we simply don't have, 
while simultaneously not having any obvious benefits or fitting any 
well-defined use case. It's also unclear exactly what you mean - what 
would a collaboration with a parse tree generator look like in practice? 
Are you suggesting we change the way we parse C files, that we add a new 
feature, or something else?

Your passion for this topic is obvious, but if you are interested in 
seeing new features being added to Coccinelle, I suggest you either:
a) clarify exactly what you want the feature to do. Give us a concrete 
scenario, something along the lines of "given XXX, a user can do YYY so 
that Coccinelle does ZZZ and outputs AAA; this would be useful if we 
want to do BBB under CCC conditions, and might be implemented using the 
DDD concept and the EEE implementation of that concept". It doesn't have 
to fit that exact format, but hopefully you understand what I mean.
b) implement the feature yourself and open a pull request, even if it's 
only a prototype or proof of concept, to at least show us what you mean.

Also understand that while it would be nice to be able to add such 
features, in practice, we have limited development time, and even 
smaller features can sometimes be deceptively complex to implement and 
take up significant time. It's unrealistic to expect us to add new 
features at the rate that you're suggesting them. As it stands, many of 
your suggestions can be both too vague and/or too ambitious. If you'd 
like for them to have more of a chance, consider focusing on something 
small and achievable. The same goes for questions that may or may not be 
feature suggestions: they should ideally be clear and focused on one 
thing. I hope you understand where I'm coming from!

> Will the support grow for selected programming languages?
> https://en.wikipedia.org/wiki/Comparison_of_parser_generators

As far as Coccinelle is concerned, support is limited to C and C++ 
(there is also an independent prototype for Rust), and this is unlikely 
to ever change. You would basically have to start from scratch.

Regards,
Victor

> Regards,
> Markus
