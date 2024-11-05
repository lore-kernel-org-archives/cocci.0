Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBACD2B950
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2024 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XpKo3b+vedm9mV100+6BwR4PsJ2QXwtfpn1lYsPF7+U=;
  b=pAt5CltqDBl1KQ1VX3OBT1wWBMjmXwuw1ljk0ExfXyihhoW4KIeCMdcd
   /p2FsWrqxzfg+mjVW7VRGzCNLY+kzN18LATpLUk1uEaMer0/vNbSQvzvG
   kq5j4+860xgKMSwM73S9UQPZaVTdUs39IpA3G7dZf5NnQXXmTiOZVAKCn
   E=;
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
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192319707"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2024 16:57:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB0D3E0D1E; Tue,  5 Nov 2024 16:57:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C9D9FE00B7
	for <cocci@sympa.inria.fr>; Tue,  5 Nov 2024 16:57:20 +0100 (CET)
IronPort-SDR: 672a4058_Pfpf45Q9zsRdCxuWj9RofGN6QpdghRRKUxXhrSy19dKTL3W
 G3I3KwRDoMkZ1nirh2L9tFQ3tVCk15eUYjv3lCQ==
X-IPAS-Result: =?us-ascii?q?A0GuCADBPypn/wsR49RaHQEBAQEJARIBBQUBQIFTgkQHg?=
 =?us-ascii?q?VAzBAtIhFaPTYF0MIQ7hzqHVYh1g1QPAQMBDUEBAgQBAQMEggyCdAKKNAIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECgQoIC4U1Rg2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfYIwAQMOIwevNoEygQGCDAEBBtpbHywiV4FkCYEaLoVqgmIBhiSEPCcPg?=
 =?us-ascii?q?VVEgTwLgkcxPogegmmCNxWFIiWILWiXYFJ7HANZMgFVExcLBwWBKiQsA4F7W?=
 =?us-ascii?q?H+BOYFRAUKCXUqDPYFeBTdJgkppSzoCDQI2giQkWYJOgSUEBYNvgQuDZYRpe?=
 =?us-ascii?q?x1AAgELbT01CQsbBj2fH4Q4gmmkSKE3NAeCOIFlgWMMn1UGEy+DcZNODgaSe?=
 =?us-ascii?q?ph3IqkAgX4mRoETMxokgzZSCw4PjiGELcNfQjU7AgcLAQEDCYVGAQGKPoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 CaA9raGTHm5n+PJxjc1CXJz
IronPort-Data: A9a23:b8CzlarUBoItMr0W/Y/fRyExGXleBmIOZBIvgKrLsJaIsI4StFCzt
 garIBmEbv6OZmD1LoxwaI2z/E4EuZSDzoRrTVNq+ClhFywV8ePIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKiefHoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqqUzAnf8s9JPGjxSsvvrRC9H5qyo5GpB5gFmPpingXeH/5UrJMJHTU2OByCgKmVkNrbSb
 /rOyri/4lTY838FYj9yuuuTnuUiG9Y+DCDW4pZkc/DKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kzZc4G3th8Ql1W8
 PE+chQwMkDAo8ePlefTpulE3qzPLeHuO54D/G5tx3fVAJ7KQ7iZGv+Mv4UHmm5vwJkXdRrdT
 5JxhT5HSR3aYABUfHoTBog/muiAmXT1NTFVwL6QjfNmuTOKnVIugNABNvL/e9uqaMxvxX2Zt
 0zPpWPnJUxACPOAnG/tHnWEw7WncTnAcIkVH7a53uV7hUWagG0VEhwfE1WhycRVkWa7XM9Db
 VMZ8GwioMDe6XCWczU0ZDXgyFbsg/LWc4EKewGXwFjlJnb8i+pYOoQFctKFQNkhqdNwWjEgk
 FOE9z8s6fqDr5XNIU9xNJ/Nxd9xBcTRBXAPb2kIQGPpJvH99ZorgEunoslLScaIYx6cJd006
 y+Hpm4yit3/SCLNO7qTpTj6vt5nmnQFosPZKOkasqJJIz6VvLKYWrE=
IronPort-HdrOrdr: A9a23:xfkYBauSxgfV5WlHzl5NxlV77skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: 9a23:BD8dV2/8WSqhb8OlJU6Vv0tMWd4BTHae8G/VLmniLVs1GP6xbGbFrQ==
X-Talos-MUID: 9a23:LWfseAouuBNpoYxovcQezxtjM+dF6p71M0Ecv5xcvNejaHZMFCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192319678"
X-MGA-submission: =?us-ascii?q?MDEwNfUaAOqgBoEgdyhyAXLWaHVGxhxnTiwtlk?=
 =?us-ascii?q?OfiVOVAIuEHxT3QhaW3hEynojx8DBhKltiWSdkTvOegw0xijunNe5MhS?=
 =?us-ascii?q?nrVUIsiqnYVazYfqTgG0pZywEOKS1U+NiczxDqKgVOLFSN40MQsqo+qQ?=
 =?us-ascii?q?emJ5kLr7urMN2uGTY56Oj3qQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 16:57:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730822222; x=1731427022; i=markus.elfring@web.de;
	bh=XpKo3b+vedm9mV100+6BwR4PsJ2QXwtfpn1lYsPF7+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ov9/wk7oFP77YzDqkhVqa4AJvVfoaQRmPJz4CWAb/lAzzPi17Yv6VAq0Qjo0fPsY
	 0TFsZkgsR803fs0m5clFrsyQatYffVHM730CUD4xupwuBoHzu/yAF3p/5b6jm8HAb
	 /1pEfkFFdwdl/jzSjr128dilwGQtiuLMtNx9izfZAOZxaV7RYxdA6iapidIUM/onA
	 8B0YtCy7wZ+J/VI92Y+tzors3JUjsRzKw98UD/wOZ2oSBhrhkokVAK5kx6X/rkTMD
	 hczdnHXXFn3vg9C8yOeQb8oBMNvPw/csIS1GlU3xGPaH2y+yhB2+9QGSlp55UTKtU
	 kTvX/Tuav8qBRMqD5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1tjdsz0U4h-00k2Rg; Tue, 05
 Nov 2024 16:57:02 +0100
Message-ID: <9b413809-aeb5-4097-a9fe-a9f912b5403c@web.de>
Date: Tue, 5 Nov 2024 16:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
 <05354787-2a60-4c3d-8818-0d23c8e2e015@knosof.co.uk>
 <9dbf4109-9cf4-44d2-8b96-7354e73bba0d@web.de>
 <98b5857d-52ae-43d2-9b3d-ffff4de4e8a9@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <98b5857d-52ae-43d2-9b3d-ffff4de4e8a9@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:M0qXdf73UiK3NxeFMT3wZb2aUdjViXbM+Pt03q4V/zk2qm/f7WE
 K06cUkkknjE9+kR5fGA4+Ypw0TDqOcC3IV6gLlhQyOWMpsDHsO2C4BX67hyLAUN0bc0NAQ5
 skyyWTJGoZKx+wSCCjCKv6a/6ata4YF3ESzjt+Z48vboNDeam7QU+OWHlJDkLKeB/RDNyyb
 MDjcMIt7Upfzwuo7UwfJQ==
UI-OutboundReport: notjunk:1;M01:P0:zQhKu7BOppU=;OstomUSPSijvS/Oe97hDuHeoejy
 SLH12XJtuBaXbzAIHtx21tmPFcQyJgcGQgLep1UFmRLNYZHOU5JCpqWdg55GfY+ntCKjBZHIb
 ZUMK2MTw1YF5UYUK+VKrk5uhNSOQ7/acGr6XQUy8gx6we1uYnhGVORucqBYx41K8GeFJyaLxw
 xLzdIf5N504Wmt46Txg3JqAndDifEqEwXpzidzouaF8BhsBFuqFV/Gq3syEjiRT7DLC0a4Yww
 h/LFIbC7SwnY7zjCbfQGo813s83o5h58OqlJdoY5vBD5QtepiVSfhDVfOyr1hh7W4hXb9KzfH
 JWHkSR4HzXsuWwjMpwVDR6lg/3TkNgwOhmxvd01+egLxsqSq1F8KMLYZh9lKqAA8LOITz8Gwj
 YuQZPAsAf4aou7NulT8cWFzCwIkwPr/9EVFRm5KlOw0Qc1fBsA0XVihiAKtoLszQiIw7es5rr
 OkA4Acq5crjwwmlhZ72UWQ+W8Ztfuh8VZVzuxUiOGxpfqG/fUonwdlTaM/oNR/Zeiy8IVI7VD
 ed2GWbLCVKUmaI0N/lnOwkSDIr3B2aiAq/NBI9eVffN6V3GNfIX7y0pe2wNeUKYZTkrGCse+H
 LO1X74N2w0ShicATYmABI5ocB3j+SsPs41GJVvQjmSwbunwNluFYfH0z5e/213cRmRQ5AY7De
 swcVqRzj3vlJg7udSLaxU8Po5L7Ns0aUJSiyhmTp74M8+o++xWGq4NPplDteuID0WZ6+u6rrL
 22kksmz7wcc+YgarLlYDEvxtEveudYUbVv0bVir4dcdWIk4ks82CJ5wfcnnm6y+ZVEOVtD1wW
 +EvxXE/zRhBzPA0ZN59ERnyQ==
Subject: Re: [cocci] Importing source code into graph databases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1969
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9b413809-aeb5-4097-a9fe-a9f912b5403c%40web.de>

> If you plan running lots of queries against code, then there
> are probably performance advantages to prebuilding a database.

Under which circumstances can development interests grow in such directions?


> If you are making one-shot changes, then I don't see the advantages
> of a database.

We tend to stick to file-based management interfaces for another while.


> The GitHub tool, CodeQL, uses a graph database because they expect
> to run many queries against the code
Such a development interface looks also promising.
Are you looking for growing support according to corresponding
software alternatives?

Regards,
Markus
