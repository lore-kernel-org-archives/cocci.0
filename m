Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF093C47258
	for <cocci@archiver.kernel.org>; Thu, 25 Jan 2024 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=zBnaxxdcpGqvrU8PZI/Nm3/vMMsMjdK0MM18r7hZuOA=;
  b=uptLtjReykXoxN3IAs4AC/OddFQhLAcxOEKMjwRIn4epzckhanGBp6sN
   z2GEwjL2V+vfS4KIogKKxXNiAXbK+ZKgme7cBLYJJZXvbL4Sk6/1bsfbb
   gdx7TGWhspfb875PKSKWq6K0m7uDi/PcKPLBmPaxuieS0bljTDHLZ/Kl/
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148673095"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jan 2024 18:26:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B63FFE0CD5; Thu, 25 Jan 2024 18:26:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C83C7E0035
	for <cocci@sympa.inria.fr>; Thu, 25 Jan 2024 18:25:59 +0100 (CET)
IronPort-SDR: 65b299a5_DeSaKoK9YMy1V0cN91ADmMHF9ZYWsDMZ/ZDtWjiuNO/ybmx
 4RVuCOMy+btqwKYAdFLe1s/eKxYgimLopa0Vx7A==
X-IPAS-Result: =?us-ascii?q?A0HRBQBKmLJlhwQP49RaHQEBPAEFBQECAQkBFYFPAoI3f?=
 =?us-ascii?q?ANTMgQLSAiBRQKDBJE2hGuBVY0viHCBVoFAPg8BAwENFAEBBiEEAQIEAQEDA?=
 =?us-ascii?q?wENgX6KQAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEjFwcOECeFbA2CVRiBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQECR2sdAQERJzQCJgJzAQGCfAGCKgEDMQcNBrZFg?=
 =?us-ascii?q?TKBAYIKAQEGgVdBTqx0HywiVoFhAwaBGi4BiAcaAQVjiWEPgVVEgTyCUoNQA?=
 =?us-ascii?q?QOCK4MOgmiBG3+DQ4EoiEeCRwGGMIFTHQOBBW8bEB43ERATDQMIbh0CMTwDB?=
 =?us-ascii?q?QMEMgoSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQLCYDAxJJAhAUAzgDAwYDC?=
 =?us-ascii?q?jEHKVVBDFADZR8yCTwLBAwaAhsbDScjAixAAxESAhYDJBYENhEJCyYDKgY3A?=
 =?us-ascii?q?hIMBgYGXQkdBw8JBCUDCAQDKykDITNBEQMECgMUBwsHeINKBBNEAxCBQiMDG?=
 =?us-ascii?q?SsdQAIBC209NQkLGwY9ApgTAYMfGhMsgg6TTo81okk0B4I0gWAFgVwMiHaBI?=
 =?us-ascii?q?5UYBhMvly0OBpJZmFSNbZU3hUqBYzqBXDMaJIM2TwMZD445hBSBC448QDUCC?=
 =?us-ascii?q?TACBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0hczTK4/fQxnJRTwaQPXwOrXdLJyesId70hD6qkDc203TiX+rb
 HIoB17726RtN91YhodcL+7V5VoLUmsl6KdgrN+AV7BZmXbUQKTRekO0WKI+UyEJ8SRzI5g/J
 tBN45jFdb3EV92tsri5hKkeuxQuOVvvJrIuQ/EpU0dKz2ChpsQljuQgWugeHFLeA==
X-Talos-CUID: 9a23:ASJzLWP8oJopUO5DWQJMzxVKOPIcSifY/WqJH06hO2o4R+jA
X-Talos-MUID: 9a23:h+ujpgXUoRQCTzzq/CHpwwNEG/ZQ2aWrMk02npYEhpO2HzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="77843673"
X-MGA-submission: =?us-ascii?q?MDGipPn8fjXaYVfYNMlbGtyV35Sd2/I6tbco3y?=
 =?us-ascii?q?+48WU7i2wqM7jtvta3ZJW27ZnMr6KEv6D5+lyH157ACva7xA5LG8B2oo?=
 =?us-ascii?q?9ydOFRwm1BuoYp1cQjQOfGEswcFXqHyDam/Ses6mwEUFfcfuK3Ga/4iZ?=
 =?us-ascii?q?zGGY88BISMUgbGorGa09QX5Q=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:25:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706203558; x=1706808358; i=markus.elfring@web.de;
	bh=MooCH4Np1Qqg3WX57RpE0HP52psk/CTMunRsnR4AIVE=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=wPQ4ENgnuVK2fJhctYED+ZCDKO7fGBMniADEcqlKvPAaiM1W+THlDMhTt//V+0Ff
	 A151GOLZhB7RQnpdlR3DjiqLTW6cq+J5GuUqp+3pZe5Gr9C5IO/npglfpIF7PkaK1
	 SLDbUTF1SQ+8Bw+NvbAysS2VldeyyhmCHBUOtIMsEf+d4QeolhJLTVe/msCg6xNrb
	 FFyLQTOodZDPp+N9Ldd2ou2yCnmzS07y7LGjFqgIK8x+WLS1js3l2vN+2Fqn5pavB
	 kDJcONGDjucSDeHE7VhHqqmHyT880WaBrz2LpFNQEBfKkZ/cgPeKogH+rGqTUSChX
	 1wWGbaTRQog7AdaiWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1qqwii0X0M-00gn9i for
 <cocci@inria.fr>; Thu, 25 Jan 2024 18:25:58 +0100
Message-ID: <ec692ed7-01e5-493b-95b6-75ca7a59fb1b@web.de>
Date: Thu, 25 Jan 2024 18:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iM56QG4I/7ZkatheQGKZmkfoGv3xJ7o6G4Rmr1MQ8Seh2gCBkwc
 At3h51AkSJDwdWgC3ASsqBWPsqWeocYg6oYWEoGuPXj01pM/ibnFJrJayw2i7ZxKr/+s4o8
 aP5B5D/nV/K/0UPYefQSzgTleB3i4suDuffbWKxDS+JGSOxXeJcJggYAfqBRziFvAh8dIPj
 zYeAB3Vm88Hs3uiX0AZeA==
UI-OutboundReport: notjunk:1;M01:P0:NPtIx39iDhQ=;X+GqRJKt7g6yZaJhcNE8nsSjIK3
 7i5LvAKn5tcOHXOBuS0qHSUFt9K/Kao9WDnPwU55UVitwx65n1vitMm+paDVSrZYrX1IRuulE
 my/iWRyn6XhPHLZ1lervetr/xAxfaoO7W5N3/BbICRL4KYVBBVkB2u1urgE/ZOfAQje6vl/if
 BIJXqwL0wcv+r8bdwE0oG3u0JnITMTJnAyWiZaLKlhpJNfs6FqSgB614RDb3VADl2VpVj8wAL
 TWChXmzkU2PnVmzSt0NN54H0TlXv/yH6z4CZWNjpNgazcbfMrykvjNzsOXer5xeyvJhKE5sSX
 WEyIPDPxm9RmgWsE4+UgB76AzSeYra38BYaaRUOrGy7gp5fP/lZqTU4JvV41OAfDqWQq5edEc
 xQ65EsOUrPuMuLW/Dz6T6Bir6cgCfeUMDGeVyb79e5YI0x1jI/xnBT6W8FR16GfBN3BFiN8rR
 +1SjF6mJCvubbv8Udaz54uLWTAhLQ8tsLxP/yt3rQJX7XWqJMPYGeIoxPEwdw3ucjTrk8608m
 1fnubaB6tC7piwO1hxi1TRiRIoIlOZ4CT32vTxfV1HX+wBXURmWxxyvuYzaZr59sl/LqzwBgT
 aJ/WJGQU4/hARbe2m+5cu3ZL3EolI3rRpv3tHvZW5fwWTDImi8ezafrmI6Y1/8EN1RkeSJNoo
 rAAUwXEGnbuKMXfpApaOk0ESuyVCUvs6cutjElrAkH0ud/vdiOnJmVDqL3btzvtLHSl/3PB0g
 vIrU3A5ME+qpUBr9x1yK/uee+fHe30/yDqSioj2O8Z88B9heRmnGPLopE4/NrTF3s5lDzl8yf
 hh0Iy6oVDSpP6zcFVQY5uqhiAPBiEY4MhBeduEpBj7BTSIyM7w+SJQsfRGAkfsFhpuPgJvW0X
 NcFUXNcb4FjNvYoBYLT1xmzt855/XbqiMuzLXGg58rVldkPWiUNl+o0UiVgTs/KmXOZmJuZaB
 GMb+5w==
Subject: [cocci] Checking name space conflicts for SmPL script rules
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1486
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/ec692ed7-01e5-493b-95b6-75ca7a59fb1b%40web.de>

Hello,

I am trying the following tiny script variant for the semantic patch langu=
age out
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0063=
0-gdeb429df=E2=80=9D.


@search@
identifier name;
@@
 name(...);

@script:python selection@
id << search.name;
@@
if id =3D=3D "Test":
   cocci.include_match(False)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi test-name_space_conflict-20240125.cocci
=E2=80=A6
scriptmeta: parse error:
  File "test-name_space_conflict-20240125.cocci", line 7, column 13, charp=
os =3D 81
  around =3D 'name',
  whole content =3D id << search.name;


Now I wonder how this software behaviour would fit to the documentation.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5fdb1a247d3374ac30a3e=
565b2cc5167aeefc4e5/docs/manual/cocci_syntax.tex#L87

Will the shown restriction be reconsidered?

Regards,
Markus
