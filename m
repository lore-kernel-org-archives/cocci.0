Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC8C02192
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2025 12:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rv0g79By0QKxVt//z/FtGC9BOeA6b3kaoruFnclQvPA=;
  b=aAny/v26afGLUjy0iNr2cqHrRh2hIi+NKqMzZ7uf4+dPJCqr0cN6exkU
   yRagj8cQxk26kkAIq3xi3pogWYVfhpp2f203XL8yVfYgB2SWx6uZmgKqE
   85aZOcpQdMQnOik9BgGAn0fRToLSa3v60j1sv+yBKzr+xQiXe0ZtWHWYD
   U=;
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
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206717783"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Feb 2025 13:05:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB274E0D1F; Wed,  5 Feb 2025 13:05:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 15C19E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Feb 2025 13:05:39 +0100 (CET)
IronPort-SDR: 67a35412_ukGwgBXDYM+Mmg4gTFvahFcAhP7GFhVUr0m2NQuwPUctMyw
 6UIqYG8Co5hFbbnMkrV5c70ICBjLPFpVIaWEe1w==
X-IPAS-Result: =?us-ascii?q?A0HDKACrUqNngAMP49RagQmEF2J1MwQLSIRWj0+BdIRrh?=
 =?us-ascii?q?zuHU4h1g1QPAQMBDUEBAgQBAQMEkAACHgcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgluBLIEmAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QJHbR0BAREnNAImAnMBAYJ+gjABAzEHsSuBMoEBggwBAQaCaddzHywiV4FlC?=
 =?us-ascii?q?YEaLoVsgkkaAQVtihcPgVVEgTwLgkeFf4MOgmmCM4RKZ4lziHSQD4FNHANZL?=
 =?us-ascii?q?AFVExcLBwWBcQOBETKBF3uCR2lJOgINAjWCHnyCK2sEBYNqhEOEToVgghKCD?=
 =?us-ascii?q?oI2hVUdQAIBC209NwkLGwY9nVeBKYQLgyyUCZEooTs0B4I4gWYFgV4MiQWWV?=
 =?us-ascii?q?wYTL4Nxk1MOBpJ7mHyjWIVWgX4jgVwzGiSDNk8DGQ+OLRYWg3XHcEI1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBimiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:lwxAtK6fLp1hK6q7tAPXwBHXdLJyesId70hD6qkRc20vTiX8ra
 qTdZsgpHvJYVoqKRQdcJW7Scu9qBDnlaKdg7NhW4tKNTOO0ACVxcNZnOjfKlbbalTDH4BmpN
 9dWpk7Jtm1IlRzkNrg7BPQKadG/PC3tI6twcnRpk0DceioUc1dBsVCZzpz3ncZeOCOP/sEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3Ao8Fir2uDq0plX3qDiz0CzNMG6Is8W3zejy7ZIXO?=
 =?us-ascii?q?UKkRxFo+bGGSv9qpdxp8=3D?=
X-Talos-MUID: 9a23:1Rfhuwqg8ytEUVdiHm0ezylSHeF3wb7/NFoUjZ5f5+bVDwdxOTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,261,1732575600"; 
   d="scan'208";a="206717773"
X-MGA-submission: =?us-ascii?q?MDFyy+tLuFUSEbh0oeSfUvC00L5XbJwA4psCp+?=
 =?us-ascii?q?hzjGGujWEOXEJrX45nb2xbUFONNr6wWealXWN7cb6rc34H+YwqkWjJYO?=
 =?us-ascii?q?0t8htJtP3G+xJYcXi4Bm7du45M/lyVB4FqJ7h//P6OTvwW/PxZhoIc1/?=
 =?us-ascii?q?IbGw6AZwpUJrqoaPT/8pbR3Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 13:05:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738757137; x=1739361937; i=markus.elfring@web.de;
	bh=rv0g79By0QKxVt//z/FtGC9BOeA6b3kaoruFnclQvPA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wXNWTHGbnME6dww1Njh41/87eCtA+6ay4MakyuOWdmTNn9xzScCs9l2w1vsVdhpy
	 IFzVhrY8/L6orKH8mLY4joyslcq7Zuvy3s6Q8KjwfCDhPOlHY5mIIP1cdg2d6okGv
	 Nly98oa7Zr5zfBoNSNnDhb5G8PelKDdnDN7MNqhEiPJGl6GDDKCEAfSiHj2B9JM68
	 yibV62vAMJ/8QL7gu5umQP1/yck09zvmR0S/hUcGJAMTGaekPF3n9vltrEszjNGmt
	 6H6dG9g1oOYUY/oFS6GITwS9iMP4BW9oq4ZiLJhO7+IQHIPithela9Yh0J51mKmxA
	 Q1A3Tcy/MChQJk8hqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1u1pjy3K0V-00SMc8 for
 <cocci@inria.fr>; Wed, 05 Feb 2025 13:05:37 +0100
Message-ID: <55fe2528-2405-4762-8e2c-f326810dc2ea@web.de>
Date: Wed, 5 Feb 2025 13:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VE5b2mGgvdK4H7cJpav7GppV8SZdqu4aCvUlBIpg9EHr2BgWuTm
 GcKuE+yVFcaezDBN7FpbYCWCH3HxlJm3n+lv908Ht3VlAG58ypDk7lWiaRHVzieJU3Pj4Y9
 370EGFnGYpqJzlbVcPQ2+rJuyIe39H58A2SDwEDOVaubL5Y19RShu5SYkUPspsdd8y16Ely
 tUBI3DHgFn64vOf8jEAMw==
UI-OutboundReport: notjunk:1;M01:P0:njk6BV+f3jk=;aAh12gWQQuV2eXl7HfbNUeYAirb
 SAqtSoMfagcIIKIrOCjLyuHq594oBJj1a/fNVyGgFxWxbCRxsOZV5yi4NkWFokh+93dM2i1M2
 hRv/1Ue7TeLw39lhKrH0nvWOQhSBPXAt0BHZoaAQfj41a4PTPFMxzfKGNZLpekpu/uCMSgEx5
 dOzFOyw/l4sYXUZKDOp03uHEUP/7A9GG3o52gsNMuU1LFlftD1/h48ICMsKTzq8q82YoROlAi
 j9qaAV42EUlgI/5EwfSbHh/JAK0YsbqpTVoMwrgxklyWPM0aZMp+YGK+TqQL/zMB6ddyXFmFI
 RZsBWFhpXoBsGDsju9KW65um5sS0twXFsooykZkKHewZAMxnU8EET4j1+bkCjsxh3SOLSLUMH
 AaLSd/HBpAKfuFiNFz3IaoMGU6u3M++weVmsCMsOyU76/jHJvsIsz0GS7vJ4a6oZd6GItDbxi
 AuReKAhFgEB/9t1ltClD+92KN3P19DS6MOgrkYVcZbe3KIHkC/xmFQFmdSGCGW6kHMYlnnTsw
 6fhlAOdcXde5SFTSspNEibI7T/8deCjfLveQDAO94bU8f9HT0iKv5G7cxxzEiP+annKIPwQpT
 7TYSd7pyur0CG7FWF/yNj0eTxRhcXCnOrO9QlHtYKex1S2xSHVaZFmnNZMg44cuJBM/4h5Ey8
 4Q5HpA5OxW0uYcS1fVjBSH0woAhBDSV5eUrZvcZ3rWQfeT3/f1/NkymuWSuxWB9q1xJhUOvuV
 1wAU+8rJ34NFcbLYPS2PX99OsJdEqW45lAWt+iB73EqkBU62wK60YvJenMNV0pokd3BbSSByc
 exKld0VEb4WgTayVmzXb06SBwDVnRwMcsvLJOKTf9mRe7e//oMReMN1N31TmR2Glb2u87gAOA
 KOdjIgyyN8Jdgf4jxiZ3M6xUcjXN/fh5yjfNZhaLy9dMOz2gSWZ2HuT/cWAcp4c3LHJvGsc+x
 UUfvZUJs8qgpPjj4TjwalqeOyOAGATDEzhEuKQ8gC5/seYG2Uq15bdSDSXuobNIvrheL7yGMY
 5NDAN3IgczyAyaF/077Dz2uqkGZ70fvWwLr3YzanrjFRyxVgyec5hRO1qMc2KE5NK/Y/SI04m
 gLGT4fT+Q5wf0Z3vX2m9yutGDUYCC/rhUuOEIFg87q0DlNAQcIT+j6NHxmg9s8YZivPX1QURB
 7bRKcX6X5HyJUkiaj9avtzDMMyWl9TpIVXutvbtr3rxTteNNaHRS7XywL/DYdSwRYWtS3p2j8
 P+EglWQfB3+KDewAp5Ve7UlodbMEAmsNDMpZCun5mextHPd9IWRbxm72O75uDaKjnr/cD0SFL
 umPhtufZ4F+I664dT3KSgxTOKQh/H6QsDmimxFofVDCX7clQ8UxN0nE5IhI+ybigEDU5a/WO5
 vXU9nLcvc5yRcjDtSeLUupkJJE0g3zFxfZW1pkF8X6mM0te/zOyuzAHBsMIiaLkt6sRv6wWFF
 oNLvNNDXIkCF398e3x0kr3Z8qWsY=
Subject: [cocci] Increasing awareness for short-circuit evaluation
 consequences by SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2346
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/55fe2528-2405-4762-8e2c-f326810dc2ea%40web.de>

Hello,

Disjunctions of the semantic patch language are using short-circuit evaluation.
It has got the consequence that the last element of the specified condition will
only be checked if all previous parts did not match. Such a technical detail
can lead to a recommended ordering of condition parts if you would like to care
for optimal run time characteristics of SmPL code.

The usage incidence might be unclear for involved case distinctions.
How do you think about to clarify possibilities any further for the reordering of
SmPL disjunction items?

Regards,
Markus
