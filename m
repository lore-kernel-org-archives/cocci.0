Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2A3D13572
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ql7Kj8YUUAmDN617LqIr2JRipTixg567q1Y/AEAe4tY=;
  b=ToWoFJZbL5FlvC7omIlkt4LTQ6TtKH6K206WqspNDj5H82fna5zXmarJ
   vKOa01fu0UrcMVpC0B9x+YNS+JyHPjgVq0adM8DsOE6E6auSkbNLAS5ug
   0xgLi8w3NrMYQWlkyBiPIrJMV+6Db3nWLlZugrm6oyJQ4HI1TiHjWkqLL
   c=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190930720"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 18:28:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DFBCE0D1E; Sun, 27 Oct 2024 18:28:23 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77A8DE00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 18:28:18 +0100 (CET)
IronPort-SDR: 671e7831_TxuNwLLjHNv9ByJw6+kuxSqWobErxpuTNVG+/iN8V+eLga6
 PtLWfmGpEfkCDvLkh5vnIyLA2lb4mD/pyo1vKKg==
X-IPAS-Result: =?us-ascii?q?A0EFAAAsdx5neAwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDYhtaMwQLSC2EKYgdhzCBdC0DhDuYBIFWg?=
 =?us-ascii?q?X4PAQMBDTsGAQIEAQEDAQOBSUOCdAJ3iTACHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAUMOCjGFew2CYgGBCRt0AQEBAQEBAQEBA?=
 =?us-ascii?q?gEBASICAQEBAQEBAQEBAQEBHQINOkQBAQECASMEGQEBESYBBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfQGCLwEDDiMHDQavMH8zgQGCDAEBBtpbHywiV4FjAwaBGi4BhWmCY?=
 =?us-ascii?q?gGGJINCeicPgVVEgTwLgXZRMT6CYQSBXoNbgmmCVYdgJYEahx1qkUFSexwDW?=
 =?us-ascii?q?TIBVRMXCwcFgSsmLgOEblt/gTuBUwFGgmZKg0gcgUUFOEmCTWpLOgINAjeCJ?=
 =?us-ascii?q?CRZglCBJQQFgzqCOR1AAgELbT01CQsbBj2bU0eCRhmBAhMsgUVIbaJToms0B?=
 =?us-ascii?q?4I4gWWBYwyKJ5UuBhMvhASTOw4GMpJGmHcijVyVE4YQgWc6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIQwWg1gzzBVCNQIBOAIHAQoBAQMJhUYBAYsxgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U/KelY=
IronPort-HdrOrdr: A9a23:Dcu7CqMO4SRE68BcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3APKIoSWo4OEMaTXrf93W1BtvmUZl0ViaE833xH2S?=
 =?us-ascii?q?DUV9RUpPNY0fO9Lwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AWg+O/w6jDjVQ0U7x+FJpr6EDxoxR5q3xUx1duK8?=
 =?us-ascii?q?snMOEdgJiJS6FqQWeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100141456"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDG0jVheHwd+RVL17PBbzfDQ0evHYWxxlkxq79?=
 =?us-ascii?q?eJ7NZjtVYzq/JwpLhxRLnNzoQZl4qvN8ygcEzuumwi+XOKNZK+n6V0Jw?=
 =?us-ascii?q?/wkfHY4EEPz8+8ZDtm2rZDRr9n773v30J2vDpqEY4TZRfWPA4c8dGaxH?=
 =?us-ascii?q?TicMSGrPTnBGx2Gl9i3aghWQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 18:28:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730050096; x=1730654896; i=markus.elfring@web.de;
	bh=ql7Kj8YUUAmDN617LqIr2JRipTixg567q1Y/AEAe4tY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I82+YSLQw4tyFVH0TxbvCSQf3clCTEkStgk/Pa5GKgFs31vh/d1asgf+3DGmgvcH
	 Rct0o9nznsCD8yR20+Fc0Rw647xfYUP6ZB8iQOj7iaP4E+DzGxHslcXXe+mEsNKkS
	 z1BrNnHyA7eO9o4puKgtsFBvJ6DE7PT3hfb9mBveUYxb7/T89LhdPH8vNUeiqObV/
	 DhkIOe4J20L0Dtc1zpf7uQ8ovPxnw1QwFbisQCBm6z6raruLcJsZ17En/TmwKUt+J
	 UemNp/zwruCUW+kqckMGtEDE0fj6h4nu1+Lbmci9l4Z5sPVD4MEEoPNLqg7baXvpA
	 /i4ZZH+YtWFQ0b47yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1tHPHR0GP7-00QSiS; Sun, 27
 Oct 2024 18:28:16 +0100
Message-ID: <4893c41d-bdaa-44b9-9381-d04bde2fedd8@web.de>
Date: Sun, 27 Oct 2024 18:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vwqdw0KDHJWFF97d+DtDU/X6K+tix54tc8h2QL+AEg0ZfASbERZ
 tWcB5nmag6TZjISP0ZJgDL7xbLtel4TGqaSUGf34Dwze216hfJ547uQbP51jM2ChAY+47Ds
 o3WdRjolSasXx7KRStHoRbH56kychpvKZ/cmf8gWyeC6twV5cSjryqE87STVmVfdKnq7nEE
 8s8VwZBxXf9hbEUulLDHw==
UI-OutboundReport: notjunk:1;M01:P0:b76P3fjuLKY=;OJOvUPEkgQJwXGtqhcBuVB2oT3w
 Fhg4iUnW8nOG91F5a7g9AH22LRHADofMqDk0+e0pCzAQDQWOEEuXExq9EqKEbNyi0jHdh+w/3
 UDBromVCKYXhKUU8fMPmAYlqN5cjtLOdcdzBo5zukb2dhSJeCP1OslNhc9/4lQCdpIHS6ZH0i
 +TCX9C3Ma6HSyv3NZ5EZIfKrJyuKkL50V5D2NrhLW+JTfOSvWrWrNamIuU8Ff3E1P1MFCVBrs
 xqZHDSfyQftJmn6+OJIli32AUQFqCUPy8Lu/3aAlS+qhfYWjlw4tKktDyZ8ypkwDn7KcYC/qr
 hzj4V7+bc6Xek2Ns/piOJ6PDJ889yML86KrvKl6XdWdpfMrBrnfNJu8UT/QU8isD1Pbync78I
 dmwk7RY6smTW/cvr4Colf2xjJ/njL3st4+i1llAP+Zypb8C1OsgN+vr3u4ZJC1kJh/8eJ1zgv
 dAKKkOqaVCRibKP2kPpw00Qkwbt/Yh16xujOra9fdXnMHSBAydVx0uNa3DmJF1sCNHFhPYID8
 sCWfapdsIuu/gwc4haQNOeDpMGDPw/I3K2bzfkUC/dWu3Zj9dIzMCsGrgLBc706dfHQMRHr5o
 iWTvslACqOb5kY97bDCT8ZteQxBdOGt5JAy82i2X8VhxvPHyf3lkJZ5hrZRzMn7SOaEjsi30N
 M4bHlvnje6NN4xB0oe+z0FqMCQEQsVCyk9VNxhckyvURJ5OivyDvoKhUKuImuA8GkbKdxbV5S
 Qjt5tn7hGOk3492v5fNHGwVat8V/rxgDnOSvTqpXsFudpWvXSh3xfTEayx8P44J69myvIiAnK
 HSsSQ8p1BYk1OOgMEo4MfQtw==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1948
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/4893c41d-bdaa-44b9-9381-d04bde2fedd8%40web.de>

>> =E2=80=A6
>> -> duplicate data
>> file:
>> arch/sh/drivers/pci/common.c
>> function:
>> early_read_config_dword
>> line:
>> 36
>> =E2=80=A6
>>
>>
>> https://elixir.bootlin.com/linux/v6.12-rc4/source/arch/sh/drivers/pci/c=
ommon.c#L33 :
>> =E2=80=A6
>> #define EARLY_PCI_OP(rw, size, type)					\
>> int __init early_##rw##_config_##size(struct pci_channel *hose,		\
>> 	int top_bus, int bus, int devfn, int offset, type value)	\
>> {									\
>> 	return pci_##rw##_config_##size(				\
>> 		fake_pci_dev(hose, top_bus, bus, devfn),		\
>> 		offset, value);						\
>> }
=E2=80=A6
>> EARLY_PCI_OP(read, dword, u32 *)
>> EARLY_PCI_OP(write, byte, u8)
=E2=80=A6
> OK, that was much more understandable.  In general, we don't make a grea=
t
> effort to give reasonable results for macro definitions.

Under which circumstances can this situation be adjusted better?


> I don't even know what result is wanted?

The discussed source code search should be restricted to function implemen=
tations
(which would usually not be generated by special macros).


> The starting position of each EARLY and th ending position of each )?

Obviously, this description does not fit to the desired data processing go=
al here.


> I guess the problem is that EARLY_PCI_OP is not recognized as a declarer=
 name,

No information =E2=80=9CSPECIAL NAMES: adding =E2=80=A6 as a declarer=E2=
=80=9D was presented for this test case.


> and so a parse error is found,

I did not see such an indication so far.


> causing the macro to be expanded.
The mentioned test output indicated a questionable function name generatio=
n.
How will the software understanding evolve further?

Regards,
Markus
