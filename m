Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C35C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 16:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OKOOocGOd7AWllOsBVjHI/ZVfeO3uqy+Vk/EDmJpFwQ=;
  b=ZYNN0AFJCOYO16TmCLgtU0nRlgpJPlSmCrRujVPHAUvhiGTXtgRvjsma
   Zkmin4nWCkivt1DFnZDVG3y25Nsrxv2rPhn0OVWg9sDc9Qyid37DwqDGo
   8+AtUpx4iPqRD3/mRwYxBRsu/lR6/W/gW3uLquM9TM/E+TTzTBuI5Fjgf
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99566098"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 18:05:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 36FD8E0D45; Tue, 28 Mar 2023 18:05:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA7F6E0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 18:05:43 +0200 (CEST)
IronPort-SDR: 64231057_Q73BrytH1QAXGzHZzLX62n+87TWLhZisydo/VggAMRISAO1
 nIz1ogkJXQp3vqsppfWCUWOcTJGqJ5UGRkUYIRA==
X-IPAS-Result: =?us-ascii?q?A0HYAABwDyNkmBzch8NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFKMAQLRoRTkQEuA4ETgxyXT4NUDwEDAQ1EBAEBBAOCC4JzAoU5Ah0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQEBAQEBF?=
 =?us-ascii?q?QkZBRAOBSKFaA2CNykBgXwsDVJ3AQEBAQIBIw8BDQEBOAQLCxgCAiYCAlcGA?=
 =?us-ascii?q?QwIAQGCeoI6IweuRnqBMoEBgggBAQadLR2BXgmBFC2HSB5YhEeDNnonG4FJR?=
 =?us-ascii?q?IEVJwyCQDc+hC4rg0OCZ4EMgR2HVYQhiy+BNHOBIA6BPYEEAgkCEWuBEghrg?=
 =?us-ascii?q?XxAAg1kCw5xgUoCZExfQSUEDgMZKx1AAgELdT81BgMLIAZYawIJIxETBQMLF?=
 =?us-ascii?q?SpHBAg5Bhs0EQIIDxIPBiZEDkI3NBMGgQYLDhEDUIFHBC+BWgoGS51TAXoUc?=
 =?us-ascii?q?VpdUZJUkkCeQoQEhDqcNwYPBC6XCA6SKZdqIKI4hUKBeiOBXDMaCDCDIk8DG?=
 =?us-ascii?q?Q+OIBmEAY9TQjE7AgcBCgEBAwmIa4JYAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MSO6NqzT88M76GqE28CcKrPwFb1zdoMgy1knxilNoG9uA6mlfq
 eV7Y8mPH7P+U4ssRQb87290ca7IE80maQFh7X5eI3SJTUO21HJEGgB1+XfKlTbckWUmoFgPO
 VbAs9D4bbLfDpHZKjBkW2F+pobsbq6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="51511049"
X-MGA-submission: =?us-ascii?q?MDH4wvBQxN3nF3nwDby6gfGhxgKKpQu3TOL9wU?=
 =?us-ascii?q?xUKMdcIZZPLsrnrhRpw/zIrmwdF/weWlAKoiiikt4eHNPtL9qTKkSwVN?=
 =?us-ascii?q?HHA2mapHZHbJFGIBkwAPLOieTVulc/d0Mvgis/2MeneUbufKSLtQ3bkU?=
 =?us-ascii?q?1biR8y74bIpzeXy0i10xIUgg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:05:44 +0200
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2844B21A09;
	Tue, 28 Mar 2023 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1680019542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKOOocGOd7AWllOsBVjHI/ZVfeO3uqy+Vk/EDmJpFwQ=;
	b=LGkiHQPJn1sutNLT89SqgtBJJFQU+hisWQV2b3R9NFWrVHY9h3tDY8K57NHr0BkonRjFT6
	WEvR3aAv3v6uD5WiKDCjwt6fz7FHwvRlrO6TCD8uX9KI9YLxgY8KcMK2Y5rilPoxX1Gu4H
	BFVssSaQe+C/C8trfSWIxvcleBeE2ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1680019542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKOOocGOd7AWllOsBVjHI/ZVfeO3uqy+Vk/EDmJpFwQ=;
	b=q92Gq+wjQHBf1ColWL71T694h0oi/jXyYRTWKHHU2C6of8vVz6wISU5CRpLk0wvfsbfm5O
	xv6WYXkNa4QD+SCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16B6D1390B;
	Tue, 28 Mar 2023 16:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id baLaBFYQI2SpMAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 28 Mar 2023 16:05:42 +0000
Message-ID: <4a7d08d1-7328-047c-52f3-dc62755cdbaf@suse.cz>
Date: Tue, 28 Mar 2023 18:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Reconsidering kfree() calls for null pointers (with
 SmPL)
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 970
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/4a7d08d1-7328-047c-52f3-dc62755cdbaf%40suse.cz>

On 3/28/23 17:55, Markus Elfring wrote:
> Hello,
> 
> I tried the following SmPL script out also on the source files from
> the software “Linux next-20230324”.
> 
> @display@
> expression call, storage;
> identifier target;
> @@
> *storage = call(...);
> *if (!storage)
>     goto target;
>  ...
> *target:
> *kfree(storage)
> 
> 
> 119 source files were found where a check was performed for a failed function call
> and a kfree() call is immediately performed for the same variable.
> Thus a null pointer is probably passed at these source code places.

It is valid to pass a NULL pointer to kfree(), it checks for that.

> I imagine that such code should be reconsidered once more and improved accordingly.

The only potential downside in the scenario is checking storage == NULL
twice. But this is an error handling path, not a fast path. On the other
hand, the code may look like this:

storage = call(...);
if (!storage)
    goto target;

if (some_other_condition)
    goto target;

target:
kfree(storage)


For some_other_condition, we want the kfree(). If you changed the code, to
remove the extra NULL pointer check, you would have:

storage = call(...);
if (!storage)
    goto target1;

if (some_other_condition)
    goto target2;

target2:
kfree(storage)
target1:

The extra goto label and larger code is not worth saving the NULL pointer
check, because this is error handling path.

> How do you think about to achieve any adjustments in this design direction?

Only in cases where it would not make the code more complex, i.e. if there
are no "some_other_condition" that jumps to the same target after allocation
to storage is successful.

Vlastimil

> Regards,
> Markus

