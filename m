Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DFBEB64D7
	for <cocci@archiver.kernel.org>; Fri, 16 Jun 2023 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7MNdsnXDVy1y0vhP/i5uyWzeKhJ0YUeVwCLjN/8/Nmg=;
  b=MH+fSxjB0XNysei6mJco5wZ+RrtUs2aL3757flil8z+/WH9Oow0CXgqL
   Tv18iPVh4T7tZkd1E7GRtyeF9g/4feKYwZ3SYVka4+Zse6nnpjMFAA5ru
   NrcDPYQ6McBv2wIfHuBPBid/cFKqPNHR3J1l+7VhibJ9ioWBDXH4g3+OW
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113205836"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2023 12:10:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48F9FE03AD; Fri, 16 Jun 2023 12:10:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2069CE0157
	for <cocci@sympa.inria.fr>; Fri, 16 Jun 2023 11:58:52 +0200 (CEST)
IronPort-SDR: 648c325b_hvccNGqO3clwr2mQjhKrzrW+k3yeCHCRoV/965MvSqcSANZ
 1lZsCai4ls4lmBgiZh6I0DZcC1ZAQ9MDk7I4s9A==
X-IPAS-Result: =?us-ascii?q?A0HbAwDRMIxk/z4rTJBaHgEBCxIMQIFEC4IvelAuAwcIR?=
 =?us-ascii?q?4RSiHyIWJ1vgX4PAQMBDUEBAgQBAQMEgUyDMwKFfh8GAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNgjcpAXWBCAEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEWAgheAR8BAgMjHQEBNwEPCxgCAiYCAlcGhW4DsRqBMoEBg?=
 =?us-ascii?q?ggBAQaCZppqgV8JgRUtiTqIJkKCDYRAPoREg1uCZ44tkG6BKG+BHoEifwIJA?=
 =?us-ascii?q?hFBJoEICF+BcUACDVQLC2OBHIJUAgIRKRMUBTwReR0DBwOBBRAvBwQyHwkGC?=
 =?us-ascii?q?RgYFyUGUQctJAkTFUEEg1gKgQ0/FQ4RglotNj8bVIE3NwMZKx1AAwttPTUUH?=
 =?us-ascii?q?0opgVcwgUcKJCSieIFbxmGEEoFdn3CBSoIkAZM1kjOYF6g3gWoEMoFZMxoIJ?=
 =?us-ascii?q?gqDIk8DGQ+OIIhNiyJCMTsCBwsBAQMJhUQBhgMBAQ?=
IronPort-PHdr: A9a23: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
 SzUtZhork30y4Gy
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:XjWtW6o3YgvkeW8ijnfNzs8aV5o+eYIsimQD101hICG9E/bo9f
 xG88506faZslYssQ8b+OxoUZPoKRiwmfFICOIqTNKftWfdyQiVBbAnybHLhwfBIkTFnNK0uc
 pbAsxDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3ANfKdQWot0cqqIzcEdp42/U/mUecMXkKMkX3NH3/?=
 =?us-ascii?q?mJ28qY7awE3Swo4oxxg=3D=3D?=
X-Talos-MUID: 9a23:Xj4biwllnzGsbGOwZpTodnohZfc4/oTzVXkvnMsJqpK7OC9teBOk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="58901831"
X-MGA-submission: =?us-ascii?q?MDFJ6aLhSFKhB7TP6KwKVHM63GPhC0QTM0vw1J?=
 =?us-ascii?q?4rLAU9NHXlDSK95l2heTdC7sfD1SOQ6eDgDxJCF2QTGopCEr3g6gkLMS?=
 =?us-ascii?q?9Gslw7uEIgfJd2WA2GSRwmk7359x/WhkyEW3ZczVweHR1xkgTG/zKW+C?=
 =?us-ascii?q?uHPnt2X4azTBa8kpVG9oCvIA=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([144.76.43.62])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:58:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7MNdsnXDVy1y0vhP/i5uyWzeKhJ0YUeVwCLjN/8/Nmg=;
	t=1686909531; x=1688119131; b=rKc3++N0p5h3v5lJQNMBeVxrULBMZ0x5X1W0tyKliqT1S7i
	938enNM6XiC9LHI7QJFDOe5sbQiKlCEP20WYDW8eunlHHSJwxPXCfd6lCUMaPRjpk2x+KZnWNv+dT
	m3/YqVP5nYg9JScxny8G6UCYoUCIg+IThP6gRypXB0BQXJaNWUBVxptB4K11xGhRSiKddEEauCd1M
	rDeZKHggj68G0zuH9tK91SentDGvosPPxWKTszRvR4GTj+fqpX77o8W/oWKFmSK9cvbkZt9kaLTAH
	gWCJRKzg52QBOrz51kyfppdDyVMs5lzKAARJN8kMtN95mf+mwrW1zZlLSM0nKM9Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qA6EE-008JSW-17;
	Fri, 16 Jun 2023 11:58:50 +0200
Message-ID: <905b6d0ca2b0c9947b3e7855a7d5be1827da731b.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Fri, 16 Jun 2023 11:58:49 +0200
In-Reply-To: <6b3be36a-6b1d-3e5f-ade7-443dcd6f0de@inria.fr>
References: 
	<a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
	  <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr>
	 <80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel@sipsolutions.net>
	 <6b3be36a-6b1d-3e5f-ade7-443dcd6f0de@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] macro parsing issue?
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1187
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/905b6d0ca2b0c9947b3e7855a7d5be1827da731b.camel%40sipsolutions.net>

On Fri, 2023-06-16 at 11:56 +0200, Julia Lawall wrote:
> > Still though, getting verbose output shows it's mismatching some macros=
?
>=20
> True, but that just affects the macro definitions, but not your change.
> There isn't a BAD or bad in front of any function code.  BAD or bad lines
> are not getting processed.

OK. Didn't know that was line-dependent.

I think what threw me off was the "found sync end of #define".

Either way, thanks a lot!

johannes

