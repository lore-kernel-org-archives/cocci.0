Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB9C02196
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TPZ2mt3E+coYaswdBEBf4GeErW+2APWp7ZEtW0/pzQY=;
  b=Kpa8Pi0F4EzeuMeRr4DpBMbHeLIkfoRNWGuILaX2dRJVgJGmG/og6yJ8
   7SYDsFk1PFl5WYWZRZsZPF6HH+7ZBf4glg588HsN7jZ24C8oBrnl4ARjn
   ZHW1N20ZaKjOWm3AQdLDFYVA06Mi65zhlBMN54GQReoFfR+LroNHf9FB/
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206881851"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 10:48:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15A36E0264; Thu,  6 Feb 2025 10:48:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E12D9E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 10:48:24 +0100 (CET)
IronPort-SDR: 67a48568_N3NeWHCrhF/+KKMFHF9BaZd0eDMsVFmj/LB3fvacftNrm51
 NbUDN/gI/h+PgI5DuDql+JtpxGxzxYdQrpeJ9AA==
X-IPAS-Result: =?us-ascii?q?A0EYDAAyhKRnhRAmd6haHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VMCAYJBfVkUIAcISIRWg0+FLYh0A54UgX4PAQMBDRQCAQIOEggBAgQBAQMBA?=
 =?us-ascii?q?4UAAosCIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAUBJhXsNSQEQAYIAO4IWLAhjAR8BAQEDIwQZAQE4DwsYAgImAgJWBoMVA?=
 =?us-ascii?q?YJkAxEGsA1/M4EBggwBAQaBCIFh2TeBZQMGgRouAYVrgmMBgWyDfgGEd0KCD?=
 =?us-ascii?q?YQ/PoEFAYMlGINbgmmCM4Fvg0CGTJwqCUl7HANZLAFVExcLBwWBKUgDgREjg?=
 =?us-ascii?q?SMFNQo3OoINaUk6Ag0CNYIefIIrgiCCOoRDhE2FW4ISgWIDAxYQAYMhehyDb?=
 =?us-ascii?q?R1AAwttPTcUG58HPYUmLCAPQnTHJoQlgWOgMIFLqQeYfI4EmyqBZzqBXDMaC?=
 =?us-ascii?q?CYKgyJPAxkPjjgCiDnDWUUyAjoCBwEKAQEDCYVEAYIviD2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:xZ6QnKiBpgtOOZFTww8DIWKvSnBQXukji2hC6mlwRA09TyX+rb
 HKoB17726XtN91YhodcL+7WZVoLUmyyXcx2+ks1NSZLW7bUQmTQb2KhLGKq1fd8m/Fh41gPM
 xbH5SWZuefMbE3t7ef3CCIV9IpxceO66ztju/Mx393JDsaDZ1d0w==
X-Talos-CUID: 9a23:XEorZWPLNj9rhu5DaSxr6ksGANofdiPT3XGTDE6hD2pmcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AtPERug5/NxijmdLUc6x4R8tsxoxy5oH3OWNciK8?=
 =?us-ascii?q?2lOfHL31wBA+FkjSOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108361887"
X-MGA-submission: =?us-ascii?q?MDEI8E1kzqVy3W8vZENEg/88yZXnv4IhWoZAY6?=
 =?us-ascii?q?RPX1o2APqDd4LHjxaOA2lPJwBg8B7OaeOEz3ADwZKgMi6Qmmy/1sTUP5?=
 =?us-ascii?q?RFcdFQxnZj78aMjyCfRToT/nmIkCQu+p4heQT/cKMWuOs9pLDq1OgzZN?=
 =?us-ascii?q?xq0BttDMO7rdn+mPIxwgsamQ=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:48:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TPZ2mt3E+coYaswdBEBf4GeErW+2APWp7ZEtW0/pzQY=;
	t=1738835304; x=1740044904; b=aRBN/hLWwKEvzgpzIY8TRBiKamGDt0y2AsOeKOx7RxWR6K0
	j70Ic3qagSPl1MQvHakh6Y80s/F4svOoKUj17LEp23k8gLPhjsL7Br8vAqQpRXdHhKPQPpqT/rpn8
	Gcs+Mzj9ntNh1ofdBQ2thIzA3nIhi3/OMOiaMxqA87AdJn/fvlm3MVQbBKlzSfjNGiRWxE3Q6HGz/
	0MTR4+gSywKuzaxOEEPLlZIz2JD8yONdRfhVRLPjUebmYeibOBlQussSnsIdsdKIhYMRESmSf926U
	cZ6DEhTYq/i/YUsZ0luj4fAVFQKiqNulz/9zRyMSqP4PEAjl7BKCUoHt5gF9TpKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfyUg-00000004xvq-31nQ
	for cocci@inria.fr;
	Thu, 06 Feb 2025 10:48:22 +0100
Message-ID: <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 10:48:22 +0100
In-Reply-To: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2352
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/061f1b6b50d305671c02742382a3df0ff95f9c6b.camel%40sipsolutions.net>

On Thu, 2025-02-06 at 10:31 +0100, Johannes Berg wrote:
>=20
> There's a second issue: we have this
> spatch:=C2=A0https://p.sipsolutions.net/765e55f2b951326c.txt
> It's not pretty, but it's intended to (again for backport reasons)
> manipulate some code in net/mac80211/cfg.c (see also [1]). We run all
> our spatches with --include-headers, and this one when running on
> net/mac80211/ieee80211_i.h, goes into some kind of infinite loop? I.e.
> just
>=20
> spatch --include-headers --in-place --sp-file /tmp/765e55f2b951326c.txt n=
et/mac80211/ieee80211_i.h
>=20
> never finishes?

I stand corrected, I wasn't patient enough. On a machine _much_ faster
than my laptop (server CPU), it finished (with warnings about
inconsistent modifications) after a bit more than 10 minutes.

johannes
