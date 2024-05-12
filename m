Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D73C25B4F
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RngWhit4EWS19TeZkpECgBVPFIk0woq78vTOO2iQ7fc=;
  b=XmaHQbZMdloJvG3ZlLa4o2NRIPKWPCX+tWN3+VWzWBAwmzoSLKTKrUz3
   BhnPLtt4F1pmqt2nxkOg3qIFKZXSvNnVsHEvr/RLvJZyFtroMip8OTMps
   7EzxQ309Wt5+SDbCcc4cBgbbMol/Qrj+v6QVS8FOVdvn0i21OZVZ1hH9d
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
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165246033"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 15:22:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08F5BE0CCA; Sun, 12 May 2024 15:22:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C39AE004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 15:22:24 +0200 (CEST)
IronPort-SDR: 6640c28f_TrvuEm8R2nyH0UDOa2EfUqJskY05pKIsMWSUh4doaWyliVe
 89TFvmKkYl24z2AhUcawcSovsDAE8Gv+XCe73og==
X-IPAS-Result: =?us-ascii?q?A0EiFQCAwUBmhwwR49RaHgEBCxIMQIEqJ4FaAmZ8BFQzB?=
 =?us-ascii?q?AtIhFaIH4kehGuPCIhxgVeBPz4PAQMBDRQBASMIAQIEAQEDBIILgmoKAog9A?=
 =?us-ascii?q?h4HAQQ4Ag0BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXB?=
 =?us-ascii?q?w4QJ4V0DYJnARCBDmUJOAEBAQEBAQEBAQEBAQEBAQEBAQEWAj0KQgIBAyMdA?=
 =?us-ascii?q?QERJw8LGgImAgJWBgEUAQGCfAGCLwEDMQcNslWBMoEBggwBAQbaWR8sIleBY?=
 =?us-ascii?q?wMGgRosAwGILAGFfIRAJw+BVUSBPIJSMT6CYQICAYFdg1uCaZockDlUfRwDW?=
 =?us-ascii?q?TIBVRMXCz4JFgIWAxsUBDAPCQsmKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBxE?=
 =?us-ascii?q?QMEGgQLB3WBdoE1BBNEA4E4iXUMgy+BdSmEHQhDbBWDdYF3DmGDWIROZoEnH?=
 =?us-ascii?q?UACAQttPTUJCxsGIgEdoyeEQzhOxy80B4I2gWCBYQyKIZUjBhMvg3KTRg4Gk?=
 =?us-ascii?q?miYYiCNVJsTghMMgVwzGiSDNk8DGQ+OIRmEFIRhxkdBNTsCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGDWoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:kc3+/K2mFX6mylHG/3MmFwqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:l6AZSmGEaGTDMleYqmJi21EIJN8vf0SCxWjBHV6ZNF57c6GKHAo=
X-Talos-MUID: 9a23:ckqIlgrxSeBPWxMsqo0ezzNFPfo06bmgMhkMm8taqZjfOj5zODjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86803969"
X-MGA-submission: =?us-ascii?q?MDF7crE5o53i1QFfAls2wuevQYRQ/Rxqaoe0KU?=
 =?us-ascii?q?AkoDPeINbOOnT2J0G1z9t/JgwY+FtADIYR00UdFtjgTwl0AVJHhy5IPe?=
 =?us-ascii?q?H+pDehRqMvY9qFzgAh+m8l589sc4lYm2FqPHcH8J1yqfKTBtgywOa+iL?=
 =?us-ascii?q?DMFKLtId+ShXSdcISDTv6JKg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 15:22:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715520142; x=1716124942; i=markus.elfring@web.de;
	bh=RngWhit4EWS19TeZkpECgBVPFIk0woq78vTOO2iQ7fc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oYX2MlwLaElZ0VqX+gKI7Pm1rjPvosC9Y0xCXY9zIonpmdnLnuz/S+WFz4XQCH78
	 SN35eOf6RwDcBn0oe0WVUDuLlKywJ1s5PaQADgA/REJ89VUNCQirOAAapH4clJHpe
	 uDIkz/HEiUu5HKZ9EPelHbVVWRy9ikCetheu1vM/SxIuBB3ZWO1ZNeNJt9MtPBuY0
	 coaHXj15KsGaM5gYX2vtlR4tk68oGXwxZS7fh924ERFLKvC9FEhOmpMMfjadqCnw1
	 dfkP9WtSuZl3XOf8f5IPoCtYiYHioR3TUTtgs0/gBv/cJOrGGzY2aR/Gr8qcVlgZH
	 fZxEC3TFil6VnzWiHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1s8M4s21jk-002EKc; Sun, 12
 May 2024 15:22:22 +0200
Message-ID: <6fef3af5-1e3f-48a0-b026-aa5219a27057@web.de>
Date: Sun, 12 May 2024 15:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <ac4b8c84-abb1-496b-9377-4f47c1f7cbb0@web.de>
 <alpine.DEB.2.22.394.2405121451530.6747@hadrien>
 <ac848508-8b0f-418a-a2b0-45cd68176d7c@web.de>
 <alpine.DEB.2.22.394.2405121513320.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121513320.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iqtjXLo9at7Q2R49yQxqi0Tvyka42oQXgq9m4VRqu7MRiI+AS8D
 OZGW9+E2dPD9OAvd2v2IRJr6H6mGfCKHDTNCxwmKY/GC551x9dXpHQb2rvQ3eqjnZNeKRDu
 9sLNx0VilXE9vNgEarXSoUGR0A75hLEJwW1JZp3BQs2BaUGKm+zlKdyNzN87rDkQMpp37ww
 5mRwMLzIW5FXGSwSE4CZQ==
UI-OutboundReport: notjunk:1;M01:P0:i+jnzlNoteA=;2ZAGDP/WXJLlwDGZkv4mK3a/XyX
 Mfs72Um1Ty5jymOhe0qKRenWHWpf94nNB0eD45A+zoIPxpNsKsGhb6kmQo2E1VHabLoWy9ln4
 v+qWHVSodOJx0HRnj5Urj5FJTx2u4s1/H/QQLID/oS0S4PCGB0weuC+4aMnT0INTF441iqcUy
 UcilMB2JfWewTcGghlVoFKdlq7nzeBpJTsra8s2/rqcMW8Usrq4OYLfXlU9DjNMSqGdAu6ppS
 +WZgUvyja19R+6DOEwLD6t7sM4z6q2jYVImvUMzfd+nwRQQE+UH9QznzLZoydvcloHp/rsny6
 D2Swi6EueasjvmSTKDLGa/GjAVcT4gFzbd42z6EMaHC37W08OZ2VTW3nVKAEnDns/ZDHw0bUr
 X1jIzqDYFA4iSHUv6oxr/yP8X+SR8O6MbM1TQVTVrUW75syXaPoqBfQbgek8sP1QsYp5xpBiv
 4mKzxfVIraJJZAfPzAE0uk1b1PsRNDCk3N4HzlUi/kj4GEt/3VGt32KRIbx/Iq0eQKBMXNtJK
 qb/GODWWZJBCaX4HT7URNye1YOm385xmVQ/+elH0xkuRueWWcvaIoyuK896bqP0y50iwuBTgf
 PXTYVI/XwDse30HvQ6S1JQtJQEId9M9VmchyrBSkm5qMItzxzzurLVi9YR39PyGVQ+0ckBKZl
 Rcnvva5FHQTMu1B3ts561VbLRUsn9yi2Lwg2C8Az+OQEUcyKZMQsfZrexg1HDcLeioKfRqqEk
 dYyQNpO7EaAH5vhvY2QkDxce4NewAgt7/q9rvm0RC9+0yOih0L3ROjHXYrdLijPUgJATMXnnL
 WyTSYMV552t3gHCfAKoErejERF0BeGpCBqg4I9uz2lMrg=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1733
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/6fef3af5-1e3f-48a0-b026-aa5219a27057%40web.de>

>> @adjustment@
>> @@
>>  ... when !=3D my_action(...)
>>  my_action(
>> -          ...
>> +          0
>>           );
>>  <+... when any
>> -my_action(...);
>>  ...+>
>>
>>
>> But I find the shown duplication of SmPL code questionable and therefor=
e improvable.
>
> The language is as it is.  You can express various things by adding more
> or less information.

I got the impression that undesirable software limitations are indicated h=
ere.

See also the software development principle =E2=80=9CDo not repeat yoursel=
f=E2=80=9D:
https://en.wikipedia.org/wiki/Don%27t_repeat_yourself

Regards,
Markus
