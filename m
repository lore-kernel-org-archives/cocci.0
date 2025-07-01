Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B45C83038
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=l9+dE225vvaEVZe5YYX5AriqraZ9FSmG6ob+NjIM5zQ=;
  b=GV1iXotH+upggRDsaiRadhLAXgA3e0T7nKw7rMCgbf61up/p2PsEsUCJ
   D6/8tgSumgpYyKP0BNlozX7fKPFwTEyVG21E6sBX8ZI8J6FlwgSf4B1VY
   EMWkngFTTZhMSjOY1lmm6Ec9wQ5+XwswOsuXKbMvU72AtiwEbjMub9VYs
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229822347"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 15:51:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6AF63E0AF1; Tue,  1 Jul 2025 15:51:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 33CEAE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 15:51:11 +0200 (CEST)
IronPort-SDR: 6863e7b1_JYGTsQU2phuav5cds5eTQyE3LpFy6IAstX6e422yvBSVMB+
 TMMhZ898QWrAB9rHXXwJ49XGWdPrDL1gKG3fKVQ==
X-IPAS-Result: =?us-ascii?q?A0EeCwBF52NogAQP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSFAAKLdAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgImAgJWBgEUAQGCf?=
 =?us-ascii?q?oIiAQYQAQMOJAewEYEygQGCDAEBBtpeHywiWIFlCYEbLoVtgmQBhieEPCcPg?=
 =?us-ascii?q?VVEgTyDAz6IHoJpgiaBFoR6kzNSeBwDWSwBVRMXCwcFgSBDAyo0MSMPPAUtH?=
 =?us-ascii?q?YEnf4FNHIMJgQ6ELCtPgiR1gXlBGT+DVB4GbQ8GgR8bQUACAQttPTcJCxsGP?=
 =?us-ascii?q?ZJbzVQ0B4I4gWaBZAyfaQYTL4Nxk1sOBpMCmQUiqRqBfiSBXDMaJE+CZ08DG?=
 =?us-ascii?q?Q+OIYQzu09BNTwCBwsBAQMJhUYBAYgMgUsBAQ?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGz384sYWQcTZepvvDQ==
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:FicvzqC2wwP/GdXlHemF55DYdb4zR+YMi2TDpHoBNSC9E/bo7/
 xG885rsiMc5AxxZJhko6HjBEDiewKkyXcW2/h2AV7KZmCP0wHEQ+9fBMnZsl7d8kbFh4tgPN
 JbAtVD4arLfDxHZKjBgDVQa+xQu6j8zEn+v5ag856zd21XV50=
X-Talos-CUID: =?us-ascii?q?9a23=3AVbgrW2rR8T7gLwN21LwGSLXmUewuLEPQ82/UGmy?=
 =?us-ascii?q?5LUl2UbySY1OX47wxxg=3D=3D?=
X-Talos-MUID: 9a23:GWi9pQgG4tY1OaZ9LEquwMMpHsc1/YulV2wxjYgguOu/aCpiGwuDpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120409920"
X-MGA-submission: =?us-ascii?q?MDHLdOPH//HraA4uyPZ22DEVsSWR1VXQHluH6+?=
 =?us-ascii?q?5sUUPdyA3BKaGinctpSjJpHNcTC4diGGSyRo+4gw9DTHc5MrbDldr6rs?=
 =?us-ascii?q?/PZNJJUd1BxitGLW/xazuKufxaOcUJ9as5EcAZgxj5WYEZv6CzQSyZx8?=
 =?us-ascii?q?5n4PxFmE3Wk8IXo+xnC5xYSg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751377840; x=1751982640; i=markus.elfring@web.de;
	bh=l9+dE225vvaEVZe5YYX5AriqraZ9FSmG6ob+NjIM5zQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r9OMjvPvyQAoJikyUuqB1/A2/U/eeENFTofIQF/lkh8SW+4lKhYlyhQFrEZoIep+
	 WWN6XfmzEAFRElRBqNibhUXs5az4My4Nf5CYhpEg3cfx8QaCZv5yC2NFpjnT8KWi/
	 qgBhYpSzh/1EHMeXGZEx3dRpPAMrYiIDdBEIASe7aKN2vIaYfFr3tkEw21m8n1lHG
	 Y3dVVdZt1vV0W29jYDnnMqNzHIdjKCNmO5kJa9owiGeCGPmHhIjqShHdMtIKjO2RK
	 Y7YMzSnTSfZy73vq8q5MmY8f3Rz7w1DvixWnQIIx63kV+U0lG51et9grNB0G7sh2O
	 YQs3KMsRs1hEn1L7VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1uH8vo0HGa-00XypC; Tue, 01
 Jul 2025 15:50:40 +0200
Message-ID: <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
Date: Tue, 1 Jul 2025 15:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/x7Ky/7M85crs4uEn1A/tTKO6Go5XQfMJiSSc8YFibL8yr6oM2y
 m/UgdPP5GKbG4VN0gYV6RrCa794mU/T+TNRs7SFq2FUO7f8zN2c1wdh/AFY+kXRurFCghqN
 cPzqqHhofM+ePi+5BG1dLgxHO6COBEMzm5QOz1WUon3lQ1JmE0j4J5aAAfk6wUaneZp/tqZ
 ttoT/2KWfKCjv31JEVPVA==
UI-OutboundReport: notjunk:1;M01:P0:o+eOGltQh4E=;KPvfvDvZ2qC7dCGb+BdMAb7S5B+
 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
Subject: Re: [cocci] Searching function implementations with more than a
 single return?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2840
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/65638cec-fc36-44c0-88ce-f9678a0a1d53%40web.de>

>>> Another SmPL script example:
>> for further development considerations?
>>
>> @display@
>> identifier i;
>> statement s;
>> statement list sl;
>> type t;
>> @@
>> (return ...;
>> |t i;
>> (
>>  <+...
>> *s
>>  ...+>
>> |
>> *sl
>> )
>> )
>=20
> This one makes no sense, because return and t i; can't match the same
> thing.  So the disjunction has no impact.
Would you like to suggest the exclusion of a single return statement
by a more appropriate source code search approach?

Regards,
Markus
