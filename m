Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A259C433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rE1Oqrv7cGf7WEphxQ4efT+6VuSadq29MN4CEhW8Z2c=;
  b=MkQfRjATLIR0uWE292aJ+EpA/frc1BQ3Lqf6MkdHKyVGTNqTnOaWVJNH
   RVDbP33XGYVfIU1Oa0ET7bxoINfTPigib3rsHTnten377ejvE381/hvNN
   0Cw7j/AXd58piF7DiEOxrFxdUJyar12WmD1vWtDSzm5UP0brRTZvqfeuS
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27064757"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 09:50:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86110E0219; Sun, 20 Mar 2022 09:50:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 912F4E0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 09:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rE1Oqrv7cGf7WEphxQ4efT+6VuSadq29MN4CEhW8Z2c=;
  b=gbABYOnRz9hqxwhsPYRjvywZHwWu9kadmyjwjL7P5JgwzInwqkNhhN72
   h5VCGAprXDNuP02ezJ3ImWRZP/5booHSk3tX+NxJ79XsPOviQA0w6aY1M
   q9H6jJfGyzymGuJatl7VoBDvpXuAreSNJ7N8nZRx79jrmFl1+ZryCdVE7
   I=;
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27064755"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 09:50:18 +0100
Date: Sun, 20 Mar 2022 09:50:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>
In-Reply-To: <ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28@web.de>
Message-ID: <alpine.DEB.2.22.394.2203200949540.2917@hadrien>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net> <alpine.DEB.2.22.394.2203190922070.3204@hadrien> <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de> <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net> <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
 <ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1943726079-1647766218=:2917"
Subject: Re: [cocci] Improved error handling for mixed SmPL data processing
 indicators
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 261
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203200949540.2917%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1943726079-1647766218=:2917
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 20 Mar 2022, Markus Elfring wrote:

> >> A friendly error like "You can't mix * and + in a single semantic patch.
> >> The patch you get would be strange" would be useful ;)
> > This has been fixed.  It resulted from a well intentioned but incorrect
> > attempt to provide file names and line numbers for this kind of problem,
> > which resulted in discarding the actual error message.
>
>
> Does the commit “don't throw away the message for a lexical parse error”
> belong to corresponding software adjustments?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/43f8e0e3c195870cb43548e5bd350aaa720f2561
>
> How do you think about to add a test case for this issue?
>
> Would you like to achieve any improvements for the software documentation?

Th documentation already says that * cannot be mixed with - and +.  What
more do you want?

julia

>
> * https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f222337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1207
>   https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L1207
>
> * https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f222337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1095
>   https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L1095
>
> Regards,
> Markus
>
>
--8323329-1943726079-1647766218=:2917--
