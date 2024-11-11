Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80567D3ABD1
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=a6ugSoOmUN6C5FYWRt5iDuZ3hXYKrUdnMtxW8i3MIMo=;
  b=su1gF3E3TAC/qNuGeP1yHv28uMcpUoAVVsGmdM4U4lGL3e+/IDJzbXI3
   se/+U3Ajp9QIIZx98UE71UkKb7RXYr1o3aNBL8d70UosDh+gP0BMnEGTt
   1X4lPJYP4CPfdh9SNWjP/Gp783Q3affsJqGJBaRBcmS07taW8WkrQ8se+
   4=;
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
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193202364"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:19:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD50BE013D; Mon, 11 Nov 2024 18:19:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A51EBE00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:19:54 +0100 (CET)
IronPort-SDR: 67323cba_objaCocTRNI96zqYfn7+ryEIM2qDVLXYuGxxT5jS7O5Soen
 pI9Jmpv7D6MECmPajRmKlP4ZaiZ5DcLcuOq6PYg==
X-IPAS-Result: =?us-ascii?q?A0GlAAAgOzJngA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYiFUMwQLSIRWkUEwhDuHOodViHWDVA8BAwENQQECBAEBAwSCD?=
 =?us-ascii?q?IJ0Aoo7Ah4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBOwcOCjGFQQgyDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?ScECwsaAiYCAlYGARQBAYJ9gjABAw4jB7BhgTKBAYIMAQEG2lsfLCJXgWQJg?=
 =?us-ascii?q?RouAYVpgmIBhiSEPCcPgVVEgRUnC4J4Pogegkcigkd8hCAliC1omFlSexwDW?=
 =?us-ascii?q?TIBVRMXCwcFgSkiLAOBeld/gTmBUQFCgl1KgzyBXgU3SYJKaU03Ag0CNoIkJ?=
 =?us-ascii?q?FmCT4ElBAWDb4ELg2SEZ4IjHUACAQttPTUJCxsGPZ90hDwByGw0B4I4gWWBY?=
 =?us-ascii?q?wyfVQYTL4NxAZNNDgaSeph3IqkBgX0kgVwzGiSDNk8DGQ+FTohThC3FKUI1O?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYlvgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:iXl3GakdwzX2ka/r9ufYEEH/SsrpDfPaimdD5ihNYBxZY6Wkfp
 +V8cjzhCWftN9OYhodcLC7VJVoj0mskaKdkrNhW4tKOzOWwldATbsSlrcKrAeBJ8STzJ8l6U
 4kSdkHNDSSNykEsS+Z2miF+r8bqbHpnpxAx92uqEuFJTsaF52IhD0JaDpzfHcGITWuSaBJd6
 Z1saF81kedkDksH7OGL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftzLLhCRCX0joXTjsKmN4ZgC
 H4uj28wp/mn+Cwyxfa2WOWx5NKmOH5wt8GIMCXkMAaJhjllw7tToV8XL+puiwzvYiUmSAXue
 iJhy1lE9V46nvXcG3wiRzx2zP42DJr0HPmwU/wuwqQneXJABYBT+ZRj4NQdRXUr2A6ustn7a
 5N12WF87JKEBLphk3GlpX1fiAvsnDxjWspkOYVgXAae5AZcqVtoYsW+14QOIscHRj99JssHI
 BVfYvhDc5tABynhk3izydSKITGZAVzIv7GeDlIhiWt6UkboJgjpHFohPD2nR87heEAotd/lq
 f5259T5cFzp/8tHNxA7dg6MLqK40z2MGfx2TGpUCDa/ec8Sjrwl6I=
X-Talos-CUID: 9a23:0AgGoG5dGAXyiIt7pdss/msEGvoLSVjmlSnAf12aG300Gbu1VgrF
X-Talos-MUID: 9a23:w0Fa4ggUkqgDVXIJmR8sd8MpHZk2urS/URw0z6ovhtutJXZaJW6Gk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="101282039"
X-MGA-submission: =?us-ascii?q?MDEpMyZHELaew6RmF2mSWyoevSqcqimBDMpLcW?=
 =?us-ascii?q?r9LrQmHbuYLF+4zGtUXWkKUzHAKbd8hD7v+x4RMPBrTMrkRaFNFmIfsB?=
 =?us-ascii?q?tFdhxmmR+xYj/+1YGOUxrbSeVnKASWHl5yVPSnoxHfm/30RBn8CHxNj6?=
 =?us-ascii?q?tKcFxlK4aVk2TnljrRm5tfXw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:19:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731345593; x=1731950393; i=markus.elfring@web.de;
	bh=a6ugSoOmUN6C5FYWRt5iDuZ3hXYKrUdnMtxW8i3MIMo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vlYgoxjgAnn+CIQleuMX94Wc2dp27zW+PFg2EULkrfouijEkJ/bQPUZoCzst7/BA
	 jqfQD4FRN9aenVCvLtZSA65KhmgVWge0SIyyhPemQxZWE3FLGLuSwAumJt9/+aQ8z
	 Ccg4j+niKB+fElFf+KfsWipdtmT27FuuAO4iP49rWd/I/7CWJCs43GNGI5CbAYLF5
	 +8wS//8QKPShbu1TfpkSmfaxGwaaxHYGLIYNFERHeCePaorA1g0ABohsm8VDTxh+s
	 ttnWW5iv3pWU8UwEARufFOuK61ZwM7sFq0iqWjWYDTMFBVKfE+CvKmjmUPkmYXYCl
	 MVQnrb0AWP+ElFOruA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Madzi-1tlWip256I-00p7HV; Mon, 11
 Nov 2024 18:19:53 +0100
Message-ID: <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
Date: Mon, 11 Nov 2024 18:19:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michele Martone <michelemartone@users.sourceforge.net>, cocci@inria.fr
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
 <20241111171232.GE10291@localhost>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111171232.GE10291@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37H+XkfISmtsQ9s9T6ATDVPUz6lbRVVqWczXFaD8yKrOa15DT1d
 Bi6Q1mADS2xp9xwqQ/CyUtK2HMEJ2vZiEewHies6TUO2v/wHDgLql5R1IxefqQuhKW9JuiQ
 JEk5T85ECMLSs5qpAdhEGBMh7ApYaXZzCdI/ilfNNyDaBDWWzUql950tB6rHFua+sOtCqw/
 KDa5ux4nGeqT1ajx+gdeQ==
UI-OutboundReport: notjunk:1;M01:P0:Z0KCobi5cLM=;o5QTcX/D9pnkiujsNeCPgzPTK2s
 D2KFJH4TS2RQe5JFIEPUhShaXd/4Ev/CTeSzsVzoNNyw47SUHAZ0vdVIpd98AuMvfupIOruya
 A7qb7Dg6OGz+VOCLDO/atxdPrSSlNs7++tf1QHw10p80xyquhPBH/1F7Ouu6KsrQxkwmpU4F4
 rutCxoQNbtZuA0hmzL6dE74SqIr07KThx+ET8bU3peLfKKwPv0Kb06RCn/cFlZNmSDfxJ3CqL
 waTIGu4GFm1zdvEwqAvn20/iuWtXZUl+LfOVOyYAX+Hw35fboNuA1XRShEZl7E3r+nF3KKQqD
 oeAstJxhdF4nseFtyzowaA3u3VJjymIjFH85VNdx3QFtuTADOtw3C5WqQhiC4+uDFy1RFJaFL
 avMwyIdVvulpjcnqyd8GtPOFZ+oMVEhXcE6FYDWPhUucFSIBBVqV9gfamvPDmLhT46kchNVSr
 REtyP0r5IBq/k/R5mB59YRcEngifLsRsMMCtcWoatlSsHHUnacepf047FOfZYIXi2CHThCkMX
 M1kbNR3fUoHc/pQU4igY1j0CLVCatxQ4/jk9chQWj+tXb/6E/Qop1/C2m45w+jUZxoq3/srwa
 PXzq/BURn+yp/DLSoHlxOvf6chh6Zts5L13FI6i58lgSLF6s8QGfzuTSC1+80N3Dha/xf+Xbu
 m3rFcx59Ua7Lg0+7icnfq8XPkmb4OSBGzo12mG5XYm+hArrhFmSHj+aPbmieVSeSzvm8Wmf1J
 NnhUkDzuGZfZ5+9y7TBPZQ519/TNEd75k2mj/nAJfuRvV2x0OOCbvVLGZWlDB0mxJVsk1t5hQ
 HpjnySWs1LcqHiw2N3kTuMBfnlKcA1kW5n2yszxLOjdoWjYCAjTuNRZtGcnOsOLQiGohhX79n
 1qgGjem+YYAgIPwlQSohYfh8JIZUQmMwvkoqV+DRNydi3Kf3HiaOm8Cdn
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1990
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/a03b096b-8815-430e-bceb-9e04248c1831%40web.de>

> If you
>  grep '^[a-z_]*:'
> through the *.mly files you get a few hundred non-terminals,
> each with a handful of production rules.
>
> In a few words: LOTS of rules.

Is such a software situation influenced because of the usage
of the tools =E2=80=9Cocamlyacc=E2=80=9D?
Can any advanced tools help with data conversions?

Regards,
Markus
