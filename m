Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ACAC369CB
	for <cocci@archiver.kernel.org>; Sat, 26 Apr 2025 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=C3N76Sme+jm5pqtljAyVRMBnI1SN83gTe6Fj9+clOPQ=;
  b=iQXrjAMojhcUJMuKPaivWYceTq2SffhrqBq4Rqt9dJiD4MkmefXeTJBH
   5fYuTihm8p5QLD8KA16uIKx6nNf2o/NndttsAnERZDVY/VnpUtxE9pKhD
   OywtrJc84uEnAUVH/JACePcbirQyna+xjQJabFLhNQdbJ0SCFhy9JJPpq
   w=;
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
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="219545135"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Apr 2025 09:48:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69EA4E0261; Sat, 26 Apr 2025 09:48:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40FB9E007A
	for <cocci@sympa.inria.fr>; Sat, 26 Apr 2025 09:48:38 +0200 (CEST)
IronPort-SDR: 680c8fd5_a025ThLonVJUuPdkaqjWet2K/H0XoP9TIfcK2ORwR7HXl/q
 EESQcJ5YmjgxFa6brZvdxiiMQn32J9P75hDviwg==
X-IPAS-Result: =?us-ascii?q?A0G7AADcjgxogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgVczBAtIhFWPUIF0LQOEO4c7h1OEb4QGg1MPAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEggyCdAKLMAIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdA?=
 =?us-ascii?q?QERJwQLCxoCJgICVgYBFAEBgn6CMAEDDiMHsECBMoEBggwBAQbaXB8sIleBZ?=
 =?us-ascii?q?QmBGy4BhWyCYwGFbDuEPCcPgVVEgTyDAz6EQ4NbgmmCMUVSik6DE5BtUnscA?=
 =?us-ascii?q?1ksAVUTFwsHBYEmQwMqNDEjSwUuHUaCBIUlgg+BXAMDIgGDE3Ycg0aBI4RSL?=
 =?us-ascii?q?U+DL4IDTho2HUACAQttPTcJCxsGPZZeg2eBAhMBCkHIQzQHgjiBZoFkDJ9eB?=
 =?us-ascii?q?hMvl0YOBpJ9LphQIqNzhSCBfSSBXDMaJE+CZ08DGQ+OIQwWhBGxIUE1PAIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:tpA4TKAcpVNr8YflHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:MErwSGwDv8CPkvRhzp+CBgUoHsw0eHrP9UzeLhWyMmVoV+WEV1q5rfY=
X-Talos-MUID: 9a23:iditpQWv/zQmM1Xq/Bi3lQw6BOF12K6nJxwhoZ8JtceLJRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="115228696"
X-MGA-submission: =?us-ascii?q?MDFNZy7maTwXXYNOAZ4qVkXXj4EaUNSOzoYx15?=
 =?us-ascii?q?VRfWNC/UDRo9j/yrWKKdSpE4TOSqqV+erACqg9mlCrDRPwsUEuCHBv7+?=
 =?us-ascii?q?huP3MmPfyL6vGqZlTbLxsj4qhFR3nOG86acwvwtv4SdIA1Nfe8+cAWbT?=
 =?us-ascii?q?rmr/MLIi0RpuxWuCMPWjLGUQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 09:48:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745653713; x=1746258513; i=markus.elfring@web.de;
	bh=C3N76Sme+jm5pqtljAyVRMBnI1SN83gTe6Fj9+clOPQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WD0HbjP6KaOugDPMf4NTyK/KSKFeXJTOFuiLN8M3OeLqF8qIFJoOzfYH7n/HDpM4
	 3+aySluFVaT0VoNB5ufuX76gh4XVg2SWAeBX9mdFvS44Ui8suM99GVDmi030bKjCb
	 qdvbnHzG5MBnw8/9KACvpZ1NPDK+KZ0JLCM3r0WxnmbIP1Fdb4T0s61ohqckz86fw
	 JPpT88OomqGaDf75qmHhoO7BlS5GWqCY0ssS79hJG1C1WOxjvpgx73CmGpL2WNOnr
	 2cXTTeBRUSiTZt7x4FIS6tLHzOvKw5GLPkfZLmJWHwur0breN0WQy34GsJqLv7BCh
	 VtxTo2xCEbmKdmurIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.20]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mhnw2-1um3ov191s-00bPLg; Sat, 26
 Apr 2025 09:48:33 +0200
Message-ID: <4acfad01-caca-412d-8a57-9e7ec378f0de@web.de>
Date: Sat, 26 Apr 2025 09:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bernd Schubert <bernd.schubert@fastmail.fm>, cocci@inria.fr
References: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a4uR9Tx7cFJNPUnFxAFMDDegCnnXivSDLCEsbzsFuFnK9zm9Y2c
 +R8CMVZ7GRmAhox/BH8BxWaZxk+KeiK3Xr+x18T3BuxSns0m/Q/2qztlbKk7KmVvcpxoYxS
 Tk+qln1hK85NMPxqyaF2xo4FDLt//8qnyI9IZLEX+5LFgX7zxWL5xMnuei7ph5Bnt2eTKMr
 Pzfdk+r9cg7/tFxeLCy8w==
UI-OutboundReport: notjunk:1;M01:P0:M12dzzigUIQ=;w2DKxZpU3UQttWlrHRyXwlE4buD
 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
 XirVmvDvF4r92nloF15u+L97FO0W1YKhQ2
Subject: Re: [cocci] Fatal error: exception
 Coccinelle_modules.Common.Impossible(126)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2722
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/4acfad01-caca-412d-8a57-9e7ec378f0de%40web.de>

> we just found a simple reproducer for an issue that was affecting a few
> of our files. At least I hope that this is the only issue

Thanks for your bug report.
It will trigger further development considerations.


=E2=80=A6
> } global_instance1;  // This form causes Coccinelle to fail

The test case can be reduced another bit.

SmPL script variant:
@display@
format list fl;
@@
*MY_REDTRC(..., "@fl@", ...);


Another source file example:
struct my_example : public my_base
{
 my_example() : my_base()
 { }

 void do_something()
 {
  MY_REDTRC("Testing %d", my_member);
 }

 int my_member =3D {42};
} my_var;


Questionable test result (also with the software combination =E2=80=9CCocc=
inelle 1.3-00083-g4093aad2d=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --c++=3D1=
7 test2_for_Bernd_Schubert-20250426.cocci bug_example3_for_Bernd_Schubert-=
20250426.cpp
=E2=80=A6
warning: display: metavariable fl not used in the - or context code
=E2=80=A6
Fatal error: exception Coccinelle_modules.Common.Impossible(126)


How will development interests evolve further?

Regards,
Markus
