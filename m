Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D68ACAC582
	for <cocci@archiver.kernel.org>; Fri, 12 Sep 2025 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kx2FDA+wcnK1OiiOi4WKzOSUe7zy5X7yOsq+W1u7byg=;
  b=nJwAy2qDbC7Rp0UnpO/fmCZ0dik99EpLate4aD0t68ozY/Dm/tPouyVy
   4RJltLihmKcbHi66lGQCCPQAzOGbBJd5WmduRSTyba/SfQ6H3rG6PVB8D
   AUav/bqRwsj33aaQkbSpZaBwa9oHDrgrPJ9d3lVzWWazGxZiyIuQGlBoq
   E=;
X-CSE-ConnectionGUID: EpyPrj2ITu+otuPZ0Kg8Rg==
X-CSE-MsgGUID: sGPZNm/hQYyXRXn9M/2UiA==
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
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="238841224"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Sep 2025 17:43:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 458F8E0172; Fri, 12 Sep 2025 17:43:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC963E0171
	for <cocci@sympa.inria.fr>; Fri, 12 Sep 2025 17:43:20 +0200 (CEST)
X-CSE-ConnectionGUID: sEY2TqTgSh+C4YRrXlcXnQ==
X-CSE-MsgGUID: 9ZioAGQTScqn4nDlsOcNbA==
IronPort-SDR: 68c43f98_jH+IIjQhWR/VKqei6m2nfHMzndPPLxecDjYescdPXGvb3Hg
 rkDqS/hGekQACrGv4QS8dFakM0z8iNfcfvkhgjQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EgAADhPsRogA4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQIGVDMEC0kIhE2IHIc0giSEO48RiHmBVYF9Ag8BA?=
 =?us-ascii?q?wENRAoBAgQBAQMEOIFUgnQCjDACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEXAg06RAEBAQIBIwQZAQERJwQLCxoCJgICVgYBFAEBgn4BgiIBB?=
 =?us-ascii?q?hABAw8mBw0GsVR/M4EBggwBAQbaXx8sIlmBZAMGgRsuAYVrgmQBhieEPCcPg?=
 =?us-ascii?q?VVEgRUnC4EJgT4xPoJhBIFeg1uCaYImgRaDWIxZgnaIYFJ4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIEMDKjQxI0sFLR2BJ3mDB4ENhB4rT4IccoF0PhlBg1MeBmsPBoEVGUkCA?=
 =?us-ascii?q?gIFAkM+gWsiBh8SAgMBAgI6VxCBfAICBH9AAgELbT03CQsbBj2WCYRqgkgyx?=
 =?us-ascii?q?gA0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQYijWaVc4VGgWg6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIYQAM7hyQTUCATkCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:c0vICKMSCSJoucBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:iNHtpWHsO0lC9UZvqmJ82X9OJtkZfUbdj1yMEnWiOWJieLusHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AGz2uww+go4jABHv9foKjeSyQf5Za4qOHJ3kxqp4?=
 =?us-ascii?q?fvZWCGShrHDy7hh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,259,1751234400"; 
   d="scan'208";a="125369446"
X-MGA-submission: =?us-ascii?q?MDGdSa/YlQW8coYVAV2Z9MCZfaCS432slzsTzn?=
 =?us-ascii?q?BFUIwE7clD0tuK8SMdlR+sfZ54A/qBlwpf5uc2qB0Vhx+MD6XKqeuX3h?=
 =?us-ascii?q?xI2EY/8vQQNaYypowuKB5Lriiogf5KOOxt8MC/DtfoDOCdrwZVCcy+1e?=
 =?us-ascii?q?1lDED/O9JDWgVy7zCA+5kRqQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 17:43:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757691799; x=1758296599; i=markus.elfring@web.de;
	bh=kx2FDA+wcnK1OiiOi4WKzOSUe7zy5X7yOsq+W1u7byg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gxpcw5Ir8vVx5syWG9GxR0GQqH10ElK0cKJK2d8qMb9BC8HjkN+9FD7pIGIXnO43
	 f0VNbET9brrnbyq6IENsRqrdz3jVQ4n9Lo5UcK7cvd+jtncudRXqSypXjQmbLrUwq
	 qkTp8+DmmA1PObgTQAioaBAC0RcKiDJX9XQ4eLNjmKO0gcHAp7nou+TjtnF4wy6IA
	 IFrTuicQAiOM/jzStFnnMWFQmXzGf89mjiZJ30z5nqU4PQLtanI7ZXbmfIx7nTjId
	 D+dbkwaLdIB/hb9gY59ffHM17CArb4iZmeVmobnGOvIomEIcSgfPt+stfXX5UC8Jq
	 eRbmcHy8ClCnkfgT5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nii-1v2Z2Y40c8-00H36r; Fri, 12
 Sep 2025 17:43:18 +0200
Message-ID: <b6db688b-5e14-4310-9003-d3040e3fbe2d@web.de>
Date: Fri, 12 Sep 2025 17:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1bfe79b9-f7a4-c20-f116-75d9fe1642b2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gmSyyo6nGmBOBltjVF/mW5P6dRf/a/iCZY5q0N2tlHXPjoGBAFw
 L5bGDD7zNFtkgnnUpCoktgLikahexc55aZsTZtmqcknzmWR+DpuI/nZFmPAvVkbkHreLc0E
 zBxzZhuLNHho3EwPToqUuBPq1EdwKKndUCVXfWOsrY7ORu3KeOLjBAatPRs5wyornmnRH1L
 zrKGMmEj1xF6vJ1yYBdbQ==
UI-OutboundReport: notjunk:1;M01:P0:5X9chcFITWo=;H9nUrI0p/PRo6k+3LQAintWILFP
 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
Subject: Re: [cocci] Searching for missing cleanup function calls (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3017
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b6db688b-5e14-4310-9003-d3040e3fbe2d%40web.de>

> But if there are cases where dn really should be freed, that could be
> something to write a patch for.

SmPL script repetition for your convenience:
@display@
expression e;
statement s;
struct device_node * dn;
@@
*dn =3D e(...);
 if (!dn)
    s
 ... when !=3D dn


I would like to clarify further software development consequences also acc=
ording to
a diff output (like the following) for a smaller function implementation.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_missing_of_node_put.coc=
ci drivers/gpio/gpiolib-of.c
=E2=80=A6
@@ -1252,7 +1252,6 @@ int of_gpiochip_add(struct gpio_chip *ch
        struct device_node *np;
        int ret;
=20
-       np =3D dev_of_node(&chip->gpiodev->dev);
        if (!np)
                return 0;
=20

real    0m0,491s
user    0m0,455s
sys     0m0,037s


I wonder once more why this source code place is presented
despite of the expectation that the shown SMPL code exclusion specificatio=
n
should result into a corresponding effect because of the used statement =
=E2=80=9Cof_node_get(np);=E2=80=9D.
https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/gpio/gpiolib-of.=
c#L1250-L1284

Will development ideas evolve according to another questionable test resul=
t?

Regards,
Markus
