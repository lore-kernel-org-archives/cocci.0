Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C75D3EE6B
	for <cocci@archiver.kernel.org>; Thu, 22 Jan 2026 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nqgqne07YjqGCyEiEvUu2uFfO5mY/LbB/YRncSBZvgk=;
  b=RiWwzBqNqUldLDdiaH/+hyLd+ZogHqWZ09DUoIfp9Pb0PQloKzypwE2O
   DT5lZhmotriImVU0hopXPD0EMdqj5uZjM2ped7kz3T/T3fQoogfcddMgG
   +oSx+CCeXjfHrLHfndHcRRsVWNxc9j7jziTogfVH1pJEE4ViqA66P+NPE
   0=;
X-CSE-ConnectionGUID: c8nO+ZAFS/ONXjQuy/C3aw==
X-CSE-MsgGUID: MUHo224WSdCJE4Pu1SSzSg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,246,1763420400"; 
   d="scan'208";a="259874776"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2026 15:23:00 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5879581D7A; Thu, 22 Jan 2026 15:23:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C060E819C8
	for <cocci@sympa.inria.fr>; Thu, 22 Jan 2026 15:22:54 +0100 (CET)
X-CSE-ConnectionGUID: JIUaPhV0T7OueSYuFSsqEw==
X-CSE-MsgGUID: lqyFdyVYTlWPQcupxQRibA==
IronPort-SDR: 697232be_DOPPpThdV0jxBoVz21we5kJOriLuOWu3Kcty6rV5ZhVDk4G
 QglD2DDrGx1c0Dr9CbzoRz8eeV8Gek3vIY/xT9w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ESBABkMXJpeA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VACgj9ofjMEC0mEWI9Thl+HPIdViHmDUgIPAQMBDU4BAgQBAQMEhHYKAo0IA?=
 =?us-ascii?q?h4HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAFDD?=
 =?us-ascii?q?goxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBEScPCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgn6CIwEGEAEDNgewMYEygQGCDAEBBtpkHywiWYFnCRWBCi4BhW2CZ?=
 =?us-ascii?q?QGGKoQ9Jw+BVUSBPIJSMT6EQ4NbgmmCJoEOlAFSeBwDWSwBVRMXCwcFgSNDA?=
 =?us-ascii?q?yovLSMPPAUtHYEjIR0XEx9YGwcFEyMyHwYcEgIDAQICOlMMgXYCAgSCEHuCA?=
 =?us-ascii?q?Q+HAIEABS5vGg4iAkF+AgELbT03CQsbBD2PXESDM8kwNAeCOIFngWQMn20GE?=
 =?us-ascii?q?y+DcQGTYA4GkwUemGgiqR+CACKBXDMaJE+CZ08DGQ+OIT6DdcR7QjU8AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:qtJBjxy/7GdTGhbXCzJewFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xCZva0m1QOXBtqTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezbr5+N
 gm6oRneusULjoZvK6g8xxnUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRfMVQWA6WIQX3sZnBRVGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43qM03OsvHg/bwgIgEdIAv3bIo9v6L6oST
 fm1wbPUwTnfcf9b2zHw45XIfBA7pvGMWKp9f83Lxkk1FAPFk06QopHqMTOR2OQNqWmb7+xvV
 emyjGMprBt+oiKsxscxkYnFnI0bylTK9SVjwYY1I9K4RVV1YNG6C5RcrTyVOJVvT84kXmpnt
 zo0xKcctp6nYCgF1o4nxxjHZvGGbYWF/g7vWeKPLDp6mX5rd7CyihWv/UWiyeDwS8m53EpFo
 CZZktfCtn4A2wHO5sWGRPVz8Emv1ziN2g3N6OxJJ10/m6nDK5M53LI8i4QfvV7dEiPomkj6l
 rKae0U+9uS15OnrerHrq5CGO4J6lw3yKKAjltKlDegmPAUDW26W8vmm2rL55032WrBKg+U2k
 qbHtJDaItwWpqu+Aw9IzoYv8Ri+ACm939gCgHYIMkpJeBOBj4f3J1HDOO70Aeqhj1i2jjtn2
 fLLMqf8DpjNNHTPjbjsca5460FGyQozyd5f54hTCrEEOP/9XVX+tMbbDh8kKAy42enpCNFz1
 oMEWGKPBKCZPbjcsFCW/e0jOfSDa5ENtDbnN/cl/+LujWM+mVIFeammx5UWZ2q8HvRiOEiYY
 HvsgtIaHmcQpAUyVu3qiFuYUT5SfXm+Raw85isjBIK8EYjDXpytgKCG3CqjApJWYXxJBUyNE
 XrzbIWFW/IMaDqILcN7kzwEU6KhS4472h20ug/60aJrLuzP9SIAr5LsyMB15/HPlRE17TF4E
 dyR026TQGFznW0GXSc70q5wr0Bl0FeMz7Z4jf9CG9FL4vNJVRo6NYLGw+10Fd/9QRjNccqXR
 1q+X9qmAjAxTtcpztEWbEhyFcusgAzf0iSsG7MairmLC4Yu8q3Ax3X/P99zxW7J2qU5lFkmW
 sVPOHW8iKNj6gbdGpbFk16Bl6akbasc3DDC9GOEzWeWpE9WSRZ+X6qWFUwYM2nLqdXwrmfLU
 LaqDfxzMBZFyMfELqJVY9ntpVRAXvbqftrENSb5kGC7Dhegx7WWbYOsdX9O8j/aDR0hmhoQ4
 G3OGAwwHCanrCqKKTV0Fk/0JW7o//N/rnyTUUI+iQ2HOR4yn4Gp8wIY0KTPA8gY2agJ7WJ48
 20c9DeV2tvXD4HFvA99ZOBHZst75l5b1GXfvgg7P5q6LqkkiERNOx9vsRbI0BN6Qp5FjdBst
 GkjmS97M6GFyxVscz2C3Jb/EqLaIC/+8UPncLbYj2nXy83e4aIT8LI9olTnshuuEx8H+m9kz
 sIT/n+S/JTMAyINXJi3XktkvwNiqeT8ZS8wr5jRyWUqMaSwtWra3Mk1AeI+1hu6V9JYLb/CC
 wL4VcEXbyS3AMotnVXhLhcNPeQJsbUxI9vjbPyenqiiIOdnmjuiy2VB+oF0lEyWpWJ6TabT0
 pAJzuv9vEPPXirgjFqnrsH8mJxVLTAUEG2lzCH4BYlXLqRsdIcPAG2qLoW53NJ7z5LqXndZ8
 hakCTZkkIeMcACRcke78Alez0URrlS4lCH+wzE12zAlo6yD3TDflvz4fUlPMWpKSW9+yFb0d
 NLt1ZZABhfuNlVvzUf2gCSyj7JWr6l+MWTJFEJBfiytanpnTrP1rb2aJchG9JIvtyxTFuW6e
 1GTDLDn8H54m2vuGXVTwDcjenSkoJL8ylZfgXieMW01gX7XY8B2yj/A6daaSfMbjV9kDGFoz
 CLaAFSxJYzj2NyOlIrY9M26WXigUJJ7biThi4+N/njehyUiEVi0mPa9ncfiGA4x3Hrg1tVkY
 i7PqQ71fojh06nS3ftPRkBzHxe87sN7Hto7iY4snNQL3mBcgJyJ/H0BmGO1MNNB2Ku4YmBfD
 TIMxtfU5kDi1igBZjqszpj6S27b789vfdi8bUsJ1yh7480CBKqP7bNClDd4uRLi9FiXO6Ii2
 G5Aj6JyoHcBy/kEog8s0jmQDtVwVQFDMCrgmg7Jp9GyoaNLZXq+JL251U5wh9ekX/mJpgBRX
 mq8e493R3YqqJ8lbxSVjTuqttKBGpGYd98YuxyKng2ViuFULMl0jf8WnW98Pnq7u3Q5yuk9h
 Bgo3JegvYHBJX8+mcDxShNeKDDxYNsevz/3iqML1OOfxYOyBdNMHjsRXZ3nZe2lGnQeuL60U
 mTGWC15sXqdFbfFSEW64V1lsmmJPpSlLXCRK1EGwN8kSBTXdyk9yEgEGT49mJA+DAWjwsfsJ
 Vx46j4m7Vn9shJQy+hsOkq3QiLFqQyvcDtxVImHIU8c8FRZ/0mMe5/7jKo7D2RC85amtgDIN
 mGLe1ECEzQSQkLdT1mxO76z+Z/f/uLeCuf2JqnLZqiS7PxQUO2XzIijlJRr9XCAO6DtdjFrX
 fg8x1YGV3dkHc/U3SoCQWobmmrEPcucuQv58TZ9s8S8tq3iXg62o4CIDt4weZ1mqRWxnLvGP
 PWbgzxhb29R0J9Vg3TPzfAJ1VoWwUmCbhGLFrIN/W7IRaPUwepMCgIDLjh0LI1O5r492Q9EP
 YjajMn03/h2lKx9DVANTlHnlsyzAK5Ca2igKFPKAlqKP7WaNHXKxc/we6a1VbxXiq1dqRSxv
 T+RF0KrMC6EknHlUBWmMOcEiy/+XlQWoIambhNkEnTuVvrjbQCndsB6h3s6zPx8h3/HM3IdL
 Skpc05Jqe71j2sQifF+Fmpdq3t9eLPdwWDDtbaec8tQ6Kc4Z0Y83/hX63k71bZPuSRNRfgu3
 TDXssYruFa+1O+G1jtgVhNK7DdNnoOC+0t4asC7vtFNX2jJ+BUV4CCeERMP8pFAA8fsprsW5
 9zBjqP1Jx9d/tiS8cZWVK22YIqXdWEsNxbkAmueFAweUTuiLn3SnWRYl+yOsGKYpN42p9K//
 fhGAq8eX1szGPQAD01jF9FXO5Z7UAQvlruDhdIJ736zxPE+bNpXtNbLW6DLaR0KACmUh/9Ia
 klQqVsZBYEUK5G9xEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RQLH96taS9qacLuurDScek0x7skDRtV00zEX/kB9WHVpm7+j9v
 xG+85rsiMc6QxhPE3I9ursBEDtewK+yXcX2+Us1NWZNjUOaFHYSb2KhLGKq1bd8kvFmNK1vZ
 0QFZSWY+eAb2SS4/yb3OD1KbkdKI7tytHRuQ6I9QYVcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3AuXEriWqs5RC+igVkKL8PNKDmUeIET3TlzEmIHxC?=
 =?us-ascii?q?fFGtSeaC7ckSJ1bwxxg=3D=3D?=
X-Talos-MUID: 9a23:Ets5Lgbg8MnNz+BTsyb9qj1zCvZU55uWMUsQiYU/gciOHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,246,1763420400"; 
   d="scan'208";a="136750334"
X-MGA-submission: =?us-ascii?q?MDGwpJ1/dPLgwG9cxz9fCDB9y5ySubXZK+SInH?=
 =?us-ascii?q?Vw5mxL/7YBR8siHCh6KbMPITVnBsTn4w9QnSfJTG/zM6ZJ4b6jrOOdhE?=
 =?us-ascii?q?eDUFRGTbwfytweD9YBIgTJN8MatnniEN0z1a5k65Qqdz95LMQz8E9XDO?=
 =?us-ascii?q?X8ktfzR4h8b1l8JfH3kbkVxw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 15:22:54 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.239]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1vnTvZ03Wa-00s4sZ; Thu, 22
 Jan 2026 15:22:53 +0100
Message-ID: <1b9e1516-ce08-4f58-afca-30194974643f@web.de>
Date: Thu, 22 Jan 2026 15:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr>
 <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
 <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
 <fb3420c5-a510-4d72-8d6f-6f0d44ad9289@web.de>
 <54744c7e-71b1-ef69-f0f8-bb67dcdffe47@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <54744c7e-71b1-ef69-f0f8-bb67dcdffe47@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ebuNhQ0mvgeiaB8ipXLu8UH7IAW7C3xShobOddwPjp6WXXrwra
 V1J73kdp//BmjRxopXp/hZOn0mptWduOWnnNtek/j2CV0vRDtPjayaykFwwGa3kMWjugKZ4
 Nmw5ZmX/4mZgU2oGzAPokdnfu+5srnLXlZG3OwAe0FSD0jqSByjwC6gweFmqnUuSQvVRqOh
 jbuf1twTbGJojQziJrG6w==
UI-OutboundReport: notjunk:1;M01:P0:zl6KxAo9X/4=;svYE7uhVUVPSO+lPiSUgIHr+ckJ
 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
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3302
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/iLg3gNwFeLJtwFsx45KSKQ>

>                                       =E2=80=A6  But you may always get =
false
> positives, because there may be some combinations of arguments that can
> never lead to a failure.

Under which circumstances would you dare to determine a list of always
succeeding functions (or macros) by the means of the semantic patch langua=
ge?


Would it eventually be easier to filter on failing calls?

Regards,
Markus
