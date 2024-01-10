Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1F4C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Fr77BcjxXdOLHELPhS23T4r9g01A3M5ZfG69Gxca5NM=;
  b=CN8g0JG/yA4fwEmGYGJbZTNkX9aBFkZ6jM5HPfef/Gz3/83HIeUlpAUX
   IMsoA8pMg9laaAMsXXGtZ3H3wiZPTfGSbMqx/oV6Yn7XhAgeRNyyamTzU
   JRSfOg/nkwxk11gDt64BMJ/FeLFfjjNF8krm02KmmoQv9OXYw6/L3kIia
   M=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145872206"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 13:52:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D3C2E0CCA; Wed, 10 Jan 2024 13:52:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F5C2E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 13:52:37 +0100 (CET)
IronPort-SDR: 659e9314_EjxqBwgDz9a6w/rJU2ZBB59/dIQCDUkB8M3TmbaYZmfSio1
 ANdkez4pUc6Q05F3fu5EdzR2aaqNEUNa02Tq1EA==
X-IPAS-Result: =?us-ascii?q?A0G+AAChkp5lfQsR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YI4fFYyBAtIhFORNjCEO48BhGuEBIFWFIEsPg8BAwENOwYBAgQBAQMDAYR/A?=
 =?us-ascii?q?oc9Ah4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJ?=
 =?us-ascii?q?BgGDgULJ4VsDYJVGIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQINOkIBAgIBIx0BAREbCwEPCw4MAiYCAlYGARICAQGCf?=
 =?us-ascii?q?AGCKgEDDiMHDQa1W4EygQGCCgEBBoFFAgwCQ61AHywiVoFgAwaBGi4BiBoBh?=
 =?us-ascii?q?WeDQXonD4FVRIE8gwM+gmEDgSE+g1uCaIVckCJSfx0DgQUEXA8bDx43ERATD?=
 =?us-ascii?q?QMIbh0CMTwDBQMEMgocCyEFVQNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM7AwMGAwoxAzBVQgxQA2UfMgk8CwQMGgIbHg0nIwIsQgMRBRACFgMkF?=
 =?us-ascii?q?gQ0EQkLJgMqBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHe4EXA?=
 =?us-ascii?q?xkrHUACAQttPTUJCxsGPQKVKgGBbYIFAoITxTg0B4I0gWCBYQyKGJUTBhMvl?=
 =?us-ascii?q?yYOBpJULodQkE8gi1SBdpp8gWoLKIFcMxokT4JnTwMZD44gDBaECYELg1aKZ?=
 =?us-ascii?q?kA1AjkCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yJepr6mDl4451/ebzfutZf+lp0HpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:DRw9MmNx3yXSO+5DAyB9pRJJO8cfXif95U+JehajLGN0YejA
X-Talos-MUID: 9a23:6MXrSwjapj7dZqg8TSHdqMMpBP9E4ampUUM0kJhfpvmFGC99OSexg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76377980"
X-MGA-submission: =?us-ascii?q?MDFhgwVlyoZRqAKUrlUGCTMQsqg9woUDDVSGBK?=
 =?us-ascii?q?XGKu6XZKa40+Tf0Ic+cq990ratZ1t4SwoMfkimGVk7b9VB9U5lhl8hDl?=
 =?us-ascii?q?oGjKrT2WwLi/GnoCob+C5agSmRqDDNYPoWz9uo/fozfIcExjJk99VOjX?=
 =?us-ascii?q?L/BRrB2x7v3Led1BxChjOp8A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 13:52:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704891155; x=1705495955; i=markus.elfring@web.de;
	bh=z/lBwRWBNcQYTImVtZA+5BhEFyRCnsNgZwbeW9VNd3I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qJePEBBMfk3OLRY02rwrXtVGxNVknjMOeTm1SpPSmPPAxcCxQUyKB32OqQXI418C
	 fpa/6WIb0IChCiliG7tnnVHUfq8kWcq7CBO6UnE/bfOvnEY9Ue7t9dbqt4qd3uRh7
	 1VMUcGuItboxy1VNr/RyEgACwkK22rfzqTKXx6WUfOGs0CTY5GmklfSDFBaFuxxTA
	 NDVuAq+lIqy7fNujaRGf+qPRJihR4qqI/oCgJ4bz+kpH2zycEJCrODS566YiaA66E
	 6kgw/O98ldMZdYjAbQVTM5XAWHdMbJ0nVUhohrsZgliRSGlChpgW6+A7wFCY6vZlY
	 CgmY7ZnxfqzmrvtiHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1rIZzF2aVG-005Tl7; Wed, 10
 Jan 2024 13:52:35 +0100
Message-ID: <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
Date: Wed, 10 Jan 2024 13:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVPKRYI/UEIH4hpwOzF6NFT7pctrhluHhlbEnIDqNss/Of0suzs
 TvAZMy8INtCv1rIGLCRa+0+mEf7BkuILXAbtD8/6npUhImkfxlXNoB9PZqWAKmNKP0DXy4E
 STeXZ5fKZUOhHcIaZvLn+Xj/yq4ODhOSnI5ERSVUG79CmcVF6ynro5R6zHIaWJULGyTFGVd
 4cut+GmQA+l+7G40fy8Gg==
UI-OutboundReport: notjunk:1;M01:P0:/pQKDMW6cEU=;DvrOxllCli9naHa/NHd1YV+DYb+
 N0UleONu7EheaCF3AvxhEf7UhujzMLxMmx55wopKZb0EyEcuounzIfhLbSCymfiDj3wjrJFk5
 CdePYXFN7YLopADQVaTEirLo3VkayCaoB735OeJDQrOZvuYxzu3oqKUMffMk3WRYTCNO7tbhM
 1DxAuBUBBUCzDkwJhlWmqsx1WIzH5OZ6zH/+tX6e9YqlWkLtJyuM5BgEc8yIHcSxN8FuEBp4i
 ZaDAJlzRv3zHEfEgS6KsckzxzCgDqwxeI7FZTDlBkcskIhYn6lyR9jGDYDYCdSpUcXL7BHKna
 flUuZXDlBYyRcDqErnggWTsWI28O6stiXktwYh4RCYudFE3BGx2vzY8V88dtZ3G76WAWMGqvE
 EanikHOvefUcoxhuQfbixdWvlHNv0weYjHhogPexZlKUA4qvNPDVqp3ShdhNzD604GECfcdf3
 Yq1li1Vzbv5pc6rXe+AHZLblpsN4ADnzJ/bMSJOXn5ZO+ArE8+34v9zZJxlRODt91NLAflL12
 2JVj+KJlmqe5S1Is31aevbwKQQSI2nLTDTQ7TggWS/l1zwgbGGRhf6cxCqSfAjB1YcqRGpuaq
 SAoCO1yZm1SWM3UEIajo4W52skC357cmt16sqEdfWxLdhgiRgZWtPufAb8eSuiJqPf1Eu7lZ5
 82eUhxfhaK2Bem0XFp8eJYhaAMJ4QIISeRzTY5avxt7gUh1LG6nALurUq2wrWACGXVKiCNCVx
 MKwZAIdKot9qEDA0Cq9Uo9q34EtsUmXCETWljogqctPJQRzQcYLNFz/Kt97ivoch49G017RD9
 ml/DgId9pWabcnBtURrwUy/6Bv4u+99wu8HG5RTfMhxzDrnTf7Cn+yjc1KgMZRIOCsFlLPpna
 ZAEYGiCNl4QfF7UBrrZ1HYm+PnfBHbXpHQFi4/4AXpiIogkeFDPAR8M4GdzRmfWxH8/sdeS0A
 iThRQg==
Subject: Re: [cocci] [0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1451
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/09c4cb2e-967b-4d0e-b5c6-f959e80290d9%40web.de>

>>>>> Is this patch series still in review queues?
>>>>
>>>> See also:
>>>> https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@we=
b.de/
>>>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html
>>>
>>> I suspect no one looked at it, sorry.
>>
>> Special mailing list settings probably influenced this situation.

Did any communication filters hinder the clarification of further developm=
ent ideas?


>>>                                       I don't catch everything that is
>>> on the mailing list. Looks fine to me but it needs to end up in the
>>> patch system to be applied.
>>
>> Can you collaborate also with mentioned mailing list archive interfaces=
?
>
> Err what? Sorry, I don't understand your comment.

Are you going to pick any patches up from linked information sources?

Regards,
Markus
