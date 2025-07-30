Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1AC87FCB
	for <cocci@archiver.kernel.org>; Wed, 30 Jul 2025 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=R9ImyN8r+Pwj5B0AMGaFHR81HaH+YX5sG6/XDzPdKl4=;
  b=QMOixLBRy4eK36XYWVoZQ8ifVSYdfwNhjHzgKcjdS+Fvf1Oe9dFSEkPr
   YT1Ssvhft3JXlyXdIh4wLIxKm1dcn7mLwgfnB0X+2PmsqFXOU2EJn90xL
   lZWwuu5mcacsCzFjB6aQOcUGSULGXjPBBBnHaD0cHTXAlIDjm8uEvFDQl
   8=;
X-CSE-ConnectionGUID: TiQHOWA1Q1yXtg/58la7/w==
X-CSE-MsgGUID: hAdUDG5YT0Kctb7zQmCwiQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,350,1744063200"; 
   d="scan'208";a="233618638"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jul 2025 14:10:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE493E0C55; Wed, 30 Jul 2025 14:10:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7861CE0171
	for <cocci@sympa.inria.fr>; Wed, 30 Jul 2025 14:10:25 +0200 (CEST)
X-CSE-ConnectionGUID: LjQAXG38RjKqXCQmTVj/5w==
X-CSE-MsgGUID: zytaaBssTNqM0qNHjOsgOg==
IronPort-SDR: 688a0bb0_Oo/RJi6Lx4UQNq/9Xv+cAuG2u+rQ4gt9okGiHbA2HD9gG8A
 1Y10+Dgmk5mSLPAPbZ8UZU5RVYA+CRmbwbQisNw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HEAABWCopogwsR49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgQAGVDMEC0mEVY9QgiSEO48RiHmBVYF9Ag8BAwENSgQBAgQBAQMDAYUAA?=
 =?us-ascii?q?owaAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAToHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBESYBDwsaAiYCAlYGARQBAYJ+A?=
 =?us-ascii?q?YIhAQYQAQMOJAcNBrUrgTKBAYIMAQEGgUYFDUHYRR8sIlmBZAMGgRsuAYVsg?=
 =?us-ascii?q?mQBhieDQnonD4FVRIE8gwM+gmEBA4U5gmmCJoEWg2ONBYhXUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1gXlBGT+DUx4GbQ8GgRUaS?=
 =?us-ascii?q?gICAgUCQ0WBYBlAAgELbT03CQsbBj2TP4I1gVRZmQ6OJ6FFNAeCOIFngWQMi?=
 =?us-ascii?q?i6VPQYTL4Nxk2EOBpMFmQYijWabOYFuATOBXDMaJIM2TwMZD44hGYQagQu8U?=
 =?us-ascii?q?UE1AgkxAgcLAQEDCYVGAQGLN4FLAQE?=
IronPort-PHdr: A9a23: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
 Fg6h1knCdk=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FRbHhK5ydHvHqaOpUAPXwMrXdLJyesId70hD6qkDc3Jom6uj5q
 eTdZUgpHvJYVkqMk3I9erwW5VoBEmsl6KdgrN9AV7BZmLbUQKTRelfBMnZogEIcBeQygcy78
 ddmuRFZOEZUDVB/KPH3DU=
X-Talos-CUID: 9a23:hWGOH29clyIXGTQ29zCVv2oWI+kVXSaN9nXzOn+TMGNVdr/SFEDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A6oL3bg27+Im7SK6oIX+UFtkSvjUj8bWyAUknio4?=
 =?us-ascii?q?6ndChbTVWGzW6lzuQTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,350,1744063200"; 
   d="scan'208";a="122468367"
X-MGA-submission: =?us-ascii?q?MDEtTlioZxmBNu3ALD6SPwMWvFeAc0m83GFSM5?=
 =?us-ascii?q?XGdf6zenQrSwmgh1IKUGr/1p+hG/wKDE3CgnRbHCnEYxnIJRqFakBs79?=
 =?us-ascii?q?KwRcRDoJTP4ZbHVYHk+zbwHuA112lr2E7aZvxBt3XmvX99xrOrhWMxNg?=
 =?us-ascii?q?CF+nIqrF//UZCL1eSU/4VlDw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 14:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753877423; x=1754482223; i=markus.elfring@web.de;
	bh=R9ImyN8r+Pwj5B0AMGaFHR81HaH+YX5sG6/XDzPdKl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Qeq6To5em3N4KJxYcsDi8bJyuluiDtkGt+LheXuY9fvZqvwOnTOYG7xKwlMfyPjG
	 ulTPAo7UlimMSXZNZle4e6+z5XQnUHYdOqqtCVbyH8IOLQb/Jj1/ePUAhZevbsMWG
	 TY9aMSBNCco/AfRLvZDt1xSTezoaZ2SU8c5k5Ok7ywcL0hEJJNT8UKdB+tsblEbnw
	 mLQr36vrveO3J4ZwJpguzyBag4kf6t5Q+6Tx3qWM0hZjv3cIqC2xIzVSQCU3krU/f
	 RFb0ocbOcYCqjebiPJUaG6+8pxrpiGf3H3PR++PKzqEg9gxQccFiVJW7V5fbcy8PE
	 REabotP04jVa+DzFAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.238]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1uND6M2ujL-012kRu; Wed, 30
 Jul 2025 14:10:21 +0200
Message-ID: <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
Date: Wed, 30 Jul 2025 14:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vX7DdMeWgsrzXR4jFUcoH7zcAyEunqD+l+ugSLblukFkgYwzUB2
 ciFK7LP47+ZA5NlgqXhpGRSeVsNJ6JPK9k1n4Cm6qLGuNQEuymdHVYNpkK+vP8h8+HOCZ5/
 NAkDrhFCuHbnVrD/Xnt2A1hyz3UVmHbYwYip91CGEWSWyFxdEXpzXy/zpswkk/vXuya5cY0
 qp1B/kNBldwHp139HzF3w==
UI-OutboundReport: notjunk:1;M01:P0:JvifWRf3/vQ=;3kDmGnD0xfT4Yt/c/yOht8uw1s8
 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
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2921
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/b7298dde-48c6-4e0a-87af-2046ab999ec3%40web.de>

>> I would appreciate further advices.
> I would think you should do:

Would you like to add any insights why an additional qualification
would become relevant for the first SmPL ellipsis in the discussed
source code search pattern?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/922426fe0eeb860710a34e430e065cf33e990ca4/docs/manual/cocci_syntax.tex#L1007-1014


@display@
expression x, y;
@@
*mutex_lock(x);
 ... when forall
*mutex_lock(y);
 <+...
*mutex_unlock(x);
 ...
*mutex_unlock(y);
 ...+>


Regards,
Markus
