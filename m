Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A08ECAAA1
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 19:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=prKOQJXhkBSGD5xNcfAL6Hwm8+zlxlsUNr7zQMQKJcc=;
  b=RI+hNz2jMpI1U56TVDAo6bGv13KhrYbltoQQjmAfHfBQiMtUh2KdzgZ9
   /PP2HNdYjNHFrxj8djQX5kNcTYdAY2PMUpK+bm9YZYBC2NLMmxJEIVXqH
   JpP3lENW2HKa2ABQYlTVf0SJmq9V9UDtS90LJXMzPN3rGFCG567kVQUaT
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@zx2c4.com
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941824"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 21:43:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8F75E0152; Sun, 23 Oct 2022 21:43:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B325E004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 21:37:08 +0200 (CEST)
IronPort-SDR: 635597e3_4H3gXsmCqG/BI5lFD84/03dsXxm7kfes9D+1yjTzgDkeKUv
 6mRdGzwdaNHHejOLStoXEYMJqzw4uLUpXmHTdag==
X-IPAS-Result: =?us-ascii?q?A0D2AwCWllVjkEtEKJFaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBAVYuBAtFA4RLiH6HeyFpllINh2EBAwENFAIjCwQBAYUFhHMCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQEBARYJHh4FIoVoD?=
 =?us-ascii?q?YI1KQGDZAEFIw8BDQEBNwEPCxgCAiYCAhA8CwYTgn0BgyAGAQyrO4EygQGCC?=
 =?us-ascii?q?AEBBoFAAYUsfgMGgREqAgEBi3yDY3ongimEPz6CS4FlKYNCgmaVVjgDRB1AA?=
 =?us-ascii?q?ws7Mg1RHFgOCR8cDhcNBQYSAyBuBUEPKC9nKxwbB4EMKigVAwQEAwIGEwMiA?=
 =?us-ascii?q?g0pMRQEKRMPLQcjcQkCAyFlBQMDBCgsAwkhHwclJDwHWDoBBAMCECI8BgMJA?=
 =?us-ascii?q?wIkV4EkJgUDDRclCAVOBAg6AgUGUhICChEDEg8GJ0cOSj45FgYnRAE0Dw4WA?=
 =?us-ascii?q?2OXAoIRgUGVCK97BwODYoNOh3eVAjKDZJMGkicthTqBWY9hjUGaMzWBRCOBW?=
 =?us-ascii?q?3CDNxIBOxwPkhKFFIVMPzQCATgCBgEKAQEDCQGBVokHAQE?=
IronPort-PHdr: A9a23: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
 BMyzAxkbrZ1nAo=
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:atJG8KEhU7xAt7lppLqE1ceALOsnbusQ8zAXPiBKJCC9vPbo9P
 xGuM5rrCMc7wxhIE3I+OrwXpVoJEmxyXcb2+cs1NuZPTUO/VHYV72KjrGSpAEIeReOk9K1vJ
 0IG8MVZ+EYT2IK6foSizPIcerIruPmzJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67941544"
X-MGA-submission: =?us-ascii?q?MDGeri1X4PzARTZ93ht0n0oBY/DerLn6tsWzjq?=
 =?us-ascii?q?pJtLOpQEefoBUElgxpkQYcx3iNdGDlLeKfsQG7jcRbwbm7IllVMu6NN+?=
 =?us-ascii?q?N6bGJ5pNMnbKews1kZnK8tExy6M7Duv6yliZfFvMEWCXiJRZZj+duoS4?=
 =?us-ascii?q?K9RuQtxCyWNFDShl494Gy9sQ=3D=3D?=
Received: from ams.source.kernel.org ([145.40.68.75])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 21:37:07 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 22098B80D96;
	Sun, 23 Oct 2022 19:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CD1C433C1;
	Sun, 23 Oct 2022 19:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1666553823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prKOQJXhkBSGD5xNcfAL6Hwm8+zlxlsUNr7zQMQKJcc=;
	b=Wi54c08lAMHC6vIMZXiSMnTnSJeDnj1SZaLqUd5Hv5IAr2aB+y4V91LoVIYi19/ZjnILBs
	T/23U+kDqOS4ctyCY5OfV4cRQFHWJBwDDIzN+ttafM0t7WH/i+0Z3F5zqm01KRVbDV0Iq5
	lJ7+GLhVy0PzIxvekFl8RdoAx1mKxOc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a041691f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 23 Oct 2022 19:37:03 +0000 (UTC)
Date: Sun, 23 Oct 2022 21:37:00 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Message-ID: <Y1WX3FNT1xiQfSgD@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-38dbc083-0911-4042-984d-ad608cefb8da-1666523912279@3c-app-webde-bap48>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-38dbc083-0911-4042-984d-ad608cefb8da-1666523912279@3c-app-webde-bap48>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Checking the replacement =?UTF-8?Q?=E2=80=9Cget=5Fran?=
 =?UTF-8?Q?dom=5Fu32=5Fabove=280=29=E2=80=9D?=
Reply-To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-Loop: cocci@inria.fr
X-Sequence: 675
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/Y1WX3FNT1xiQfSgD%40zx2c4.com>

On Sun, Oct 23, 2022 at 01:18:32PM +0200, Markus Elfring wrote:
> > I just sent these in:
> > https://lore.kernel.org/lkml/20221022014403.3881893-5-Jason@zx2c4.com/
> 
> I find the following code details also suspicious from two SmPL rules.
> 
> …
> -   } while (!I);
> +   I = get_random_u32_above(0);
> …
> -   } while (I == 0);
> +   I = get_random_u32_above(0);
> …
> 
> 
> * Should such case distinctions be reconsidered?
> 
> * Can different function parameters become relevant here?

* Can you be more specific?

I have no idea what you're getting at.

Jason
