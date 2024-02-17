Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F8C48BC3
	for <cocci@archiver.kernel.org>; Sat, 17 Feb 2024 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=IjhtnwOPlb+ZTAMeRoi1ApRlZhs+jvRUmiV+cy688Rc=;
  b=EXl4vM3KnZR/OEW3i8Xn1LPfgSz3CSZK+ThWUAan3I8ohQOygDjWki11
   hD/uDO4nN6nKzSYizAoclts4RoWTMvbgGoXC48yPQeLmICwjrRMWb/TnT
   EOw2bGzvSxXba0BQEunX8eY8hYdUWKsViLIh/Z2wv8z6Mr2JL0QscmZET
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="152440988"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2024 16:23:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5A82E0CD6; Sat, 17 Feb 2024 16:23:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 35A3EE008A
	for <cocci@sympa.inria.fr>; Sat, 17 Feb 2024 16:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IjhtnwOPlb+ZTAMeRoi1ApRlZhs+jvRUmiV+cy688Rc=;
  b=ZKgK770wzzCYMqcFWFT9P6kAXrCGMOHnOmhR8ljKzCcjM0IIVEhmE/UJ
   q0IbhYY/EB30Jw9S9i9NaYs1vRyyLp1k+BuM3OAR4JYu7vkUVwhGyQ+sb
   2deEJ8ovauOtplqj1Xcgx8mCMvUKW69a8MWjVwZ3WH1jjDDCRroPSoYVV
   A=;
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="152440987"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 16:23:49 +0100
Date: Sat, 17 Feb 2024 16:23:48 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
Message-ID: <alpine.DEB.2.22.394.2402171623280.3095@hadrien>
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de> <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-964062529-1708183429=:3095"
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1571
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/alpine.DEB.2.22.394.2402171623280.3095%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-964062529-1708183429=:3095
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 17 Feb 2024, Markus Elfring wrote:

> > I wonder then why no patch is generated by the corresponding test.
>
> The clarification can be continued for the data processing by some scripts
> of the semantic patch language also with the help of the following small
> source code example.
>
>
> // See also:
> // Fix the search for a repeated condition check with SmPL
> // 2024-02-10
> // https://github.com/coccinelle/coccinelle/issues/352
>
> int my_test_allocate_components(void)
> {
> 	int result = x_allocate();
> 	if (result != X_SUCCESS)
> 		return result;
> // placeholder
> 	if (result != X_SUCCESS)
> 		return result;
> // placeholder
> 	return X_SUCCESS;
> }
>
>
> A patch is generated by two SmPL script variants where SmPL conjunctions
> are applied together with metavariables of the type “expression” or “statement”.
>
> Thus I wonder still why no diff output is produced by the following SmPL
> script variant.
>
>
> @deletion2@
> binary operator bo;
> constant c;
> identifier var;
> @@
>  if (var bo c)
>     return var;
>  ... when != var
> -if (var bo c)
> -   return var;

Fixed incorrect handing of binary operators.  Thanks.

julia
--8323329-964062529-1708183429=:3095--
