Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216E2C3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m69QL/CRPxIjJqtGt8liU4WDeocSvWCmHhlfFZx/1EQ=;
  b=iZPq5rCx1ZCaW7EZ8kDjLX9KbPLi70ltAP7xo8JXV185bG7wJnJwqLZI
   ylCBnNMTxXJWnSmtpKz7iPnb7PdL+Af25cKL7D5Q88LVTjD/y22v6VBXM
   9l8YNFxt5Qp/lWGelts4dP0UPIMdNRKxhqyG0FGaQ6eDWU0RRd0QebGyc
   A=;
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
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178127752"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 12:02:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6257CE0D60; Mon,  5 Aug 2024 12:02:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 69754E013D
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 12:02:43 +0200 (CEST)
IronPort-SDR: 66b0a343_+SSENqB987Gtcx37MQMtq14dx2uEo1zxW1TYCQTxkLUXERN
 Nc+sBC9Ne2s40b+L6vKn7lLuG/ZYgtH0sAiE9rg==
X-IPAS-Result: =?us-ascii?q?A0EvAADHobBmh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYhsGVDMEC0iEVogdhy+CJYETgyiPC4pLgUA+DwEDAQ09BAECBAEBAwSCC?=
 =?us-ascii?q?4IuRgKJSgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYVAQGCfAGCLwEDDiMHDa4TgTKBAYIMAQEG2?=
 =?us-ascii?q?lkfLCJXgWMDBoEaLgGISQGFYgGEdicPgVVEgRUngksHMT6CYQICGIFGg1uCa?=
 =?us-ascii?q?ZImi3smkDtSexwDWSETAVUTFwsJBYlLCoMjKYFLJoQYCIEtFYNlgWsMYYhUg?=
 =?us-ascii?q?Q6BPoFfAYNASoNngX9CAj+CY1cdQAIBC209NQkLGwY9pEiFQiKzKZRYNAeCN?=
 =?us-ascii?q?oFigWMMiiWVKgYTL4Nyk0oOBpJumHCNe5sbgWc6gVwzGiSDNk8DGQ+OIRmDY?=
 =?us-ascii?q?TOEYcJJQTU7AgcBCgEBAwmFRgEBhlyBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:O7ICrq9TksmodTcG4xxuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re+cjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:5WDIKW20wS4dfqD1D3Z3R7xfRskeL1fT12vpBQyEUkF0YrOnZA6v0fYx
X-Talos-MUID: 9a23:AbzimgZaGTyGT+BTqQe9pykhJc1T8amPC2wjj6Usn/iGKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="93587811"
X-MGA-submission: =?us-ascii?q?MDH6DX055eTVdOb6XRRkvoZA9t0e20VDUR4mgy?=
 =?us-ascii?q?drRnjpCPBaK4B3j3/DNlsdfZ/b1DQpOevsFyd3qIVohY6i/iCJ2aMaxj?=
 =?us-ascii?q?TQffhwJ65f5ugZrT4y+P2PJx8nvoZbC4KrPSqZVackk23FTj6zj5soGM?=
 =?us-ascii?q?S952h+6zqIp4Je6WHJ3vwyBw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 12:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722852161; x=1723456961; i=markus.elfring@web.de;
	bh=m69QL/CRPxIjJqtGt8liU4WDeocSvWCmHhlfFZx/1EQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pljJ+oh2Aa/I6lYsPRNRHGxcPKkKmVziVKRLcFmzjDyejxoT9wQ6pDH1GHNeWyoh
	 3sZ7P/Caz3u1VoJAn+ua8w0DoUBQHM+q6YuSYfSeXnWvZ1g641ADIoa96ZpoTCRdz
	 QQPObCl3F73/8xcvPwMhvnLlKVkxHR1/kmiuq8jpDSCcRGz2+TGCtRq/7rZuxCQgb
	 4jYt5/y1cyiZlVChP2/CabylEIXNoL1laa5Ku0vXr++jn6j2xJIscj3c9W/n7aOSj
	 pKmF4/aCz5w4oDM2rvXbFV3ISAKLUOtpuj9WQTFP9Eqd1+6HipBCs6QSrkxWZQlyi
	 287srVq/Ef3LWq7yNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1sOW5y0lMZ-005ncv; Mon, 05
 Aug 2024 12:02:41 +0200
Message-ID: <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
Date: Mon, 5 Aug 2024 12:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LoWL0FVI8zsDSgfnkZ9PQznA3BCxDUYjwe3+/iHItBkeEJKZbW2
 LJ57LiWjF4r/o9GBgOThNh+Msb33nzKvkAJ2SUxuGRh05PoEMglKzIGZlGn4/cAXpmT0AYO
 XYLV6KTdhQUPDrZNqFvmK1GDYVIZcQDitBoQf1t0X7j0uT8pQWvZ1N5vtHgIzFpUvNacDRc
 nf1FgW6jmsf3L+Kk7pZlg==
UI-OutboundReport: notjunk:1;M01:P0:sD6RpdGXgwM=;Osg+fuawHZiM6E6TLwMQ5gDlqim
 SGleTc8wWH1WK+qVwX7aVRPdiMt7zBIvJ6VGZcqkbqdHnqYaNETdJJEwzw74DRFJFwwatKnEB
 /2SyWIC+STltpfv5ChDIzUWY7oYc9OF9NHT2vC1JrQ56OcYUWvefsw32gbe1tv4DpCn2U0tD+
 ikHt6Ki6nq7kdM+SGIFHk1ge85uwgN1qwP7SyGgd3aqp2nn6PqL2koQRNQ9HexJOnuTuB1ytw
 9rETTruI/WJLtjZKfPk13F0FJnWZ0FRVq6mcQOxNTWsCNv3UHHwHwuVvpVXc4MThKjcgjhumn
 1OxaDgkkjq26Pmn0aGOipiYN1P7CFuCDT4eFTwW4b+KIvfT88YJPIxjfa6xpdl6jZ9lMF99Nl
 l6DV+l6+59A1u9JDsNhSYTCvJ9BgBVbPfmrd5U+3rYffSKDvcEzMceybdkH5puQB8bymq/BAO
 +hpIPNsWwzfHl2Ae9S/2h4I2cioHVX2YJFamQY25PEEb4JuBRtvdUUP/+reQvj9vlVgsM4Jmz
 RGc3gl+ihYjTC2wKhQpl+TJwpOXGPe6MuG0/yPmTyfvzUMKS4uDobVQWg4ficO0SPHS7gefKI
 QgVLUxSmsacbfUHopm/ClAmtY9pr2IzAd/F1wwyoFPGC2i+vdrE742DcgONCePh8ALP/VqeT8
 U7Rhyq0IQpqswJ+KV0I9wfl1ovNqeo8ovqEd5yPTvPBaORsEEajQO0CmBN203sv/y+MYyUri9
 S8CXE386wiP5K0FO51rxPrCVNYc6/wTpOt7++F6fM9MqZviLLZWgTv3riLGK/2uHSOHUgUh0i
 RkscnrEShXubge2r3LBgYj8A==
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1832
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/98a94966-14c6-45c4-99d8-471f65b292ea%40web.de>

> Our CI went from 5:40
=E2=80=A6
> to 42:13
>
> https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/123=
5432/test_report?job_name=3Dstatic-upstream
=E2=80=A6
> Is this something expected?

I hope not.


> Or shall I investigate at my side of the cable?

* I suggest to offer further version information for involved software com=
ponents.

* How do you think about to extend configuration parameters for affected t=
est runs
  so that detailed comparisons of run time characteristics will become fea=
sible?


See also:
Selection of benchmarks
2018-04-24
https://github.com/coccinelle/coccinelle/issues/133

Regards,
Markus
