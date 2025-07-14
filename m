Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E13C83F1A
	for <cocci@archiver.kernel.org>; Mon, 14 Jul 2025 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3dUFIuykVB2n/kW8a6cCjlPkbJ7J3u98TIqB2qBHMDY=;
  b=oKRW3zpG74KHK1sYoQj4Ji3qjUBVIlkEmCxLs5arwbGh+y8NuTGFF/7K
   lNQXV7uE38+zhmJ1fDyi4q9B+MoZRBu3wMxcnbTkYI359myGoze0Oksai
   X5IREnnwGaQppBfrEFxnmJ603XFx/M85yTrUIlCnXSUvSWw8wB7yY7Ypa
   Q=;
X-CSE-ConnectionGUID: F/lr8w/ZTLaKQn+SAdu4Ow==
X-CSE-MsgGUID: CjTpeao1T2uAzAFCp4ymZQ==
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
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="231560508"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2025 13:13:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0DA58E0CCC; Mon, 14 Jul 2025 13:13:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CB820E007A
	for <cocci@sympa.inria.fr>; Mon, 14 Jul 2025 13:13:57 +0200 (CEST)
X-CSE-ConnectionGUID: as6MvUqoQg+DKyik046O7w==
X-CSE-MsgGUID: avklny8iTiywWZFnKxWufA==
IronPort-SDR: 6874e675_WumtsriFAdIlOrKUt2Nl/Npz7wQZSp58fex+0DXU779r+li
 6Z9VENpIl9H79mJQIHhkD7xzZ+0CfnOh71qv6ow==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FsAAC75XRogA4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQAGVDMEC0kIhE2PUIIkhDuPD4h4gVWBfQIPAQMBDUQKAQIEA?=
 =?us-ascii?q?QEDBDiBVIJ0AowDAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINOkQBA?=
 =?us-ascii?q?QECASMEGQEBESYBBAsLGgImAgJWBgEUAQGCfgGCIQEGEAEDDiQHDQata38zg?=
 =?us-ascii?q?QGCDAEBBoJp13UfLCJZgWUDBoEbLgGFbIJkAYYnCYQzJw+BVUSBPAuCeD6CY?=
 =?us-ascii?q?QSBXoNbgmmCJoEWg2Q2gjOKIIcoUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtH?=
 =?us-ascii?q?YEnfoMKgQ6EKCtPgiJ1gXlBGT+DUx4GbQ8GgRgbSgICAgUCQ0xAAgELbT03C?=
 =?us-ascii?q?QsbBj2SKYNvD2GBXpNysyM0B4I4gWeBZAyKLpU9BhMvl08OBpMCmQYijWWbN?=
 =?us-ascii?q?oFvCyiBXDMaJIM2TwMZD44hDBaDXjO8E0E1AgE5AgcBCgEBAwmFRgEBiCCBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 QMqzBRza6Ih+WW0i2o=
IronPort-Data: A9a23:a5VXPqMer04UBLrvrR17k8FynXyQoLVcMsEvi/4bfWQNrUor3zwAy
 zAXX2iCOP7cZmDyfdEjPYu0o0gF7ZGDyYBqHHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48D8hk/jOHuehYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcqWo4ow/jb8k43462u4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+BsBOKjAbzsAD+v5T2Mg0MS+7uB3V9zxF8
 +ihgLTrIesf0gIgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADkWMDWduvux+b34Zsp9h8d7cJfMY5xK7xmMzRmBZRonaZXEXrmM+tJSmjs97ixMNayHP
 YxDM2UpNUmGOkEn1lQ/UPrSmM+Nj2P8biYehVabv6sx7EDMwQY33LWF3N/9I4bTHp4IwR7Az
 o7A123nARUcJYye9TuU7U2eqOnsjRzmVqtHQdVU8dYx3A3LnTxMYPEMbnO/qOawjkqWSdNaI
 VYdvCsot6k7skKxJvH2WBazoVafrxsEUpxRFfc74UeD0MLpDx2xA28ZUnheZdZguMJeqSEWO
 kGhlsi3ICJSqbqsRjGx1aaVrmvuZw9KMjpXDcMbdjct797mqYA1qxvASNd/DaK45uEZ/xmvm
 lhmSwBh3t0uYd436kmtwbzQqx6BzqUloyYw4RjLGH2o5EV1aeZJhrBEC3CKt56sz67AEDFtW
 UTofeDAtYji6rnTz0SwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbZteJWSwP
 B6L4lMPjHO2AJdMRfApC25WI5t6pZUM6fy5B6mJBjazSsMgLV7cokmCm2bKhD+xySDAbp3Ty
 b/ALZb0ViZFYUiW5DuxQeAGmaQmrh3SNkuDLa0XOy+PiOLEDFbMEeltGALXMogRsvnYyC2Lq
 Yg3H5XRkX13DrahChQ7BKZJfTjm21BhVciu86S6t4erfmJbJY3WI6SPnuJ7INw9xPo9eyWh1
 ijVZ3K0AWHX3RXvQThmoFg6AF82dcch8yAILmY3MEy22nMuR4+q4e1NP9E0ZLQrvqgrh/J9U
 /BPKY3KD+VtWwb33W0XTaD8i4h+KzWtpwaFZBS+bBYFIpVPeg3u+/3fRDXJyhUgNCSNiJYBk
 +WS7T+DGZsnbCZ+PfnSc8Oqng+Qv2BCuedcXHnoA9h0eWe3wrdLNh7es/4TCOMPICXl2TG1+
 Vu3AxAZhO+VuK4z0oDDqp6lpreTMdlVPxRlDUzEy42pJA/m/maH6q1RYtaiJDzyejv9x/S/W
 L9z0fr5DswioH9LlIhNS5BQ0qM04orUlY9wlwhLMi3CUAW2N+lGPHKD4Mhos59NzJ9/vS+de
 BqG2vteCIWzFPLVKnwjDyt7Ub3bztARoCfY0totKkaj5CNXwquOYX8PAzay0h5iPJlHG6J75
 9w+ufwmyR210TsrFdekshp61UqxKl44bqF2ka1CXaHKjFIwx0BgcK7sLHb8wKuyZuVmNmgoJ
 T6ph5T+uYlM+3qac1cOESni4OkMo7UPpxFA83EaLXurhNfup6E6zT9RwxsNXyVXyRRLidxyH
 m1RM2x0OqS80DN6j+dTX22XOl9gBT/I3mfT2lc2hGniYE3wbVP0LUo5IvSo0H0C1mBhIghg4
 7CTzVj6XQbQfM3e2jU4XWhnoafBSeNd2xLjmsf9Oei4BLg/PCTYh5GxaVoyqxfIBd07gGvFr
 7JI+MdycajKCj4CkZYkCoW11aUidz7cHTZsGcpexaIuGX3QXBqQ2jLUckC4RZ5rFszwqES9D
 5RjG9JLWxGAzx2xlzE8B5MXArpKjfUstcsjeLTqGDY8iIGhjAFV6bDeyiuvo1UQYYRKsd08I
 YbvZT69AjSupX9LqVTs8uhAGESFOOchWiOt/dqI4N0oFo0Cut5CaUsd8KW5lFTLPRpF/yC7h
 hLiZajXxdMzkIhHwtDeLYReNSqJKPfYdueBwCasuftgMPLNNsbvsVsOi1/FZg55A5oYa+5Vp
 5+s7uHl+VzjvakkdkzkgLyDKvV53tqzV+9pLc7HFnlWsi+cUsvK4RFY2WSHBbFWsdFavO+Le
 hCZbZauSNsrRNtt/n1ZRCxAGRI7Ca6sTKPBpzu4nsucGComzg3LA9O2x0DHNVgBWHczBKT/L
 Qvot9KFxNNS9t1MDSBZIcBWOcZzJVu7VJY2c9H0iyKjMVCppVG/oZrnqwsr7GDaK3uDEfui2
 6n/eDrFSE2Qtp3LnfZjiK4jji1PWTw5yaM1c1kG8tF7tyGiASRUZa4BOJEBEddPnja0yJj8Y
 yrXYXA/DTnmGw5Jagj4/M+pSzL36jbi4TslDmdBE4KohyaK6EeoBbx86mF/7n0wdjaLICRL7
 z0B0iWYA/Rz6sgBqSUvCjiTnuptgP/Xrp7N0V6oiNT8Wn7yHp1TvEGM32NxuejvDMzH0knGT
 YTwqaaoX2njIXPM/Q1cl7K51f3XUP4DD9nlUMtX/Ovihg==
IronPort-HdrOrdr: A9a23:ZjPPM6ljd8RJkpIwp2/nI09Lv3XpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXd2FdAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2njaLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:pRDdMGA8MMDl6KP6EyB8qmsKJ9kiS3Ke4FTBIkzgVThOF6LAHA==
X-Talos-MUID: 9a23:G1GFlATAKvrjCx/mRXTlmjJmMtY44pivGV8yo7sAmNm7KCJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,310,1744063200"; 
   d="scan'208";a="121335700"
X-MGA-submission: =?us-ascii?q?MDGd4SBtigW9vikeV4Y+zOVj2+3G9HkK9WVTtg?=
 =?us-ascii?q?1qRKF3EypZyqB1oPMufod/EGIGRsAjOjvv9FuI/twY6hXzuWGzY4wUOr?=
 =?us-ascii?q?21yFPq1wQQ6eKl14EWyCGOpF1BDHn3x2chaLID/pB7mFcBBG/n06SYRg?=
 =?us-ascii?q?BAJ3xzPDcbjbmBAsGqugmpfA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:13:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752491635; x=1753096435; i=markus.elfring@web.de;
	bh=3dUFIuykVB2n/kW8a6cCjlPkbJ7J3u98TIqB2qBHMDY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=an9IHGl4/6Cyzzf/d/wmNXPksDSqUqcRgjuY8rPR+U1tSw8hXPPtEjC3kiEdXJbK
	 5f8vw9N+UsQE5lqsNYGI53rew5y1NQd/T9z4bY51AgUnek1ri3dzBz4esMaNzWLQI
	 IR1HUKVFpeJv+QTqd5/QMhqLXDQhlEzxgo8FVbTTQVJouZlPrwk1KZy6Kwucs6QLs
	 ijzwTyxrE3vnAHuL5y3brbqhILjlNxx3fHQlZjWm9S3+E/mS9z3zvLHBpQocGKIb8
	 8Wnz6UA20y6z/wHCyF5wdFiIaEhwnjvitOOJzQKYzteODfH+3f8GMFpJO1DtnMxi9
	 hF/IIToDmMKYy6y2wg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ISh-1uWc1m06nX-00BCQP; Mon, 14
 Jul 2025 13:13:53 +0200
Message-ID: <9305a7cb-f54f-4655-8802-be7475b6b3ee@web.de>
Date: Mon, 14 Jul 2025 13:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: Yue Haibing <yuehaibing@huawei.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <8b094c79-c6e5-4398-a2a9-37e9d46a46e8@web.de>
 <BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7@inria.fr>
Content-Language: en-GB, de-DE
In-Reply-To: <BBB485D5-F5B1-493D-BDD1-FF8A1FD38BF7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Sa4Q73CVmiC09SP0rYw47H+qNfRYq8tw0R+gKryt97eAVf1lZX
 fkcik3K+NGWXvUCNWAPsArRTIE1/yGHDEhwgmXvxWxESpcFl/37CTcYBg5XYD5L22OZR5IZ
 m68HeQ+zRghMNur2PEzlwOtAnSJoqUi8r1J/HGT5g2fZzakDHUb8+x15tUKD/6kXDJuUbRR
 HQwlLtZ73G5vLGQZDqxJA==
UI-OutboundReport: notjunk:1;M01:P0:LqxnEAvd7NM=;vZVkHLPzc6Dpm62YjfuxCPEX7y3
 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
Subject: Re: [cocci] Deleting duplicate condition checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2869
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/9305a7cb-f54f-4655-8802-be7475b6b3ee%40web.de>

>> // https://elixir.bootlin.com/linux/v6.16-rc5/source/net/ipv6/mcast.c#L=
786-L813
>> @adjustment disable braces0@
>> expression e;
>> identifier i;
>> @@
>> void i(...)
>> {
>> ... when any
>> if (
>> +    !
>>     e
>>    )
>> +   return;
>> -   {
>>    ... when any
>=20
> I have no idea what is the question here,

Would you find any details improvable in the generated diff output?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch =E2=80=A6/Projekte/Coccinelle/janitor/delete_duplicate_condition_c=
hecks4.cocci net/ipv6/mcast.c
=E2=80=A6
@@ -789,34 +789,31 @@ static void mld_del_delrec(struct inet6_
=E2=80=A6


Examples:
* Coding style preferences?
=E2=80=A6
+       if (!pmc)
+               return;
+       if (pmc_prev)
=E2=80=A6

* Indentation?
=E2=80=A6
+               for_each_psf_mclock(im, psf)
+                       psf->sf_crcount =3D idev->mc_qrv;
+} else {
+               im->mca_crcount =3D idev->mc_qrv;
        }
=E2=80=A6


> but the above when any is useless. Braces always match up properly.

Will such information become relevant for a better software documentation?

Regards,
Markus
