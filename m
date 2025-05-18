Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927CC3ABD8
	for <cocci@archiver.kernel.org>; Sun, 18 May 2025 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GaSMumgw++l66IpepFmKI0W8Sbw7Er9WqwZ904HSLBY=;
  b=QbWeSDTpOL6cybQzknQhXN0JnphZUYVuKwEFyHKDsEHrfRyU7WI+uiiv
   XiAxEgG/47OBR5lT0lZkr2W6i8/0Tu/zSK4g7XaPuOZAXwArnOO39jW+8
   72RzOvcjs1FKAyPt28XeYrszQeDKZWTvO7C8T0gO98BBpptKmO0uytoAs
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.15,298,1739833200"; 
   d="scan'208";a="222595194"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 May 2025 10:50:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D9D76E0157; Sun, 18 May 2025 10:50:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 53F36E0131
	for <cocci@sympa.inria.fr>; Sun, 18 May 2025 10:50:41 +0200 (CEST)
IronPort-SDR: 68299f61_RmYm2eN0paOamExou6UHFtYP5trheYHFxOVr/GBjZMy6+SC
 vWqvRTxvDMREc9GuJWRgUTBLOA+6arcaezctp3A==
X-IPAS-Result: =?us-ascii?q?A0HGBAC5nilofgQP49RaHgEBCxIMQIFIC4JEfgZUMwQLS?=
 =?us-ascii?q?QiETY9Qhl+PD4h3gVWBfg8BAwENRAoBAgQBAQMEggyCLkaLTwIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg06RicdAQERJgE0AiYCcwEBgn4BgiEVAQMyB?=
 =?us-ascii?q?w0GP68ygTKBAYIMAQEGgmnXdR8sIleBZQMGgRsuhW2CSRoBBW2Id4EhD4FVR?=
 =?us-ascii?q?IEVJ4JSMYMfBIIrgw6CaYIYF4EWgUCLWYRXRYxjgU0cA1ksAVUTFwsHBYFpA?=
 =?us-ascii?q?4EPMjwyHYINhRmCD4IHh2OBI4RKK0+FIkxagnRAAgELbT03CQsbBj2XP4RoE?=
 =?us-ascii?q?yyBEYEqApM5snE0B4I4gWYFgV8MiQaBJJU4BhMvhASTRQ4Gkn+ZAYJYiy+VV?=
 =?us-ascii?q?4VZgWg6gVwzGiSDNk8DGQ9djUSEADPGfkE1AgE5AgcBCgEBAwmFRgEBiwyBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:PcEBbqnorTas5MGskfVwV0pBwWvpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQ6VxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObOEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:UAu0F2/loIa6AT+9xKCVv2caCsElVUHg92mKB1PhKFk0Yu2NF3bFrQ==
X-Talos-MUID: 9a23:f9mpzgns8sxta7PI7X/+dnoyFsNS5JqXDXoplJELg5eZFg5PEGuk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,298,1739833200"; 
   d="scan'208";a="222595191"
X-MGA-submission: =?us-ascii?q?MDGKnY19g7yXwzlKeacKggK5kv78jH65ghnVQx?=
 =?us-ascii?q?/+PhbIgl11lbFUJdcsFBf8a/PViewdCpzqWVNqrMlgEdyOD/ZTLJkRtu?=
 =?us-ascii?q?UlhzS4euwe3BkaVC/IsAY04gxfDfAIH5dfl5PZx4NKl7wWTHs9njq4QS?=
 =?us-ascii?q?R32T+7UKdFFh8a0LqbgmkF+Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 10:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747558240; x=1748163040; i=markus.elfring@web.de;
	bh=GaSMumgw++l66IpepFmKI0W8Sbw7Er9WqwZ904HSLBY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SHxKPFHFqvL8zXohbl8rrPGm+jmwXKPYOQbORjiq915+nOovNmRfVnnuT6mCJO0B
	 osZmTz2bnqBzffpvwl7biX5gjUVyv27AOeO+x4vudtSLnyM1wiqDiuU1BfloC2pw1
	 /W5NO0on6o/TSVU5sYvIReEk+4XTYZ5s2UaXRsN+Q2crIx+IIjoI6A5BhGlIdK6kQ
	 p+lk8of7VxEFuU9sKmO7QhLw7qXaR/WcnbhKcKMi+Mo9pVWrbzwtgQEW8Rm7GG3PY
	 5xtHRLJKN7PiWDJPHifa2Wztoc5lgDD2vHAdzTbFJE4+hGvOTauB5jVgGBczKuR7U
	 bILb47gATgu/nG3jxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.216]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSqTK-1uOudS20dC-00VQS7; Sun, 18
 May 2025 10:50:40 +0200
Message-ID: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
Date: Sun, 18 May 2025 10:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Olaf Hering <olaf@aepfle.de>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iqe43BQs5I4uURzo4R0dZ2IzA8H1xT5ky5QjbvxFaKTXyL4Vwx2
 FKPTRM5aRil927qY+oBpFu2YdBp7cgmw8aAD0X0VQS4imTYYZiG0C0xq+dWXR1WuDrdkTn6
 oFtAwG52YaCqBBtcKfS2PKoTVYlXh7SG4fSnTxZRaEveU1c7IERZOdkVdxUGi8gU04poTvA
 FL2r1iw5tDNHtfBT1g7UA==
UI-OutboundReport: notjunk:1;M01:P0:O5nrui+1clE=;tfzaT0kaFpVnqrg6TNosC8FmpJf
 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
 JMeKuIO0AJAfYpWMHGq32zMPa+xPxaFarP
Subject: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2737
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/55052f14-dbe4-467c-a7a4-41ce5fc1cc99%40web.de>

Hello,

I got into the mood to try another script variant out (like the following)=
 for
the semantic patch language.


// See also:
// update candidate: c4iw_rdev_open()
// https://elixir.bootlin.com/linux/v6.15-rc6/source/drivers/infiniband/hw=
/cxgb4/device.c#L908-L909
@Delete_unnecessary_checks@
expression x;
@@
 if (...
-    && x
    )
    kfree(x);


Such SmPL code does not use features according to regular expressions.
But I observed the following test result with the software combination
=E2=80=9CCoccinelle 1.3-00083-g4093aad2d=E2=80=9D on my openSUSE Tumblewee=
d system.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci delete_unnecessary_checks7.cocci
spatch: error while loading shared libraries: libpcre.so.1: cannot open sh=
ared object file: No such file or directory
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --version
spatch: error while loading shared libraries: libpcre.so.1: cannot open sh=
ared object file: No such file or directory


Under which circumstances can the corresponding software dependencies beco=
me
up-to-date again?

Regards,
Markus
