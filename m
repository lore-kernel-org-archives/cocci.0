Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90762CEB2CC
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=84HzuTUXatMI2rGafeRy2WbN4Jl/YVWQrKkbXfOTZrs=;
  b=g7IQDC/fshucAivHUmIdqi9VcMRl3aeKYU85VyIvst0Gg+qgbTD/CcVV
   fYGv4PUZy7Qt68ebBjeYKic5f5sMAkCceBKNMpsicvwgRNOMoNwv91Iot
   CNGsSGA9nqqyoPs0amzhY7NI7vmyZakUjzbkduomwP+8rE0wFWMI/CNcz
   E=;
X-CSE-ConnectionGUID: KuGv0nG2T+KdOyezFLBBnQ==
X-CSE-MsgGUID: eHvgjSMDS+Kap0fua5heHg==
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
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="249316255"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 12:36:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BF1C3E0264; Sat, 15 Nov 2025 12:36:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DEE49E0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 12:36:11 +0100 (CET)
X-CSE-ConnectionGUID: FSOftS/ZTXKK0dyzwTzwzg==
X-CSE-MsgGUID: I1EpjwLlTk+30aDTOmEFYw==
IronPort-SDR: 691865ab_ngfsD2ibch3ZGY92AxuqjLR6zCObzY49MDSvQp3iXakhv3b
 YeiRhh/w9wI89wCfT4vlpZRIBuzuZHuppUVq7xg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FDCQC6ZBhpeAMP49RagQmEEGV7MwQLSYRVj1OCJIQ7h?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAwSCDIJ0AoxbAh4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CW4EsgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYbAQGCfoIjAQYQAQMPJwevI?=
 =?us-ascii?q?IEygQGCDAEBBoJp13YfLCJZgWQJgRwuhW6CZQGKZicPgVVEgTyCUjE+hRCDD?=
 =?us-ascii?q?oJpgiaBDplkUngcA1ksAVUTFwsHBYEgQwOBCyMPPAUtHYEkIh8YE2A9F0CDS?=
 =?us-ascii?q?RwGaA8GgRIZSQICAgUCQDqBaCIGHBICAwECAjpVDYF3AgIEghx+ggoPiTWBC?=
 =?us-ascii?q?QUoAgELbT03CQsbBj2VHlGBMYISyR40B4I4gWeBZAyfbAYTL4Nxk2EOBpMFi?=
 =?us-ascii?q?CqQXKlBgX8jgVwzGiSDNk8DGQ+SVMQfQjU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNZq9tXJ4Y0DCsKSJM/VaBIc
IronPort-Data: A9a23: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
 OnxUVYf
IronPort-HdrOrdr: A9a23:lcFv7q3H0Ij3RDLmv7jdiQqjBGwkLtp133Aq2lEZdPUnSL39qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFgrX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:C9pGO2Gpa+vwDyqdqmJJz2kaBvtiQEHt71SIL16qFlp7V6+aHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A3sLK5w9FTdaeKUA75ElhqLeQf+YxzrysF2QJrZZ?=
 =?us-ascii?q?F4JGNGRBXPhqzvSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,307,1754949600"; 
   d="scan'208";a="130915142"
X-MGA-submission: =?us-ascii?q?MDEhWNjb3iRWS0twd94fKNTkgHop9P++2WNIDL?=
 =?us-ascii?q?vpZ4E9W8/2ZQdhbKJ++J7tGovEVtQD1szLrANGJIRBZjAHi0CTPr8Qz9?=
 =?us-ascii?q?2HjgwdDV2SVdkzLJZsQhaAdpNOhbD1vKtYDxWamWtGbGQ3Q9AnF5B7BC?=
 =?us-ascii?q?DtjZhk28qiCK1dTiAHlLiLTQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 12:36:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763206570; x=1763811370; i=markus.elfring@web.de;
	bh=84HzuTUXatMI2rGafeRy2WbN4Jl/YVWQrKkbXfOTZrs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bmw/yzomm1IHYBbKyxM0Mvz4VxbgTkPGCO3M6rrIlFnnuiYhY4SXNjcVSrXb84C+
	 gH9n0a5OPiSIQmxxHqVVoC2p7/N3qxADf7dItbf+b+fC8msee31dPHqpFhyKAVOod
	 YiZEkB1aN+EbBT7A41tGeS2mWvpxQjctLXhN8KdWBcpRzEcIG/ruRgqgSCNggoXt0
	 bLrHhVTjJNSs62v+H5MlF/jomkrziQI8DYpWQA1xLdoHlY5fqeGuFUPmGtn5VLWx1
	 L91J+t6XJkZUEu3QCcrDdIqmNVJLWv1BzxDxKJckmOH9SYNP4bUSjkNoM65WdIpyV
	 AyaD1znwtO8Hyn6d8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWi5s-1vdxJK1Bou-00VGRR for
 <cocci@inria.fr>; Sat, 15 Nov 2025 12:36:10 +0100
Message-ID: <5598c4eb-8c8b-4fbe-918d-78509448cc22@web.de>
Date: Sat, 15 Nov 2025 12:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <a66f4836-8161-4d3e-b588-7990035ec436@web.de>
 <2010b4b2-9710-4501-9c51-3b3ccc30d6af@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <2010b4b2-9710-4501-9c51-3b3ccc30d6af@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bVgFJQe84oAIhOjE9b878y2Decd9QD2QRg4IRTLofNub6V+jdI2
 TsdMtSc1KOupwj3sGq30eYG5vvj+DSSmwIXys+kpIXaMiX+GF3kG3pqn1DvGInPrXDQLLpn
 dU6xEzTIjobK9Lc5RXwsYBbXoKbUkPe/8kbXHH7eQTIkNC8erru4Jji08t3p1d/qkRzJ0rR
 6X0oYFQdDvUm1xZ0qjFBw==
UI-OutboundReport: notjunk:1;M01:P0:AzEaHcFLqo4=;gwMDqLJf70WG5AwRQYl3do/JcKT
 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
Subject: Re: [cocci] Reacting to negative source code search results with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3178
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/5598c4eb-8c8b-4fbe-918d-78509448cc22%40web.de>

> How will chances evolve for further software improvements?

Corresponding development ideas might follow another SmPL script example.

@my_test_search1@
identifier action;
@@
 action(123);

@script:python reporting1@
id << my_test_search1.action;
@@
print(f"The call =E2=80=9C{id}=E2=80=9D was found.")

@my_test_search2@
identifier my_test_search1.action;
@@
 action(456);

@script:python reporting2 depends on ! my_test_search2@
@@
print("An undesirable function call was not found.")


Regards,
Markus
