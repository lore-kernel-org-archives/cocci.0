Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD62CCFA18
	for <cocci@archiver.kernel.org>; Thu, 13 Nov 2025 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fw3dJLGknm66VsTDBEN65Agpm59k/cxIaNIoKizRAQI=;
  b=lXRxVi8vBs76mbAbUhP7wDJGKsmHOxRJ64mW0/ZlbMxrXW2pn1RFLVap
   SeCOBeI+f9dZcLVeJTjM34e8G8EZgKunuKj9VFbWG4yxvUz7hyzhzOjwL
   GgwCvxwErfxMsXfJlnEQb70SvK86ZiEvGETLq9RYetV6iTwZv6fHpanq5
   E=;
X-CSE-ConnectionGUID: XtW8QpthQg6Fo8ePKTv5bg==
X-CSE-MsgGUID: 8mgSXCWfQSawn1/KqT4qhg==
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
X-IronPort-AV: E=Sophos;i="6.19,301,1754949600"; 
   d="scan'208";a="248878033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2025 08:05:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 27C78E0264; Thu, 13 Nov 2025 08:05:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0D3E4E0172
	for <cocci@sympa.inria.fr>; Thu, 13 Nov 2025 08:05:54 +0100 (CET)
X-CSE-ConnectionGUID: +CW6HCIKSmejQE+Mu71Ilg==
X-CSE-MsgGUID: bhpxHJb6Re2NFX+EzNKRwA==
IronPort-SDR: 69158351_Y7IkEFhtrCiuchgIQ2sRxnrb9l7751EhoczMFADSBSwda2t
 T2IPv4uNrZm4Dt+6TX8bFjQwhkMzWMSpfLjiMLA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FpAAAgghVpeAQP49RaHQEBAQEJARIBBQUBQIE8CAELA?=
 =?us-ascii?q?YI/gQIGWDMEC0kIhE2IHIc3giSEO48RiHmBVYF9Ag8BAwENSgQBAgQBAQMDA?=
 =?us-ascii?q?YUAAoxbAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAFDDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+A?=
 =?us-ascii?q?YIiAQYQAQMPJwcNBrE4gTKBAYIMAQEGgVhBUNd2HywiWYFkAwaBHC4BhW2CZ?=
 =?us-ascii?q?QGGKYQ9Jw+BVUSBPAuCRzE+gmEBA4Feg1uCaYImgQ6KTYYtBohgUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwMqNC0jSwUtHYEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQ?=
 =?us-ascii?q?DqBaCIGHBICAwECAjpXDYF3AgIEghx+ggoPiU6BBwIBC209NwkLGwY9lRKDX?=
 =?us-ascii?q?Vkvgg6jQqJ7NAeCOIFngWQMii6VPgYTL4Nxk2EOBpMFmQYijWabOYFoOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiGEM4ELwgJCNQIJMQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 xkrlk1hbO5r+Dq+uz/fw3LVqSF2nERjwb3Y
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:YpfQYa3rW94od0vKeM8f8AqjBIAkLtp133Aq2lEZdPU1SL3hqy
 nKpp4mPHDP+VAssR0b6LK90cq7MArhHPxOkO4s1N6ZNWGMyQiVxelZjbcKqAeQfxEWmNQtsJ
 tIQuxRDJnfAzFB4voSIzPVLz/j+rS6GWyT69s2Bk0NcT1X
X-Talos-CUID: 9a23:/ZsucGzr4BZacYxt27RABgVXMf97Ulb870zVLk2BJCVMVeLMaFufrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AIdE2rAwgzyggCg3wzdWNq1VIsmeaqK6uEFAts59?=
 =?us-ascii?q?YgcTeEwJAeBqPqheNXaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,301,1754949600"; 
   d="scan'208";a="248878027"
X-MGA-submission: =?us-ascii?q?MDHDPXdzFKd94d5B4jchCpjLKuXE8MqE69+1TW?=
 =?us-ascii?q?p8EzvogdbT64E0RoXQeXqVr7JqYxVb7ojEhodEfQsdIcmA7mf1Y8mZOS?=
 =?us-ascii?q?YfvG0suy4hDPIU4QZsq9I7rgfDSsYnPZXsm1GESPKHzo20/73CNZs6sm?=
 =?us-ascii?q?Xkaf0e97lZ7kH1DB3fKkon8g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:05:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763017553; x=1763622353; i=markus.elfring@web.de;
	bh=fw3dJLGknm66VsTDBEN65Agpm59k/cxIaNIoKizRAQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UW942M0uOtrJGgGWJPdfaDbeWtgIwuQu0812+wSSjnv0cP0dgNRbUwgLlLSGNzxS
	 wZTFd1/02gHgtneHK1vjfRkpAkkJN+5RtUmaU3swXb8g5+wK4opVfYt7XnCXU5wyo
	 UuIIz7oZGsHTJFzE5W228lsIiYyHJ1d29Hd4EVcQlK4UrOKd90cA3u2rZsgBRkWaR
	 lmADTslrT1CdkxNYJCdfpTl0QxgJE8ZNR14ihI39bwnKOXw7DohdUCxwhv5DqakoQ
	 X1nERjBiitiRcTUoJ9HPsJH7IwUA+z3TWMhrYG/GjwUgExlbzObd0u7I29TP1IPEi
	 iiYepf5DPwSjgmItFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1vEViY3VuY-00C4SE; Thu, 13
 Nov 2025 08:05:52 +0100
Message-ID: <205e1503-d79f-4580-b496-67d16df26c51@web.de>
Date: Thu, 13 Nov 2025 08:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
 <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/EoORMH1RsOb3auaqPMjjoz4JB5ry7Or3p1tn+RH1toV1xp6GF2
 PzmN6PAW+1XY/mjc3AqwSGEo9P2b/3DqTBxYKyKtYYT7uebE94Gx083oN/rcs6j1OaOo9wA
 5UGL3tHyM9cyt0UZTYzys5YYLftvQmgj4RA1XrWyw/+8yhNEBP7wE/0hpM76hpY2ksKHpPM
 HtVcAYz+kIJLMG/znH+kw==
UI-OutboundReport: notjunk:1;M01:P0:ezGO+fBs6NA=;ucDI4z4DFw0/YgmTcRau+7Xz/GA
 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
 KJ12Du0JGzzaaCXaM+HuVDfrsE/AT6KM4CBH3B
Subject: Re: [cocci] Improving support for casts in SmPL code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3171
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/205e1503-d79f-4580-b496-67d16df26c51%40web.de>

> Coccinelle doesn't know these types.  You have to declare them with type=
def.

A description approach is available in the SmPL manual.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L456-466

I find this information source unclear in the way for pointing a possible =
property
out for metavariables of the kind =E2=80=9Ctype definition=E2=80=9D.
Do they refer to a fixed type name?

Regards,
Markus
