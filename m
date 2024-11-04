Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E9D1BDC3
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2024 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=pgMFA06fdyhcVCRt2fYxtX6MkxMfmiGdbecmicXRXyc=;
  b=pHBFqpw61KOdh2DXXEIEq8Ld7BGKW/++OHSzM7s/5gK7EBUmgg7Icgwt
   G0RevnQLKPwhv0nanU0CTICa9DwVxK9AxoFm+5C2BwU/1bx5iX5z83k8H
   LH9tk4nIy82MODLS0xWVWNwq5uxmDi+ihnIf6EflfVG7BcTQop+LezPp6
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="192094308"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2024 17:28:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2C249E0D1D; Mon,  4 Nov 2024 17:28:48 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C32BE00B7
	for <cocci@sympa.inria.fr>; Mon,  4 Nov 2024 17:28:47 +0100 (CET)
IronPort-SDR: 6728f63e_MRC4ZjL2htNqvFn/oNOw978VoSymoINSsxnMtgqq66/2ZhL
 xRcJOatJQdMtM18zOHfatuw5YNCWkmuv0Ad6Yzg==
X-IPAS-Result: =?us-ascii?q?A0HnBQAi9ShngU7ASNlagQmBU4JEfVozBAtIhFaPTYF0h?=
 =?us-ascii?q?GuPD4h1gVaBQD4PAQMBDTkIAQIEAQEDBIR2AYo9Ah4HAQQwCQ4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCTKFew2CW4EsZQk4AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARYCPQptHQEBESc0AiYCcwEBgn0Bgi8BAzEHDa8qg?=
 =?us-ascii?q?TKBAYIMAQEGgmjXcx8sIleBYwMGgRouhWqCSBoBBW2KFQ+BVUSBPAuCR4NQA?=
 =?us-ascii?q?gOCKoMOgmmCS4UfJYgtaJdAgU0cA1kyAVUTFwsHBYF5A4NRgTmBUYMgSoUbg?=
 =?us-ascii?q?QWCSmlNOgINAjaCJH2CUIElBAWDb4RwhGxGHUACAQttPTUJCxsGPZ0rgRpHh?=
 =?us-ascii?q?GKVb5EUoTY0B4I4gWUFgV4MiQOBJJUuBhMvg3EBk00OBpJ4mHeNfpVPhVSBZ?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD5JOhGG+aEI1OwIHCwEBAwmFRgEBiWKBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rfeejq9NlzZUdXkRLLpuk+DDI+orL9Y04lQ7vn2ZLiYlEPBw9v
 re/8jzuiWftN98YhwdcLO7WJVoI0mzyXcd2+B4VotKczOLhILCFuBfBOXZrAHdJw==
X-Talos-CUID: =?us-ascii?q?9a23=3Az1iAU2pszDCaVn298p3piyvmUdIVT0TYylLpGmG?=
 =?us-ascii?q?xE0Q5F5LJSnSg35oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AddWpEA/87TWRepNwVekY4myQf+lE6Ku3DxwOra5?=
 =?us-ascii?q?cvMSBPj5fJAyWoSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,257,1725314400"; 
   d="scan'208";a="100708892"
X-MGA-submission: =?us-ascii?q?MDGWZQYwoQ62eGCSFaSNQENgh63d5Rc8kOvWwr?=
 =?us-ascii?q?c3G0zc+hSwkBwaABMIYnoFr7iNoPT0LY/cLd+XAsrhERcfg9agcvyAX9?=
 =?us-ascii?q?wRRghXk0J3SoWDFQS69/jwsMGwvZG10ApMd6Sd654LTmrHTz8/nXuQgR?=
 =?us-ascii?q?1eTwk5jRBauGLWSBWpolZIgg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730737725; x=1731342525; i=markus.elfring@web.de;
	bh=pgMFA06fdyhcVCRt2fYxtX6MkxMfmiGdbecmicXRXyc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NBlaFv9yzzly5n2KSpXlDZCz1+ggd2iFkqPgwAuErwovssreteR/GP5NVHUns4aF
	 YZ586d4qOAQne3/fOOSgIiE9FsRKmZBkNroTl4B7vZZzZUSveY1aQVtZk2dnKSlMi
	 XCmTlwDWoutTERQuoKOMC/KVG1Nv74NGT1XvvWtRFuTKYo+1cGjNGyB0Xu7cVZ+Wu
	 PvgxD9ZG4KcQ2fYQwbztVNM+teKLoSjFT5DKL+jsCsLV9ZSawVAZogfmUWJIORMY6
	 uuXzpHoEdqIJ48rvnFBGcC8lx2I8LYSI1GWrxqct8p2D+brYiarVoZLWtPGeWSMBT
	 N6AoWhBvrwpXiV0vlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1t9ux82hl9-00GTxw for
 <cocci@inria.fr>; Mon, 04 Nov 2024 17:28:45 +0100
Message-ID: <9aea38d0-4738-475a-b354-f26b44766544@web.de>
Date: Mon, 4 Nov 2024 17:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HNX6cIjm/Xs659hH4cRyGzPLDC8PtCBJzvChBhycMpMqa1JwsHL
 u/JIOyrabP7OywgI+wbfewHV7Muh+GgudEpznYfiXo76wem5Da2RRhx9bW95im+qcMwL1Yt
 07c7D0C98RkG6QwTtqpsjl6rxTpq5q++4aDaoXi3+CWYGjTvgiWGhlO55/Go7U06ePfVIZg
 zVs+W/FjgJwjZprWL9YGA==
UI-OutboundReport: notjunk:1;M01:P0:1hh1tiDCD2g=;4o2Xhi9+G/9VsaHcvDcqhV1TPYj
 inRa/VLp/n5zE59+0Tz+Fu69qi0Kw6Cf00bzd/zrKb0t0MsY3HsRQqU772gMGtowVa7eThVTd
 /ZzYUwXvNek/cvb3+Ra1RPGLGXMZIkASLEwVDJl8rcOT68HkgBDUELqfmb77pIMrQ96q092VM
 YimSg3lP7wP8nQiQzYoQdd5aD+a7GwQ5agRrBtugkDtgkfNL3jdcAu9OYF/VEBhpw1gIrHyh+
 Ngr69o2ilZzZGzzRow3y0WV0YTBfSm/a9F+qcLZMopE5sK6j632mhvNnBDT715yuOGgxbnByN
 x7JHNf33XETI2nom+bs2FRE0JyYIeVUU1JEn8t/KLV2kvySAhYnzAxvjP6bUkpFC6svKrYLm/
 Eyl6F5XT3XytJyw14LREzjwW2tarjm7sA1MUgk0vUIaXUCzQIkxVWy9w1EmjEdDO+s5oqosxw
 296W0LeIFulSQljfIDevW9UkYES0TOSxh7zCa6riFSPm8h+7/bIQMVvmMpGg1PkX/MRM5Ci8O
 tWAPQ0VlxzegCdSinhh6tX3n2oA5oSzCCuEBlAknMUm45k+LqgGdm8HybFtSWpBtITCRiW8mG
 YcbZvPbHPfzxT/iN4epz02IQADRz7y156ANboTehEYjcTXK1DkCHrZnZJ58D3rZsV5TEjPvFh
 vZP6OUAFHh4xwHoRieHo3c29WpUyWoZIDgxoVwxlzcqcPnWhYhj0TnHq62w/yrnSZoAKQwPDw
 7Y2i4wbJdYUaSqxDkXzhosPi0tGFf+/Vdljjk3DI+mcWwTL0iAdesWwWe5AR/k5Z6iOmcPsBP
 XWF7XWpbCmOV8YjuxuZC0NWg==
Subject: [cocci] Importing source code into graph databases?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1963
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/9aea38d0-4738-475a-b354-f26b44766544%40web.de>

Hello,

Graph databases are available for a while.
https://en.wikipedia.org/wiki/Graph_database

Would you like to discuss any approaches to import source code into such
information systems?

How do you think about to benefit any more from graph queries?
* GQL
* SPARQL


Regards,
Markus
