Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3293C54E58
	for <cocci@archiver.kernel.org>; Mon, 25 Mar 2024 10:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2UNMPqB9RUgQeTFDf2pHFGFaMyE85wFqvsTR7H8ZdgE=;
  b=Orcabfz3JG2xeGFJyxg8defg067yzgZGx08+3NNDfrxC4AYbFvTCpM2/
   8QBEusiqN99+iX5/1iRbugHYUt6ylKHTFO4HBpnBFrwxiW5Y8pTefHVfs
   wxVDutN3m37iJAfUvtT5PRt7nc71TlJ+cwJSTDMPRmNcZY/Ksm/nJb7xD
   I=;
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
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="158273006"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2024 11:18:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BEFDE0147; Mon, 25 Mar 2024 11:18:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 621C2E0145
	for <cocci@sympa.inria.fr>; Mon, 25 Mar 2024 11:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2UNMPqB9RUgQeTFDf2pHFGFaMyE85wFqvsTR7H8ZdgE=;
  b=n/X/2hTSPi/20eOiR7aaV2S5LAa/nWoQQsLo3xhyOMe6KQvY5yPU0oQG
   dM8voQqE5PDsA5CT/gzQTgWSxTQDzTuJaZNoWcS0qW4cbBUAIKMIEvx6a
   MMmp/ySHNg0haKvOkCypZetqXPPWx9JHs9arosHnL8ISxUJfXnB1WjvZk
   A=;
X-IronPort-AV: E=Sophos;i="6.07,152,1708383600"; 
   d="scan'208";a="158273005"
Received: from guest-pool2-19-019.guest.nat.upenn.edu (HELO hnt-440.eduroam.wlan.private.upenn.edu) ([128.91.19.25])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:18:16 +0100
Date: Mon, 25 Mar 2024 06:18:15 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de>
Message-ID: <9f199353-3997-858-3858-893848adbf9d@inria.fr>
References: <d5250894-dab4-4729-8165-a9b70844c8d4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Improving support for argument lists with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1616
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-03/9f199353-3997-858-3858-893848adbf9d%40inria.fr>



On Mon, 25 Mar 2024, Markus Elfring wrote:

> Hello,
>
> I got the impression that there are opportunities to improve the support for
> argument lists at some places.
>
> Identifiers can occasionally be followed by parentheses in the source code.
> Such a code combination can be interpreted in different ways.
>
> * Function call
>
> * Macro call
>
>   See also:
>   Improve support for handling arguments of function-like macros
>   2024-03-14
>   https://github.com/coccinelle/coccinelle/issues/362
>
>   Compiler-specific extensions can be provided also as macros.
>   The specification of attributes with arguments is a corresponding application area,
>   isn't it?
>   https://en.cppreference.com/w/c/language/attributes
>
>   https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L461
>   https://github.com/coccinelle/coccinelle/blob/0011af1760e37caada1f9d48e2c549bd519bf203/docs/manual/cocci_syntax.tex#L461

If you have a specific question, please say what it is, and don't expect
that I wuill try to infer it from a collection of links.

julia
