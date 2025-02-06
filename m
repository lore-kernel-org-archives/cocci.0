Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F713C02196
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6g3VmO/Z+REj+uBV9X1YozVFeI/WXmssyE4lF/hN7rI=;
  b=nnImyfyVMID8D7rz9o74CJGv+XOFTLfDEEl3vOB4bmHtb8kIFL/Pn2Zr
   BZOJaAbXFeHDTOkAHg989L+dyL4u1yQoIkmELakxSe4LvCFusn+F7kRUV
   q3NybHUPo3dkHPncvIZjc+kjMvDwEngQ47tsKpnSCNXIZVAoDMnxjpSb3
   0=;
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
   d="scan'208";a="206890186"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 11:17:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4262E0261; Thu,  6 Feb 2025 11:17:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 586EAE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 11:17:36 +0100 (CET)
IronPort-SDR: 67a48c3f_+HYP75rmnHB/53IuYxyD4qg9KUvS6I5lafj8ywdU8x3D2Az
 Yl1bZijx2vgFfsNiHketYXIRcffVJLiXjOeyHvA==
X-IPAS-Result: =?us-ascii?q?A0GpAQBci6RnhRAmd6hagQmBU4JEgVY0BwhIhFaIfIh3n?=
 =?us-ascii?q?hSBfg8BAwENQQECBAEBAwEDhQACiwIgBgEEMgcOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBQEmFew2CYgEzghYsCGMBHwEBAQMjBBkBA?=
 =?us-ascii?q?TcBDwsYAgImAgJWBoMVgmUDsB9/M4EBggwBAQaCadk3gWUJgRouhWyCYwGBb?=
 =?us-ascii?q?IN+AYR3QoINgRWDKj6BBQGHGIJpgjNKgSWDQIZMgx+Ib5AcCUl7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBKUgDgREjgSMFNQo3OoINaUk6Ag0CNYIefIIrgiCCOoRDhE2FW4ISg?=
 =?us-ascii?q?WIDAxYQAYMhehyDbR1AAwttPTcUG59EhBmDNrF9lRGEJYFjoDCBS4IlpmKYf?=
 =?us-ascii?q?KkugW4CMYFcMxoIJgqDIk8DGQ+OOAKIOcNfRTI8AgcLAQEDCYVEAYpsgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z87q6ZhLYxbNrz/dJbFY+4UvJI=
IronPort-HdrOrdr: A9a23:GDveW64gQwK4JWtnzwPXwOHXdLJyesId70hD6qm+c31om6uj5q
 STdZUgpHrJYVMqM03I9urhBEDtexzhHNtOkOos1NSZLW/bUQmTQb2KhLGKq1fd8m/Fh4xgPM
 xbH5SWZuefMbE3t7ec3CCIV9IpxceO66ztju/Mx393JDsaEp1d0w==
X-Talos-CUID: 9a23:NJpkM29c1OiBZMSo+HyVv3M+BuEeY2T58CzBJ069AmBSSraKalDFrQ==
X-Talos-MUID: 9a23:cJjCYwkW8Fg/QC/sV4Sidno+Pv5F26CqLXtRsqQX4cOqJCMuIHSk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108366626"
X-MGA-submission: =?us-ascii?q?MDGMXe9gxufJY2bNT0DjKi5kHryJGmmxVXk+y9?=
 =?us-ascii?q?namP5zp9D6bVAzchUVsNHUcyh7zIOwi0sNx6HJOGAFkyaeBAD+CSiBzP?=
 =?us-ascii?q?pdMsuD9BDuHWHgutYaMJP2+zG2pNGceDpEvJ3EOYhkiB/+dvDo3f0CG0?=
 =?us-ascii?q?PvSWqhAUEkI9Z7toHEw0S5Qw=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:17:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6g3VmO/Z+REj+uBV9X1YozVFeI/WXmssyE4lF/hN7rI=;
	t=1738837055; x=1740046655; b=spoPHTMOUR94MvqMbU7Xe1V9IYgybixbV90Izzjqg/9xFk1
	BYa2IEqCnHLQ167htQH2Z/A+JCEkqvvo/aJsy/cgnz38HdjP+BW5bfBef/noiAiIYaZcRn8bNtTpZ
	fBTClGs419XZXtAibXs3jkRAHyIJRl2tUrpqYRRK0JbgmcWnoOgoLhAzVrVO96aNAt8k6W8QQCgaa
	8IFTpF6cJqsmAOyjV5bkgYwbVOah14ddejn2RCCc8jW6vuCmk3RheOcXjqs1QL4Qhs/7RuqYF/UbN
	SURFXgv+xk+0ucwZ4oBH3NQXc7eqHTh1a8y5a/Qqqf5e8EbdAF4USjUe7XveV8uQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfywv-00000004z19-384G;
	Thu, 06 Feb 2025 11:17:33 +0100
Message-ID: <708c689f63c3df2bca99282996fc2812f8557f1a.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 11:17:31 +0100
In-Reply-To: <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
	  <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
	  <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
	 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
	 <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2359
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/708c689f63c3df2bca99282996fc2812f8557f1a.camel%40sipsolutions.net>

On Thu, 2025-02-06 at 11:13 +0100, Julia Lawall wrote:
>=20
> If You just want to remove all tests on rnr_elems, it will probably be
> much faster to do:
>=20
>  @@
>  @@
>  static inline int
>  ieee80211_get_mbssid_beacon_len(...)
>  {
>  <...
>  -if (rnr_elems) {...}
>  ...>
>  }
>=20

Right. I don't even care about <+ or < because we check the resulting
output anyway :)

Thanks!

Now maybe I can also figure out something why the TDLS thing doesn't
match, but so far hitting a wall on it :)

johannes
