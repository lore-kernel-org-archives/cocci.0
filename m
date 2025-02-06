Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F47DC02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sr9bKWCsdg8u9oIvt9wHAUTBq0Ut9El5gVBk3h+jzwA=;
  b=Kagj08Ehoq+MwjAp2I6Dr4bfU/0oExihf0hg8hqBaWOIcOjYeu66ys1x
   /DdgvSc6w2pAOjipEOZ5N7VCTu6Y5FarPihdpQSODLUol2vAclmSbJzkH
   1uIJpKlj7CPdUeNJWSvQEyvZYzC+T5ASTHW80l3pBYnopusQHTFoXgMnv
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
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="207022863"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 17:50:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 918DCE0261; Thu,  6 Feb 2025 17:50:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D49FFE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 17:50:54 +0100 (CET)
IronPort-SDR: 67a4e86e_1q9t1siNG1NKMCD6pFb1FzT/hnqYFqWLAYgv+2PG8DlWvlW
 QDlY7IISCojzjeEQL+MIhh/uryL9acnysVPNPWw==
X-IPAS-Result: =?us-ascii?q?A0HlBQBd56RngwsR49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDfVozBAtICIROj0+BdIRrjw6IdYNUDwEDAQ07BgECBAEBAwSCDIJ0AosBA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAgEDIwQZAQERJgEPCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn4Bgi8BAzEHDQaxI38zgQGCDAEBBtpcHywiV4FlAwaBGi4Bh?=
 =?us-ascii?q?WuCYwGFagE7hDwnD4FVRIE8gwM+gQUBgVsEgV6DW4JpgjOESGeHMptHUnscA?=
 =?us-ascii?q?1ksAVUTFwsHBYEpSAMqNjEjgSMFNQo3OoINaUk6Ag0CNYIeJFiCK2oEBYEtg?=
 =?us-ascii?q?jqEQ4RNhVuCEoFiAwMWEAGDIXocg10THUACAQttPTcJCxsGPZ5GPYQRgRUsg?=
 =?us-ascii?q?VHHBjQHgjiBZoFjDIoplTMGEy+XQw4GknuYfCKNYpsqgX0kgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIRcCg2Ezxn1CNQIBATgCBwEKAQEDCYVGAQGKaYFLAQE?=
IronPort-PHdr: A9a23:jdq5ARbPD810zx5zSXHM7GP/LTHn2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wWPBd2QsawU2qKW6/mmBTdZp87Z8TgrS99laVwssYYso0QYGsmLCEn2frbBThcRO
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYn4duMLo9xgfGrndWeulbxmdlLk+Xkxrg+8u85pFu/ipNt/4768JMTaD2dLkkQ
 LJFCzgrL2866Mr3uBfZSgeB+mUSWXgMnBpSBAjF4hD6XpPvvSb/q+FwxiqUM9DoQL4tQTit4
 LtlRxHuiCccKj4263rXhdBqjKJaux2uuRpyyJPJbY6PNfp+eqTdfc4GRWdEQ81cWTBNDp+6Y
 oASFOcKI/pWoJfhqFsPtRu+BBejBOXzyj9Tm3T62bQ23/k9HQ3a2QAtGc8FvnbJo9XvLKocU
 u67w6bGwjvecf1W1ynw5ojKfR89rv+BRq5wcdPLxEUzCw/JkFedpIr4ND2VzOQNtG2b4vJnW
 +21kW4nqBxxoiOyzckjjonJiJgVylHC9SV23Y04Itq2R1RhYd6nDZtQrDuWOYRyQsMsWWFou
 SA6yrIdtJ+1YicF044ryAPBZPGedYWD/x3sWvqLLzhimHJlZKywhwy08UW4yuDxVNe53lZWo
 idGjtXCuHAA2hjR58WHVPZw8Vus1CiB2g7d9+1JP0M5m6rZJpMizLA+mYYfvFnMEyPqhEj7j
 qmbfVgq9Oiv7uToeLTmppmEOoBvjQH+Nbgumsi+AeQ+KAQBQ2+b+eG62bb+/kP5WK1HguMrn
 qXHqpzWO9oXq6yjDwNI0Isv8QuzAyq+3NkcknQLNlxIdA+dg4XtNVzCOvP1APGiiFmylDdr2
 uvGPqH/DZXXM3bDkbbgcqhl5kJAzgc40MpR6IhOCr4bJfL+Qk/xu8LcDh8+KwG0xuHnCMhh1
 o8EV2OAHLSWPLnPvlCW/u4vIu+Ma5EJuDvlNfQp+uDigWUnlVMDf6Slx4YbZXKiEvh7PkmVe
 X/sjc0AEWcOsAo+VuvqiFiaXDBUfXmyRaE85iwgCI68AonDQo6tgKaA3Ce9EZ1bfW5HBU6XH
 nvyaoqLRe8AaCSJLcB5iDwLSaChS5M91RGprAL21aJrLvDI9S0AqZLjyN916vXPmhE16TN7E
 8Wd3nqWT2B0m2MIXyU50Lp+oUx70FeD0LJ3j+ZWFdxJ//9JSBs1NYbAz+xmDND/QgbBcc2HS
 Vm8RtWmBSo8T9Mww98LeEl9Ac+tggrC3yqsGb8VlqaECIY68qLGjDDNIJNfzHbP0q8slBEMT
 9FAfTmkga528Q7eHKbSkl2CkKK3aaUb2jWL8mqfmy7Gt0ZTWw9YUKPfXHlZaFGFg87+4xbnR
 qWtFK9vHw9P08+EJeMeT9TzjkhdAtrnNs7fZW2ZhGq6QxqFkODfJLH2cnkQiX2OQHMPlBoeq
 DPfbVBW7kaJpmvfCGYrDlfzewb29uI4rnqnT0gyxgXMbkt71rPz9ARGzeeERaY12bQJ8Dwkt
 y0yBEy0ivffEdmdvExMeKtGYNUyyEhK3yTVul81JYSuephrnUVWaAFrpwXr3hRzBJ9HlJ0Pp
 Wkp0RE0BKaWylJHeBuH0Jq2NrCEYnLq8kWJbKjbkkrbzM7Q+qoL76EgrE7/uQiyCkc423Bgz
 sUTzHaWoJnHZOYLebT2VEt/tx1zprWAJzI4+5uRz3pnd6+9rj7F3dstQuoj0BepOdlFYuuCE
 0fpHssWCtLLSqRikkW1bh8CIOFZ9bIld8Kgefyc3ae3PeFm1Du4hGVD6Yp53wqC7S15AuLP2
 p8Exbmf0G7lH3/ZhU2ir9uxtIRKfzAUEUKgxCKiCIMQLqx+cIAXCHu/dtWtz4Y2jJrsVnhEs
 V+7UglfgonzI0XUNgO7hFQDsCZf6Waqkia50TFuxjQgr67FmTfL3/ynbh0MfGhCWGhli17oZ
 4myldETGkayPG1L3FOo41j3w69DqeFxNW7WFA1tdjL1Mnokf6++rLuEbOZQ5ZluvSgdA4HeK
 RiKD6XwpRcXyXapOmJExy0gMRyutI/4mRNSl2+Xanp+5im8G4k41VLU49rSQuRU1zwNSXxji
 DXZMVO7OsGg4dSek5qrXvmWb2u6TdUTdCDqydnFry6n/ShwBhb5mfmvm9rhGAx80Cnh1tAsW
 z+a5Br7Z4Dq0ey9P4cFNgFNDUX/9tE8N4VwiIo2i7kP1HJcipjd8XcckGj1OMlWwuqkNSBLH
 2RUhYeKplG8kER4ZmqE3Yf4SmmQzq4DL5Ghb2Ua1zh8p8FGBaGI7aBVyC58o162twXUMrB2m
 jYQz+dr6WZP2bhT/lB3kWPEXfZLRBo9X2SkjRmD4tGgob8CYW+udeL1z09ihZW7C7rEpAhAW
 XH/c5NkHClq78w5PkiftR+7ooziZtTUasoe8xOOlBKVxc1cMpEsjbwngSR9OGTylWIowag3g
 FY9uPPy9JjCMGhr8K+jV1R9Pyf2ethV1zXjl6dYke6J0orpEpgrSVBpFNP4CPmvFjwVr/HuM
 Q2DRSY9pnmsEr3aBQaD6U1ioiGHA9WxOnqQPnVc0cR6SUzXOhlEmA5NFmZf/NZxBkWwycfma
 ks8+j0B+guytE5X0uwxfxCtV2DCuEG3Zz1yRJXXJUhT6RxeolfbNtaB5/h/WT5V9NutoWnvY
 iSSNQFPEH1MUEuZAVvueKaj75/M/qCRVO+5MueLaq6EtOhdEa6Bw572lIBh+lPufo2GbHxlE
 uF+0VFIWmphXZ3QnTlWDScQkmrbZsqf7n9Q4wVRqcayuLTuUQPrv86UDqdKdM9o8FawiLuCM
 OiZgGB4LyxZ39UC3y2Azr9Xx1MUhyx0ElvlWb0dqS7ASr7Rka5LHlYabS10Ls5B86M72EFEJ
 8fajtr/0rMwgOQyDh9JUlnom8fhYsJvQSn1LFTcGEOCL6iLPxXOxNzrJ7yxQ/tcgaQcthG9v
 yqaD162PjmHkGqMNVjnOuVNgSeHeR1G7dvkKFA3UzelFY2gM0ToVb0/xSc7yrA1mH7QYGsVM
 DwmNlhIsqXV9yRTxPN2B21G6HNha+iCgSeQqefCefN0+bNmBDp5k+VC7TE00bxQuWthTeZ2h
 TCUg9pguVCgncGQxzAhXBcE+VMpzMqb+F5vP6nU7MwKQXHf4BcE9nmdETwPoMZ5TMLiseZcx
 5Kc8cC7YCcH+NXS88wGAsHSI8/SK3stPy3iHzvMBRcERzqmXYkwr1NQmree+y/MxnDfgofhk
 twCR+0DPLTUPvYdF1gjA9EIZpt6DGtMrA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VfQphKh3NqG+2EYWcjaEpWcs5nBQXtQji2hC6mlwRA09TyXqra
 CTdZUgvyMc5wx8ZJhNo6HkBEDEewK5yXcX2+Ys1NWZMTUO0VHAROpfBMnZsl7d8kbFl9K1u5
 0QEZSWROefMbAm4PyKhzWFLw==
X-Talos-CUID: 9a23:n1h3SG+oze0XDHgdPQiVv3M5K8R4IyHN8HmKCX+qIENUEJyTWUDFrQ==
X-Talos-MUID: 9a23:AN/o+wlK0PENE37TA7mKdnpzG8d16LWPAntc0os7vpCrKydyKxqC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="207022847"
X-MGA-submission: =?us-ascii?q?MDH/r77cM2r4hCRzAVzvHr883p8esJycr4KX2T?=
 =?us-ascii?q?nTEqLwvphlUL/gW1Dx7VN2boUZsH7Ipi/LdGuF8ZY9e1CMpM6mFJC2qY?=
 =?us-ascii?q?X0AbnpSEebjBoISwFZue9AGyYCcpIlDhwL0CasMztbmLpfzb8xtC2thK?=
 =?us-ascii?q?T06g3krxaMCwPt91Et95Wiog=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 17:50:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738860652; x=1739465452; i=markus.elfring@web.de;
	bh=sr9bKWCsdg8u9oIvt9wHAUTBq0Ut9El5gVBk3h+jzwA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B45M8Rt576cTg0A2Eayx/5nEHmjs168+/QLC2F0E0By8uaGfv/0t6T16C9yqFn1y
	 m1Q3djjDjCU/7H2V0Iz0BZ02lPxrxyQKe1R2VhXIcrMuMJAwtdM0T1IymmKUUpsZh
	 T7FVBSqj8a9hqtRW28ZGIhbBGcBTrcM5FBW1R8qT1Uccky7nDONoO9YHLE2CmCBjX
	 JD4HNu2wiXV0BGUjLnJTH3Z0RnX4toCEdCSfXFNAp8GIw3UeQXr0rbZmpDci8NYcl
	 WdcZw0LtTt6hZQke+XesKCRFGWHg3WZBaqjVKK2dlN/S/j+/DX5B0TbDl52uOaMFf
	 j6i/EQraZjvRV1ZKBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1tOHBk17ya-010BTb; Thu, 06
 Feb 2025 17:50:52 +0100
Message-ID: <ce7b10ab-929d-46b4-ba64-0729875f9861@web.de>
Date: Thu, 6 Feb 2025 17:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Content-Language: en-GB
Cc: Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gTAtiXbZvyRYomsHDvab65WXFNpQ9RyWGc4lkSvkHy0fsR0t3UT
 t4+Gnh+YKCCwIs7kDMtGEqtM/i6ux5xqZPG9kg6t3KdE/3eWudesjZnHemJL3ibSPSykHvC
 wKdji3Vzf4p99g5OWuG6JbSgbX16m4JJhp0LupMKi+UaJryq4dpa1FHlKdjJnmYgYz0WNSV
 8wzWy0eYXKeutl+Cx9Ufw==
UI-OutboundReport: notjunk:1;M01:P0:sx/p72eqDz0=;1su46t/WnkdG2CYOXJ3ndNqjwDP
 zmkybY/sKncvTxUspgK1zK7DuqbdnbT0uLaoJmUzaRGAzM3zuB8YTITdBTIe2d9K72fIyRvhT
 oIvFKTiS9diPiONDcEIoyJapWqDj/nWJNXv6haFopQsy1W0NjI5BgvErUXZmlVJpG8u1IT+Uo
 P3TBc2+nWjHCzxI8gH1Chb99moART6nwcD7+4OpOyKcnSpzijcsT1Oy50E4qwy+aiDdJ5pEqd
 P9gHTQYBhvuWiWvGfnk+phoGLLPuLoYxonnlt9wC7rm+VoF5D0PvZTHT46dldB+3aQsLuRNDG
 nuML8pk6tV0UPV9EERWBxA9LIWSPAKKgGPOie6tfpeSmm5toIHcG9XFLwFGGnKlTRweoMO2h0
 LYdZDrSd8n3Ghari+MKqztA5Ck01hbt9PgpGenzafc2vtOeuEZlmj91fYQiqy7I1U2uKHajhj
 4/9X5vy9//081xJ13WTRfDwOS2MVLoHESrUxYpuw0oCg49XuOISGSvwh547biHL2IH9e6VRhU
 XFS4ipVJmCkU7CANO+KDfnGRkQDf9yfv/vB63zfrqhkRJSFBlVECWmjqlj6j2cyk629YPhhON
 REtRDWU6aCJpFPGZ9NRN7xBiRj+F/p1tVO1lspzZMU+BkoRzJH+Zx5eKsaQ/vLnESWbsDnjMm
 RjzgfZnJTHzYZ6/FWtfpr6XESDtIWUJ0TElk4jyuAu4KxmLVfzi2fdFaRCXCP0HoWmRe7rP4D
 +ghEXCNfU5UQloXEzxYdVxBzKbNBzrDnq8rhp82JmqlYCVGQBG67YC+52mjTjGk81+tiPKxnq
 7nkxcOj8joC3OR6m4mAc4dY0qov5QBVM0zcHw2jsZybBECcer3OGO17aowBA73WAW4SAyllWT
 hc67V2OKDz8G8xVmrAmGv28jUofHF//WSE2LC9c9hghPVg2oln+uxEqkzrL6EqtnCp1nxvsE2
 uIX0Q/Box0ncwJfWloGEbnDGQyIQ8egFWH/3yTuvIJIyTISEvUgcDA0gE5hA4uBJ4Ej02GoQ0
 5RdEYaUoggRd4Q4v1cPVGW4tx12pJpFBenY9wRJ8N9TFm5EEVa1uCsL9mgVYxcPzkzpi+hoUf
 Td1Cdvcvg6aMJAvVhSDuNboK4+1JOR6Olen9+DigisyT1KX1gssvGTerYoVSFssPRZu4TbofG
 n3XAn6ewKvBJyYU/omyJTu0R+S9y6gOe/8k2MwkZg6c/qmE77mYBTWCabmEzH09ijv4jKVAEi
 Yey0YnCvABRR25mftdysmmhIX0ADzrezsUdqfTW+WVJ0Vi9cWP+Z7NDH8lBZ8nO3FsBx8DwAO
 nDWFpTdKc7aFbRSkIUPL4Epu7XjL2/AtPvhC5z01fvorHhhzu8A3PMCDanubLPQ5HjsyQ4Hre
 ZZXGUwehMfkz/gg9mNxpiLakvLBpKFDwGpc1Z6NkhJ1ZEaLvEGtzXSGNH3Id8GyUkysTtmolY
 Jlpradg==
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2365
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/ce7b10ab-929d-46b4-ba64-0729875f9861%40web.de>

> @@
> @@
> static inline int
> ieee80211_get_mbssid_beacon_len(...)
> {
> ...
> -if (rnr_elems) {...}
> ...
> }
>
> That seems ... simple enough?
The mentioned function implementation can be extracted into another test f=
ile.
https://elixir.bootlin.com/linux/v6.13.1/source/net/mac80211/ieee80211_i.h=
#L1210-L1240

I observed with the software combination =E2=80=9CCoccinelle 1.3=E2=80=9D =
(OCaml 5.1.1)
that the program parameter =E2=80=9C--no-loops=E2=80=9D can also trigger a=
 very significant run time difference
for such a test case.

It seems that the application of the SmPL construct =E2=80=9C<+... =E2=80=
=A6 ...+>=E2=80=9D can eventually be more desirable
for this use case.

Regards,
Markus
