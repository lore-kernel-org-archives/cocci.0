Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C577ACD3445
	for <cocci@archiver.kernel.org>; Sat,  9 May 2026 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dNofNpMrs8CXajIytFT/C9/GRkA1XYSq9cE7adSVyfw=;
  b=H9CJP6HpSCF9wZPbnAevDiAZClHNWYejLsqB9/dQxDoBe1I7AOmeeF+H
   fQY2tOEKompFpQ7EoSFcY6jnsaxqSc9gzwB2hpjbF3aifCtaZVlUqauhk
   996tMpH+Eu7IFcMGGgq1ZRPtMzWui97I0puGnm4cKNM6k7MM9h+Fs2Coy
   c=;
X-CSE-ConnectionGUID: 9aSdD2mEQCWT+jcMmbg2nA==
X-CSE-MsgGUID: VkZYO/CYSYamdaytE7Qcpw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="275986701"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 May 2026 18:38:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 20166806EC; Sat,  9 May 2026 18:38:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F17E3805D1
	for <cocci@sympa.inria.fr>; Sat,  9 May 2026 18:38:45 +0200 (CEST)
X-CSE-ConnectionGUID: pkXX0gpSTpGMjBl5bn8ZCw==
X-CSE-MsgGUID: NoDyHfjqRIGfQPH4Ge/9LQ==
IronPort-SDR: 69ff6315_XPZRGMYv5p0YXRn/vqURoOBp9vjcDuOIa2g94rJH61Vet+P
 ShmeootJ35mTfgWLaG16NtYAry/44OTGr1SHaYg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HtAwAvYv9pgAQP49RaHgEBCxIMggULgkGBCF40BAtJC?=
 =?us-ascii?q?IRQj1OCJIQ7jxGIeYFpgWkCDwEDAQ00GgECBAEBAQIDAYILgmoKAo0zAh4HA?=
 =?us-ascii?q?QQzBg4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7B?=
 =?us-ascii?q?w4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQJHRAEBAQIBIx0BAREnBAsLGgIRBw4CAlYGARQBAYJ+AYIiA?=
 =?us-ascii?q?QYQAQMPJwcNBrRygTKBAYIMAQEGgUYF2RsfLCJagWcDBoEfLoVygmcBhjGEQ?=
 =?us-ascii?q?CcPgVVEgTyCUjE+gmEBAxh/Rz+DHIJpgiZ6FIYBiQFSeBwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SNDAyovLSNLBS0dgSMhHRcVH1gbBwUSISpuS2QsXBoDAw0hNVl1CgFJBYF0A?=
 =?us-ascii?q?oIeGV8jLwNOgQUCAQttPTcJCxsEPYs8HQ+DJUWCSJM2sXKBCjQHgjiBZ4FkD?=
 =?us-ascii?q?IoulT8GEy+XUg6TCx6YaCKNZ5s4gX4kgVwzGiRPgmdQAxkPjiELF4QTgQvCF?=
 =?us-ascii?q?EUyAgkyAgcCBw0DC4VEAQGMVoFLAQE?=
IronPort-PHdr: A9a23:LQSQeRSXu1YKzjoP32B3FokffNpsosqWAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSAMODs7kd0rGJ6uigATVGvc3d9ihaMdRlbFwst4Y/p0QYGsmLCEn2frbBThcRO
 4BvcmEg1FyAdXZvJcDlelfJqWez5zNBUj/2NA5yO/inUtWK15f/2O+94YDcbBtVjzShf7xyM
 A+2rQLMvcUKnIduMKk8xxXJr3dSZ+ha2WxkKU+Okxvy5Mq84YNo/yBMt/487cJNXqv3cqsiQ
 bBEEDgqNn0+6dH2uxXEUQaA6XwQX3kMnBFVGQbF9hb6Xpnwsiv+qOVw3TSRMNP1Q74pRzms9
 r9nRhDwhigILjI07m7ZhNFogK1UvByuqRp/w5XJYI6OL/pxYrndfdIBSmVfWMtaSjFMDZm9b
 4sLCOoBIPpYoozgrFYAsReyGQ+hD/70xzRWmnH5w7E10+U5EQHHwgMgGc4OsG/Jp9nxLaseT
 Py5wLXNwTjFcvhY2yry6JLQfx4ir/+DUrx/f9fPx0khFw3KjEmfp4P+MjOJz+QAqXSX4/Z+W
 e+tjWMstgF/oiKoxscpkoTHgZgaykrH9SVk24Y+ONK2SEp1Yd6+EZtQsS6aPJZxT80lWW5oo
 iU6yqAduZKhcyYKzJonxwTea/yBfIiF+RziW/iKLjtimX1qZquyihCv+kev1uPyTNO70EpWr
 iVbiNnMsGgA2wDN5sWbVvZz8Ems1DeS2w3P9O1IP085mLbHJpI8xrM8iIcfvEfdEiL3hEn7g
 qube0sn9+W19ejqYbTrq4GYOoJylwrwPKMumsmlDuQ5NAgDR2mb+eKm1L3i50L1WrtKjucun
 qbHtpDaOdoUprSjDw9Q1oYu7Qu0ATS+0NkAg3ULMUxJdAiZg4T3OVzCOu30APelj1mjljpg2
 urIMaf7AprXK3jOiLfhcqh5605b0AczyNdf549ICr0bLvP8RFT+uMbFARAnKwC0wuDnB8th1
 o4GR26DH7GVPLnMvVOW5O8jOfSAaY8PtDvyM/Ql4uThjX49mV8TZ6mp2p4XZWi/EPt8OUWZY
 mfsgswbHWkFugo+QvbqiFyEUT5cfHuzUbwz6SohBI27E4jPXpqtj6CZ3CenAp1WYXhLClSWH
 nbmbYqEX/MMZTmTI89glzwLTqKhRJU72RGvsg/60btnIfDO9i0Wr5LvzMJ16PHLlREu6Tx0C
 NyQ3H2KT25ogmwIRiQ73Lt/oEx40leMy7J0g/1eFdxJ5vNGSB02NZDGz+BiDdD9QRrOfs2VR
 1a+XtWmHTYxQ8ovz9MWbEZyBdKigBPZ0SeyDbEbmKSHBIYq/aLC3Hb/Pd5wy3PB1Kk8k1kqW
 MVOOnO9iaJl6gfcGZbFnFial6arcKQRxDbD+miNwmSQoE9VTAh+Xb3YUnAafETWt8j261vaQ
 bG3EbopPRNNydWaKqtEctDnl0lLSur+NtjGeGKxg2mwCg6IxrySaIrqfH0Q0j3EBkYcnA5At
 UqBYCojAiao60bXEzVqERq7YV7o8OA4rHqkR0sw5wCMdUxokbSvrFpdjvuXQPI737QeuS5np
 S8nMky62ofzAsCDuhEpUaFSe9I77x8T8GvDtBFmeLGkIbpjgFE2bAl9+U/jgUYkQr5cmNQn+
 St5hDF5LriVhRYYL2vwNfHYP7TWLjK35xWzc+vN3UmY1t+K+6AJ4fB+qlP5vQjvGFBxu25/3
 Yxz1H2Rro7PEBJUSYj4B2M+7RtnvPf3Zicn5oXb/WJhO++4v2yKwMonUdMs0Q3oZNJDKOWBH
 Q72HdcdAp2LIfYphkPvQxYKJuFU+4YrMsnge/bVkLWzMrNGmzSrxX9C/Jg70k+I8H9kTfXU2
 p8e3/yC9g6ASiu6k1qr9Mz68WxdTRcVGGf3iS3tBYoKI7Z3YZ5OEmC2Zcu+2tR5gZfpHX9e7
 l+qQV0cioevflKJYlrx0Bc1twxfqGG7mSa+0z1/ki045quZ0ivUxu3+dR0BcmdVTWhmhF3oL
 MC6ldcfFESvagEoklOi6yOYj+B+rb58MnKVbENGZSnwIEl9X6H2urfDK89D5ZU0sDlGBfyma
 APSQbr8rh0GliL7SjEHnnZhLW7s48i/w08f6irVNnt4oXvHdNslwB7e4IeZXvtNxn8dQzE+j
 zDLB1+6Nt3v/NOOlp6FvPrtMgDpHpBVbyTvypuN8SWh4mg/Szi2hfOugZvKFQYg0Cn0/8ZnX
 2PEoVyvB+ujn7T/Ku9hckRyURXZ4tB5B5o4v48+npAW1lAFi5/T8XdNwgKReZ1LnKn5anQKX
 zsCxdXYtRPk1ENUJXWM34vlV3+Zz6ONfvGCa3gNkmI45sFOU+KP6aBc2DByuhy+pB7QZv50m
 nEcz+Ev4TgUmbNBtA0oxySbSrcceCsQdQnljReV9JaTqKtNZWCgWae93gxykJitAaqDrQdVR
 HviMs17R2kqtJo5aQ+KjDX68cn8dcPVbM4PuxHx8V+IlOVTJJ8r17ILiSdhJWPhrCggwu8/g
 wZp2MLyt4yGJmNxuaOhV0QBbHuvPZxVo2yr0fU7/I7exY2kE5R/Fy9eWZLpSantCzcOrbH8M
 B7IFjQgq3CdEL6ZHAmF6U4goWicdvLjf3yROnQdys1vAReHI0kKyiUdRjYnhdgUEg6wxcruW
 Fh07HYd6xSrz3kEgvItLBT5XmrF8U2NYy03VYPZAR5Y9ABE6G/KPMbY4u85TEQ6ttWx6QeKL
 GKcfQFBC2oED1eFC17UNb6r/dDc8uKcC7n2P77UbL6Js+AbS+aQyMflzN595zjVfJbqXDEqH
 7gh10FER3w8B8nJh2BFVXkMjyyUJ8fJoRCh5mtoo8r5/PmjUVDq4paTTqtcNs9w8gq6x7iOP
 aiciUMbYX5RhJYL2GONwr8C2lUfzT5jfX+hHPwJ5yvKUb6VkbRdEhoYLXp6MscRqak722wvc
 YbS2Nbyy6I9heU+DE1dEwXonM3wI8cNJimrPVfDTi5nLZygIjvGi4HyaKK4EvhLiflM8ga3o
 XCdGlPiOTKKk3/oUQquOKdClnPTOhsWo4y7fht3bAqrBNv7dh22NsN2hjwq0PU1gH3NL2sVL
 Tl7dQtEsLSR6SpShvg3FXZG6zJpKuyNmiDR6Oe9SN5eqfxwHiF9jP5X+lw/zKZJqj5JTrp5l
 Wqar9JjpU2njvjayjdjV0kryH4Dj4aKsEN+fKTBo8MZAzCepk1LtDjWV0dvxZMtENDktqFOx
 8KakavyLGwH6NfI5Y4HANCSLsubMX0nOB6vGTjODQJDQyT4UAOXz0FbjvyW8WWY65YgrZ250
 r8HULxGTxoYEv0AC0JqNMMPKtF7U3l39NzTxN5N/ne4oBTLEY9CuYvbU/uJHfj1ADOekKUCe
 BYCh7/1Z9d2VMWzywlpbV90m57PEkzbUIVWoyFvWQQzpV1E7Hl0SmBbM63NdQ6npnMeR6fcd
 v8ejwxjfaIy+T2q71plfjIiQQMvnUN3ldi32Vis
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+8XK3q4VOYEuD2JdCgPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:IBnx5G4J9iOQ0R2N+9ss7E0kKpgqakbh1Fj1IWW8VGxvGI++VgrF
X-Talos-MUID: 9a23:7RYqlQlndbWSHNzRmYxqdnpEM+t5w6qsEXosvps/g+nYGiE3ahOk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,225,1770591600"; 
   d="scan'208";a="146133176"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHBLhbkZrdlO2c1NDSYSWaw9DG+n177RhGr8o?=
 =?us-ascii?q?hjiPnlUgxJnamtpMDi1wlEavdip7/hn9QiilY9hqTwH5nYuYfOkCGiLr?=
 =?us-ascii?q?x2WVo1NfmwhMdKIHkPv2txD2lNoV3dOB/My2DEWxDhxG+EPzs3SY5F2e?=
 =?us-ascii?q?AF2fH9kWbxzCgPpmHFfKhPZg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 18:38:46 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1vHFyw32X4-00t81N; Sat, 09
 May 2026 18:38:44 +0200
Message-ID: <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
Date: Sat, 9 May 2026 18:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02RK99pMA315lZ6y72MLppCgzL3mAJN+IyDR5t1qsebqnupkL9a
 ynjA+uKqYPlGPoVQegCl78h+PZgnIGx+z8sbbnoOKJamPyFUSTJh74/FeyLXoDOOWslpzPb
 A9NV55ATjpdhiFMhwgMkBpEAffoPcZPyhHOxmNSc9Nc+xkc7ZD6eAUkaMZbLLpgkzDJ6JSP
 e/id9hkVXDXEAaHyUSOHA==
UI-OutboundReport: notjunk:1;M01:P0:Dh2B/ixUGHA=;iS5Z25ZGEezl54+SFPO0dvTcnre
 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
 x4kitdSk4q0M9Qg==
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3490
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/tLusHAfcHCrT9EB5X4Vrxw>

>> A programming interface is used by the Coccinelle software for parallel=
 data processing.
>> https://gitlab.inria.fr/search?search=3DParmap.parfold&nav_source=3Dnav=
bar&project_id=3D18465&group_id=3D10912&search_code=3Dtrue&repository_ref=
=3Dmaster
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b=
54d827b8b9627a841c85c9/enter.ml#L1283-1299
>>
>> Corresponding results are concatenated so far.
>> I would appreciate if data can occasionally be combined by other algori=
thms.
>>
>> I imagine that unique constraints can be taken better into account acco=
rdingly.
>> Some information would be usable as key data on demand then, wouldn't i=
t?
>=20
> I don't know exactly what you are reffing to,

???


>                                               but you can for example,
> concatenation the set of hash tables into a list of hash tables

* Would you like to distinguish item concatenation better from
  the more advanced application of a merge algorithm?

* Where is the information presented and explained that such data structur=
es
  would be involved here?


>                                                                 and then
> reprocess the data however you want.  I don't think that Coccinelle can
> anticipate what structure the user will want.

I hope that data processing requirements can be clarified accordingly.


>                                                Making a list preserves a=
ll
> the information.
Will any other structures become more appropriate for data merging?

Regards,
Markus
