Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C25C48260
	for <cocci@archiver.kernel.org>; Sat, 10 Feb 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G5DtjZg6SgbsujARD38kw/lGVJGeB7Ahxmj2oGMC6po=;
  b=UH/keJ+gZn0vSVY6X4gKPmmJbdzzusxe+b7/cNpUCXZ6B2MJNmyPK93w
   Zfyc3+rNWUvAkltR1sd3sl8Ld3s+lWAAfkYyW3BCah1ZFBW9xjEN7vaCP
   EVbN8kHJ1qCiBT3LsUEi3fB05ekuF2PzmmJWZpWyNrG1Yzuo9ltCO9seo
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151315365"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2024 15:44:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C887E0CD5; Sat, 10 Feb 2024 15:44:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CF9A0E008A
	for <cocci@sympa.inria.fr>; Sat, 10 Feb 2024 15:44:09 +0100 (CET)
IronPort-SDR: 65c78bb9_SvHFb2B0Q1OpGP8PsmVyWLWaVshkEDPgYmbVjc3rc1tRk5J
 frPMqahW/aDNjkN2mryU7EICh86n03r+ACbz1bg==
X-IPAS-Result: =?us-ascii?q?A0FYAwA8isdlhwMP49RaHgEBCxIMQIFEC4I5gVIyBAtIh?=
 =?us-ascii?q?FORaYQ7hzeHTohwgxY+DwEDAQ1BAQIEAQEDBIR/AodXAh4HAQQzBg4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcARCBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgECAgEjHQEBEScPCQIaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ8gisBAw4jB5V4nDSBMoEBggoBAQavWh8sIlaBYQmBGi6IJgGFb4Q7J?=
 =?us-ascii?q?w+BVUSBPAuCRzE+hEODW4JonjNUgQIdA4EFBFoNGxAeNxEQEw0DCG4dAhEiO?=
 =?us-ascii?q?gMFAwQyChIMCx8FVQNDBkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4A?=
 =?us-ascii?q?wMGAwoxMFVBDFADZB8YGgk8CwQMGgIbGw0kIwIsPgMREAIWAx0WBDQRCQsmA?=
 =?us-ascii?q?yoGNgISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4ggmBPQQTRAMQg?=
 =?us-ascii?q?TSFPoRvAxkrHUACAQttPTUJCxsGIgEdAqRdoluiTTQHgjSBYIFhDJ84BhMvg?=
 =?us-ascii?q?3KTPA4Gkl6YVyCoV4F5JIFcMxokgzZPAxkPjiAZhBSPR0I1OwIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 tWdzMobxx9d/tiS8cZOXqDp
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:l5gH76C7J6l8nzTlHely55DYdb4zR+YMi2TDpHoBKiC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3APJc/aWntgB5N+o5orlkCSJ08lIzXOVmHxSnwLGa?=
 =?us-ascii?q?6M31Sa7mUdXiu/aJ51MU7zg=3D=3D?=
X-Talos-MUID: 9a23:6Dm+BwWosjvo/cDq/D/81ThtKsFi2PW3GGEimLFbpO2YbTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,259,1701126000"; 
   d="scan'208";a="151315362"
X-MGA-submission: =?us-ascii?q?MDGg47AEVfPK3HtW9uBMpDb+B+OBSoE1aJU23l?=
 =?us-ascii?q?HQaXQIGoaJOqYbsGDU9gM3IfqH+LSlQxQ9pkdDXS/zh42G8UpNx/mvvW?=
 =?us-ascii?q?ZhBPYnlt77XSBlbdz5ZBRlpqAwYkNIdduU6Am0HIvuvKI/wXUKop0sFC?=
 =?us-ascii?q?cdq6dYyz6ajgP8ZuwWFm7kOQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 15:44:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707576248; x=1708181048; i=markus.elfring@web.de;
	bh=G5DtjZg6SgbsujARD38kw/lGVJGeB7Ahxmj2oGMC6po=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=dp/PJ5aZIusmlZpY/9QbYxfrRNgxD54y6EEuLH5+qzVYUZPbNtf5Ne0gibaMJizz
	 e+ujP3ziwAe6qfrmXCnpGZAGIf/GlzVK8fSm45Z+ikXVc3LGn1UI8hB8Y+SbYzMMi
	 TVSDeXLzkUEoL/iCkuVsyDMf+gOOr3mMP8QGbInaMsA1x22zgZZdY/8NvntzMF4W9
	 nR4WwrEplwjDJwX6J594a7xOORHZx39sd4PG650vuSDZOwyXPZkHQls+KnScLhg0I
	 06JFHDcqX9MPgYnwo5zlIWx1Nwg8vQqeLvGF35V5RtN05SOT6dF5Vv2ig3SKG+R/C
	 jQwNeK8xwWK4tJceKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1rZuVw2nM4-003K6p; Sat, 10
 Feb 2024 15:44:08 +0100
Message-ID: <836e2ebd-a9cf-4644-9619-2526bddae0bd@web.de>
Date: Sat, 10 Feb 2024 15:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <d4abffb5-6221-4109-9316-acb5c3720c31@web.de>
 <alpine.DEB.2.22.394.2402100936350.53569@hadrien>
 <1c2bfc73-cf2e-4949-bf60-6fc432ef67a8@web.de>
 <alpine.DEB.2.22.394.2402101124030.53569@hadrien>
 <501ef7d8-223c-4647-a302-7aeee083af14@web.de>
 <alpine.DEB.2.22.394.2402101421490.53569@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2402101421490.53569@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQrSHhv01xRhgjfyOOkE5/u95Cj2N4P/tre/0Kk2j2aEgYfgF8v
 GGzBuZmvxvs2U+t27lJC5pZJMeJY8yGKUVUfva+vRbX13lQGf4Jmmush5fxEndG/IsajBhG
 NAooTUsVe+YrbwD1EKj16r8MfOc8Y8rWh6u/2umN8ORY5urktoiVjb//WvP17uBE/utF5OP
 n5NaEq1S/6ncnYy/yTQDw==
UI-OutboundReport: notjunk:1;M01:P0:bdV23sLsGcY=;Hpm8EK20p3c1+y7F/7HzBEu5sHV
 vGGvZvE/GedY5gwkvliBbzPiz4KR2j4i8NyC+uCWK6aTCOVtiUXBE+t5FtAqotvFt4s3zVK4v
 tNHXYJJPqGPq0t44yZhZJQmj0rFwbTtsIrx24k/egYNoYM+HxAXQENn3cCaVQViwSrJNX2R2+
 Rfvo1eBz4GgUPqCVKsPZz5JuAFNfOxYu/PJ5F4lZkDzowpM0tyIJ1S7LcP0vsbJ6BBxLTPnyB
 2MH1TlkzsaiKV7ngfq2YVb/TeBkPvtWZeUl88hhplSw5AIdHs85Anxz96xSeBl0EhNZnyhkyi
 OEuQ13HIGZ5nRKL2a/VbNzjQifVgGsjr/cLvNZQCIl9H6ZwEqPrikdVnZeVcitpvgo9MQe8Kd
 8+lWchQVzh0EYXga9ncrd2wqEy1/h2Gwg3D2GxbtBYC8Kg5HDw+tXcsQug/4gy5ahzQIOi83d
 Q7wONt8C3auZRW3LYO8xumLOkHrQa/sqG5kJ7RkVSIpnu+NqJP4jGzoUetSTtRAItZ8wffZKg
 i6W/n303w6PC6tFLkWXVNRwzQgGvPZfkwirZqdIPWvUMekUBHguNIaPo09xWzhJGkigJ3zw4g
 6x3QC1SGIRnuxqOkNMKB5u2zUqmBLt6KzF5V7xIKwpHGWM0U4Rp5eHazbO1OaaEIQ1NUy88BB
 Ox9tRHw06QgUImz3u0ws5iZ6QYYk5ovrGYHv66q/t9E4nTTXX+K05Cj3WF91T1phkAvZEyFGW
 0eCMrnyn+NnaV76o6xHhOhc2wMMIckEbB05V34wIDodT0kTSKvfZ7EL+xNhb7wszWgZNGdS3B
 B4Xtwr7vESrjLpKHGrgX2Rey0Ttw5PwenD+ToydedHC4M=
Subject: Re: [cocci] Extending handling of position information for SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1538
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/836e2ebd-a9cf-4644-9619-2526bddae0bd%40web.de>

>> How would later SmPL code refer to the previous variable name without r=
epeating
>> a companion metavariable identifier?
>
> I don't understand how you plan to use something without referring to it=
.

It is described in the SmPL manual that the character =E2=80=9C@=E2=80=9D =
can connect a metavariable
with a new source code position, isn't?

If you would like to support references for already assigned/bound positio=
n metavariables,
you probably need an alternative notation for the specification of corresp=
onding identifiers.

Regards,
Markus
