Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FACC4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MfDD/I/RaB9Tdel7aX4cpVPVUm9D0JpclEnPCpvlnpY=;
  b=rFlZXTW3Bs3S+qi+kIYzqsrzPz95JGfdbQhu6IQbQefUcSSDYOLC3uoS
   p2g1wOJflgcySwIEQWcBU7rvfFK3rnLoQuEAoX9gC6Nn+/ja7fB6uepCH
   L2NxDvyPRXGjcQ4S75Kmx1dsWyWdO4k2Rp7Y/R2i9RmROwfcwMzOYgtfS
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164198889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 12:18:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9F3BDE0133; Thu,  2 May 2024 12:18:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 55A1EE0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 12:18:34 +0200 (CEST)
IronPort-SDR: 6633687a_UPCYKVFOCjpDwlmTweHspfScTW8z09OseZUkpHcbJElQpWP
 1aD97hgRvf3KMJI05yQMv8hNzJgyFlxwt8f78cg==
X-IPAS-Result: =?us-ascii?q?A0GLBQDbZjNmhw4P49RaHgEBCxIMQIQTgVMzBAtIhFaPR?=
 =?us-ascii?q?oF1MIQ7hzmHT4RshAWDFj4PAQMBDUEBAgQBAQMEgguCdAKILgIeBwEERwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXANgmcBE?=
 =?us-ascii?q?IEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjHQEBEScECwsaAiYCA?=
 =?us-ascii?q?ksLBgEUAQGCfIIwAQMOIwe4EoEygQGCDAEBBtpZHywiV4FiCYEaiFwBhThEh?=
 =?us-ascii?q?EAnD4FVRIE8gwM+iB6CaYUSgSOTNUGMG1R9HANZIRMBVRMXCz4JFgIWAxsUB?=
 =?us-ascii?q?DAPCQsmAyoGNgISDAYGBlkGGhYJBCMDCAQDEDQDIDE+EQMEGgQLB3WBfIE1B?=
 =?us-ascii?q?BNEA4E4iX0MgX2BNIF3KYQhCENaEhWDdoF4DmKDYYILHUACAQttPTUJCxsGI?=
 =?us-ascii?q?gEdpHQBgRyUWrIyNAeCNoFggWEMmEKHAgYTL4NyX5JnDgaSaC6FaYFvkFwgo?=
 =?us-ascii?q?yyFOzWBSCKBXDMaJIM2TwMZD44gDA0JhAuZBUE1OwIHAQoBAQMJAYFVg3ABA?=
 =?us-ascii?q?YNagUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wq5AFKs/9698obCobJFTrfhF7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AKysafmmlhTWz0OboRowoAAUbaArXOW3t83v6JHe?=
 =?us-ascii?q?YNWp0VpGPa2O09vs1ycU7zg=3D=3D?=
X-Talos-MUID: 9a23:2VZmrQmHmMr4D7YaeSsydnpMFd4r7ZmJE3odvrQrtOCnNDJJKRGk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164198877"
X-MGA-submission: =?us-ascii?q?MDEglZMiRQLJhewKOgC+uydNtxsHdEH2Yz+9n5?=
 =?us-ascii?q?XZjRrjTeXEz03NQTpal5XPPOfg1a3U+AXH0t55zhGk2vgOz7AFuy1M/L?=
 =?us-ascii?q?3TBNv6s4sOwkamBLRbBUeC7Mrx1FYeQGf9H6lGmrXY1jhiTyf2G/Pbq7?=
 =?us-ascii?q?Y9K6Eqxs0X6DJzeurQlwwR4g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:18:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714645112; x=1715249912; i=markus.elfring@web.de;
	bh=MfDD/I/RaB9Tdel7aX4cpVPVUm9D0JpclEnPCpvlnpY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ebSkKQRSauF65A89xs21xmvGrjiLdHgaDl2Fxpd0To4QJYa+3NBrxO2sDMLSTkmL
	 PvtUBRsPuHE+F3ksyKXBjLNd8n+iTTN8k+2rDmQiPiIEKtaFr7uK+7q2FUk7DcBeV
	 3HY1XqVDhGASprdJzE4/NjjzkrCzST/U+E18e+lMC+U/GxPM3PX11oW2j4uGegcvd
	 D4QTcUyck/1gVAn2HGg0MfQGVkWtaSIZ4XqtDZA8cZ/Onye1D9+6aDpyAhCKpCG0m
	 syiwcNk4U9JmqMS2jabTESKnLldK2jv7w50IBSXIhayqXyDQ1sWUm3PSHJrF9xZWS
	 sTVuP0CeZXx7ZvKnLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1rzjgw0jIA-00CZBN; Thu, 02
 May 2024 12:18:32 +0200
Message-ID: <60cddf4b-f5f5-4df0-bd16-9bdd045018a9@web.de>
Date: Thu, 2 May 2024 12:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Richard W. M. Jones" <rjones@redhat.com>, cocci@inria.fr
References: <20240502085433.GA30267@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240502085433.GA30267@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jRIb9jGWOh7Y9z9MDz4ciffZivw3iekbwgNHNAvvHZarfTLHVh8
 AsVtApOzF4ujPOhjiSTn9MfRGu8+cEBUTBZ9e/jwo7nkaU47wKDhAcSKV3ucyLuab93XBO8
 ABUz90+uxLJt9CAkwB5xctRwyGcI1JVHGXXzDzU/9uX9KZuhg4o+K2r79y7SkFMqPoQlzRe
 OoakOgXAhaGKm4qZBFgaA==
UI-OutboundReport: notjunk:1;M01:P0:jsD6vw9A0Zo=;TS5YRUmwCevAyvU1IutWHEyc+3k
 pgNMEEfJtmL4k4Kh28sazhEByl+WC1Wur3fvYipCowWWguzeNJMsElzQ691j/BbhncvlKSw6x
 2f5AmngFQe3iBUVnhRo3cJyOp+xgpZLKwtqUsr9lojPVE+RynuFu9DnrTr2lgVnMGNxfTnvhD
 CnFFD3F8ypC43VHqhXZts+fv+fP7LEua8zAy2MXg3f65s+typkavLHwqT1GaYH1BJ8j16I0Y9
 SwVTkiHBgcs8C5CmsA65Lf65FJKuQgnpKQMmL7Q3FfdTNTUXeAKljlI6YAj006Q1ankEAaHWm
 x9D1otK8MV0ryqq9j6yIQ+WQXirXtcjUMv5mERU4+12O97Wy+PZjWnsPEPphchhkMICyOmv7X
 Tyv17Ag6OY4ZXmxSvvc6SF6WpCCRXE/H8PqSDtWqGOdDuDaSftMsCpkhOji0FTFNLRdMKZXXP
 NhEpEEZsbBIK9sDnvHQKRwapGNuU7crb49yr6OGNHkKJSNHoFDOb70WMP0wDyINrvD+P8OCpU
 EM/HnFMWIR9w+w7xONgRVE4XSlKwLv9auK6Y4T+k7tS/Ms5t9QrLfnLpKXkiiH5KMbafNvRsV
 QiNjnEL253VJCf3+qdBIcd+8YNqHfSEw5npG9OXJr4hU6pYNFQ9nqHqAF6NlgH8LqbxdVc3IJ
 VI0xczPWtM9hvCP3zoAb/OXI1M7hcmhGtbaluHlje25dtw7m0aTg+wEE9xE1udVkXQ5PiHDZP
 HITVSp1viB8Jph59ODzC9EVL+o+DdtbfzNyP4i+vCMK8tj3POPTVvzs6nFIFEBZ1ELk7htqwO
 sue5moiJtbHOA0C6YmE9M1cnAvMezeGEwxQ0JPiJiAUUc=
Subject: Re: [cocci] Checking compilation durations for
 =?UTF-8?Q?=E2=80=9Cparser=5Fcocci=5Fmenhir=2Eml=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1679
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/60cddf4b-f5f5-4df0-bd16-9bdd045018a9%40web.de>

> This single file takes a very long time to compile, about 34 minutes
> on my 2 year old Intel laptop.

I find such an experience report surprising.
How do you think about to improve software profiling accordingly?


> It's quite large too ...
>
> 139201 ./coccinelle-1.2/parsing_cocci/parser_cocci_menhir.ml

How will the software evolve further here?


> I've observed in the past that the OCaml compiler doesn't handle
> single large files well.  It seems to have some O(n^k) behaviour.

Did you notice any differences between compiler versions?

Regards,
Markus
