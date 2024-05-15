Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE05C25B75
	for <cocci@archiver.kernel.org>; Wed, 15 May 2024 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=w25Q+zVoNBX8tvxtPHdDPTNybHBYjU5SrZc49uTmPbQ=;
  b=sHSjO6DE2vH59dw8LrCpmenOg3ZNaevulTfVKIxlWgm8W4i/h+THAUEM
   l6J7i8crdwD8XZTN9Sg33gzCfMOYnRo8V3gCBYnFvBPREuqcDB3S/1CWd
   SlwKiT5WEtqFX2Q02Lb/4+b9Z8sLnRRZJXX7xbgbMlV3vwV1j1Cn5WM/c
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.08,160,1712613600"; 
   d="scan'208";a="165768173"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 May 2024 08:00:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5789EE0D9C; Wed, 15 May 2024 08:00:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CF9E7E0CE2
	for <cocci@sympa.inria.fr>; Wed, 15 May 2024 08:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w25Q+zVoNBX8tvxtPHdDPTNybHBYjU5SrZc49uTmPbQ=;
  b=aUb41JPOH93wlTM3oUyPvrF9wNQjs2s6A3c/J2K7aroWmd+hpfC9W6sh
   24arKAkazhC+z0+w32dV/I+GI4ir9GMWwN9ILw3fCw27YDc99RVBOPe7C
   amN2N5YplHinCtN6TW55xooimBDbe1avq0SuSXK9lw0rxjIq9993uGWIv
   4=;
X-IronPort-AV: E=Sophos;i="6.08,160,1712613600"; 
   d="scan'208";a="87069153"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 08:00:05 +0200
Date: Wed, 15 May 2024 08:00:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Derek M Jones <derek@knosof.co.uk>
cc: cocci@inria.fr
In-Reply-To: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk>
Message-ID: <alpine.DEB.2.22.394.2405150758100.3404@hadrien>
References: <233b3043-2539-42f4-b47a-771b0094b558@knosof.co.uk>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1432273892-1715752804=:3404"
Subject: Re: [cocci] ChatGPT 4 and Coccinelle
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1741
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/alpine.DEB.2.22.394.2405150758100.3404%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1432273892-1715752804=:3404
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 15 May 2024, Derek M Jones wrote:

> Julia,
>
> Our LLM overlords can create Coccinelle scripts.
> We are doomed!

I agree.  The whole premise behind Coccinelle is that the intelligence and
responsability of the human behind the semantic patch will make up for the
added ability to introduce bad code on a large scale.

Nice touch with the "identifier var;" declaration...

julia


>
>
> Derek
> write a coccinelle pattern to match an if statement containing a single
> variable
>
> ChatGPT 4
>
> To create a Coccinelle semantic patch (spatch) to match an if statement in C
> code that contains a single variable, you can write a pattern that
> specifically looks for if statements and then checks if the condition inside
> the if statement consists solely of a single variable. Here’s a basic example
> of how you can define such a pattern using Coccinelle's transformation
> language:
>
> coccinelle
>
> @@
> identifier var;
> @@
>
> if (var)
>   ...
>
> Here's a brief explanation of each part of this semantic patch:
>
> 1.  @@: This symbol marks the start of a rule definition in Coccinelle.
> Everything between two @@ symbols constitutes one rule.
>
> 2.  identifier var;: This line declares a metavariable named var that stands
> for any identifier in the code. In Coccinelle, metavariables allow you to
> abstract parts of the code so that your rules can match more generally without
> hardcoding specific variable names.
>
> 3.  if (var): This line specifies the pattern to match—an if statement where
> the condition is exactly the identifier captured by var.
>
> 4.  ...: The ellipsis (...) in Coccinelle matches any code. In this context,
> it means that anything can follow the if statement, without specifying what
> must be inside the if block.
>
> This simple semantic patch will match any if statement where the condition
> consists of a single variable, regardless of what that variable is or what
> code follows within the if block.
> To Apply This Patch:
>
> You would need to save the above code to a file with a .cocci extension, for
> example, single_var_if.cocci. Then you would run the Coccinelle tool on your
> source code directory like this:
>
> bash
>
> spatch --sp-file single_var_if.cocci --dir your_source_code_directory
>
> This command will apply the single_var_if.cocci semantic patch to all the C
> files in your_source_code_directory, showing where if statements with a single
> variable condition occur.
>
> For further customization or to make more complex patterns, you can refer to
> the Coccinelle documentation or look into more examples of Coccinelle semantic
> patches which can be found in various open-source projects and documentation
> resources.
>
> --
> Derek M. Jones           Evidence-based software engineering
> blog:https://shape-of-code.com
>
--8323329-1432273892-1715752804=:3404--
