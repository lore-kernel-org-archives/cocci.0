Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8FDCCF9F0
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BilsgS0YzTDiVqF6CJB7B4DL1rMy0d9AqQ9HtmQkYEc=;
  b=EUEj7Uij9YUoEsZrulsxy8AWDnGYw/YcNph9LqdsuawabREoqjpipSM6
   lDYgOMjDmmt+zrDts4TISzBLZ9CCU0EMVQ8WA6XuHEf4Zyha88ri0MQBD
   kasJJEBHJCzwIwWvHuG6VySjp3taECvNROnqbj9oCrJolnHdSI0GJD92s
   s=;
X-CSE-ConnectionGUID: DzXXHOTGQY6Zyh2ihhdwtg==
X-CSE-MsgGUID: gLQ4nSVISkiNy0/s/ZdbLg==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246864036"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 14:35:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6C462E0CD5; Thu, 30 Oct 2025 14:35:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 54187E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 14:35:51 +0100 (CET)
X-CSE-ConnectionGUID: VkhYRHH3SXC6nwDKv3gMgQ==
X-CSE-MsgGUID: +W3CRyZKRVuMBeaf8DdAww==
IronPort-SDR: 690369b6_nFPgs6bHWdHxYjfBvtOlBelVt4bT5QKR8LfzHllaKtq0cvi
 edCp+Denfppdsu6D/NmFHSaU0X8Bn4Onnib/+pg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FqAADVaANpeAwR49RaHQEBAQEJARIBBQUBQIE9BwELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1KCJIQ7hzyQToFVgX0CDwEDAQ1OAQIEAQEDBDiBVIJ0A?=
 =?us-ascii?q?oxTAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AFDDgoxhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn6CIwEGEAEDDycHsFuBMoEBggwBAQbaXx8sIlmBZAmBH?=
 =?us-ascii?q?C4BhWyCZAGGJ4NDeicPgVVEgTyCSwcxPoRDg1uCaYImgQ6GKZI9UngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEgQwMqNC0jDzwFLR2BJCIfGBFgPRdAg0kbBmgPBoESGUkCAgIFA?=
 =?us-ascii?q?kA6gWgGHAYfEgIDAQICOlcNgXcCAgSCG36CDw+JEAIBC209NwkLGwY9lDODV?=
 =?us-ascii?q?JYzgz2vbDQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQYiqR+BagM1gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIQwWHIN1yypCNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23:ItJNzByWnRN0r2nXCzK4w1BlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xeZvakm1QGXAt6Tq6odzbaN6Oa4Ai1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYj4ZuMLo9xxTGrndVeulbxGFlKFyOlBr4+su84YRv/itetv8v7cJMTav3c6ElR
 rFEEToqNHw468LsuRTfVwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb47QTqt4
 L5nRQHnhikaLzI2/33ZhcJ2jKJAvRKuvAd/zJLOYIGUL/VxYKXQds4HSGVbX8ZRUytBAp6gb
 4YKEuEMM/pUo5X7qlATtha1GxWiC/3zxT9Jnn/23LM10+I9EQHdwQcsG8sCvGnIoNnpMasfV
 /2+wqvVwjXZd/5Y2jnz54fGfR48v/+BQ7xwf8rTxkYzGA3IlUmQqZX/Mj+JyugBrWqW4ux9X
 uyvkW4nrARxryCoyMg2kInJhZ8VykvZ/it2xIY1K8e4SE99Yd6rDZBdsCaUOJFsQsMhXmFoo
 zw2xLICuZ61ZigKyZInxxHEZv2JbYeH+QjvW/uPLjphgn9uZb2wiQqo/0e61u38Ste70ExMr
 iddktTBtGwA2wHP58WbVPZz8Uis1DWP2g7c9+1KLkA6mbbVJZM/w7M9i5QevEbfEiH4l0j7j
 a2be0Yl9+S07+nqY7PrrYKfOY9skgzyLLkiltKlDegmLAQDXXKX9fm+2bH54EH1Xq1Gg/k5n
 6XDvp3WON4Xq6+9DgNPzIou5BWyAjG729oCh3YHNkhKeBefgojpJV7OJPf4AO+6g1SrjTdr2
 +rKP7P/DZrWNHTMjanuca58605a1gUz0chS64xJBr0fOv7/RFH9ud7CAhMkMQG42fvrBMtl2
 oMbQ22PA6uZMK3IsV+P4+IiO+6Ca5UPuDb+Nvgl/OTig3A9mV8TZ6mp3J0XaH+jE/VoPUqWe
 mDgjcofHmsSpAoxUPTqiEGeUT5Uf3uyW7gz5z8hB4KiCYfOXYGsgL2E3CigBJ1ZfHpKClGKE
 XfydoWLQe0AaCyIIsN5iDwLSaChS5M91RGprAL1171nIfbI9S0Zrp/jz9h05+jLlR4o7zB0D
 sKd03uMT25uhG8ISSU20Lh5oUNm0liDy7R3g+REFdxP4PNEShk2OYbTz+NkDND8WRjPc8+HR
 lipWtmmGy8+TswyzdEUe0t9HtKijg3f3yawDb4aiaeECIYp/a3Cx3T+OsV9y3fD1KQ5l1coT
 cVAO3O6iKNj8QbfH5PGk0CDmKawaasRxDbD+n6bw2SBpE1YSxZwUavdUH4FekbYsMn36lvZT
 7+2B7QoKgtBxtCGKqtNctDnlUxISu/sNoeWX2XkuXq0BB/A4rqTZY7uMzEfwSHcAQ4Amh8a+
 XKuNA4kBy7nrXiISHRlElnkYmvt9/N/oTW1VBwa1QaPOmhozbmo4VY4gfKGSvUcluYhsT0it
 i4yMVKzxdPQBPKfqgAncKgKMoB120tOyW+M7181BZenNa03wwdGK2yf3mvr3hRzUMBblNQy6
 Wktx0x0IL6Z11VIc3WZ24rxM/vZMDq65wihPojR3FyWy9OK4uEX8v1tjlz5vxyyUGcm/W9m1
 dZ9zHaWoJnHX0IJSZykak8s7FBhoq3CJCw05ofaz3ppZIy9qDzfwJQEAOU/yxCvV8hSOuWIG
 Vy6CNUUUu6pLuFigF21dlQEMeRVobYzJN+jfuCa1bSDOeF9gHS5gG4B7I0VPluk0S16R6aI2
 p8Ex6vdxQ6bT3Lmi1zntMnrmIdCbDVUH2ylyCGiCpQDLqt1NZ0GD2ujOajVjp13moLtVnhE9
 VWiG0JO2cmnfgCXZkD82gsY3FoeoHiuky+1hzJulDRhoq2a1S3Ii+PsEXhPcktCXmp/lhHBJ
 YaujtYVdFelZU4lmVrt5Er3wbRauLUqN3PaEg9Deyn7KX0nU7Pl7OPYJZQVt9Vx7mMOCrfZA
 xjSULP2rhoE3jm2GmJfwGp+bDS2otDjmBc8jmuBLXF1pX6feMdqxB6Z6saPIJwZljcAWiR8j
 iHaQ1amONz8t/CdjZTeqaaTU2y7V5tcWTbmx8WMuWHogA8iSQ36hP21ltD9REIf2DX4ysIse
 CHGthf6baH02q78Pe8tLSwKTBfsrsF9HI95iI45gpodjGMbipui9n0CiW7vMN9f1MoSdVI1T
 CUQi57Q6Qnhggh4K26Rgpj+XTOby9dgYN+zZiUX3Dg85oZEEvXc4LtBlCpz6l22yGCZKd10h
 DQA0r0D7HAAgucGkBUgxGORD/geEFJZMirlixmTp4rn9uMNPjnpKOf2jRA2lMvpFLyYpwBAR
 Hv1H/VqVTR96MlyKhOE0XH+7J3lZMiFaNsSshOOlBKTx+NRKZ83ir8LnX89YDi75yd6jbdky
 0U0jvTY9MCdJm5g/by0GEtdPzzxPYYI/y31yLxZlYCQ1pyuGZNoHnMKWoHpRLSmCmF317yvO
 gCQHTk7snreF6DYGFrVzU58rG/UVb2vOWuWInYx0thoAhWQbh864khcTHAhk5g1Gxr/junoa
 kRk/XY84lDiqx1D4v1lPV/zXy2MwWXgIidxQ5+ZIh1M6whE7EqAKs2S4NV4GCRA94GgpgiAe
 SSLIh5FBmYTVgmYFkjua/OwsMLY/bHSVY/cZ7PeJK+DoutEW7KUyIKzh8F4qi2UOJzHNytnC
 OAnnFVOVzZ1FozQyTAIVjBShyzKddGSvhv65SB96MyylZajEAu94IySF/5YNshp8B3wnqqJc
 eKdzC8rLDFFytYH3nXVzLtZhVcUh3gofD6odNZI/SefSaXNhupcFBUccTs1bcJO4/t61Q5Ic
 djSjte/vlJhptgyDVoNFVnom8XzINcPP3n4LlTMQkCCKLWBIzTPhcDxe6K1D7NK3q1SsFWrt
 DCXHlWGXHzLniT1Vx2pLeBHjT2KdB1Ytoandx9xCG/lBNv4Yxy/OdVzgHU427oxzn/NMGcdN
 3B7fSYv5vWI6jhEh/xkB2Fbxn9iMPXChCuTqeXVa94XvfZtHiVohrda7XA9mN43pGlPQP14n
 jeXr8Y7+Qj81LPVlXw+D1wX8GUu5srDp0hpNKTH+4MVXH/F+EhI9mCME1EQoNAjDNTzuqdWw
 9yJlaTpKT4E/ciHmKlUT8XSNs+DN2IsdBTzHzuBRi4MVz22Lifyg0JHkfed3mKYpN42p9K//
 fhGAq8eT1EzGv4AXw59G8ceJZ5sQj4+ubuckdJO+ne06hXcDpY/3NiPRreZBvPhLyychL9Pa
 k4TwL/2Go8UM5Xyx01oblQSdGviBEfaG9xA8HQJhu4cpUJQ7D5hQ2d110+3MmtFBVcMGPTyk
 hNk0mND
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kCpK7aH9ISekJ3qYpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:LWelRG9wlWx74KXPkzCVv3AXGvEfUl2G90f7fUmnJUV3E7KwRmbFrQ==
X-Talos-MUID: 9a23:+XtRzQTAoEopBaKIRXSvu2pJDtZawJ6QFWUnnJwI6+WIHDNvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246864022"
X-MGA-submission: =?us-ascii?q?MDG3x/fMYU4Eyf9O/j89CZgsd6MmwB7HhxQdoa?=
 =?us-ascii?q?yxtWkKCUlGgBkPLLb7B+Fk/RoNyLZO4MGjTFOHVH9xkW7hv6QLDGQDz2?=
 =?us-ascii?q?qAEBjRQN2apMf0amWEw4CVV5xjt74eKnMUBmwBMUgAdbNXXI7zv8ZbBN?=
 =?us-ascii?q?Yccwllc0QVsUXo52S8FH/jqw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:35:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761831338; x=1762436138; i=markus.elfring@web.de;
	bh=BilsgS0YzTDiVqF6CJB7B4DL1rMy0d9AqQ9HtmQkYEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GnOGzv5956ukglOMTwcSHQPB+iAY7PykZx7uz/+n2u50sZFZg/2kJZrYbunCNFCe
	 8iw+T20ZJIUrYZ39kiGNbHbPzYF69Yee9F4v1py4ApDFaXWmysxwOR/CH5rVx6CBj
	 ULw8x7XMNJMOblkPibS2mlDprA8Rav0uOzUhikDZ07FtE/vsM974NayqFtZcHJyYN
	 3KXXMIUOu5KOdjFIS3pl1bzluIAqMG273JiZsJIYiR+3Ai7WzE8kAxW7lXBDswxFh
	 DGC5AfXscgQSFgOHst/F+PG2yMUrB3B5+E/YEpVwh02WKjMHqaIwTHvk6J74acwnF
	 5soVpI4f9I4Z8E06Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqPT-1w0hj90M5Z-00gDgx; Thu, 30
 Oct 2025 14:35:38 +0100
Message-ID: <abda1fe0-af59-4fa9-a1ec-efda0f63b3f1@web.de>
Date: Thu, 30 Oct 2025 14:35:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckJGi+MlMgbDDStuXLOJHnmprq4QO9KBym0BQ64Ua/zitYUbB8H
 SxRJNzgQBRamd0XsiDjyR3ylNwxZ8c8UQ0JFMX/k0fozZN+sw7WH22QPKAmMJ6Ri46rO1+M
 nUcEO8xWpxLUfp7n+GNXm0+9d4BexsCizOEP3vha9Fp5n5+ojigIhZG8j+Zc1nvTVdlYq+o
 oOndvvr6JnGre/lohqxOQ==
UI-OutboundReport: notjunk:1;M01:P0:c04x0g4n5ws=;7+xR6V3YAf0DU0BRRKVwXa1AW/p
 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
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3121
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/abda1fe0-af59-4fa9-a1ec-efda0f63b3f1%40web.de>

>> I =E2=80=9Caccidentally=E2=80=9D tried also the following SmPL script v=
ariants out.
>>
>> A)
>> @replacement3@
>> expression object, size, source, target;
>> @@
>>  target =3D
>> -object; memcpy(target, source, size)
>> +object; memcpy(object, source, size)
>>  ;
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment3.cocci arch/arm64/kvm/arm.c
>> =E2=80=A6
>> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>>                         goto out_err;
>>                 }
>>
>> -               page_addr =3D page_address(page);
>> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvh=
e_percpu_size());
>> +               page_addr =3Dmemcpy(page_address(page), CHOOSE_NVHE_SYM=
(__per_cpu_start),
>> +                                 nvhe_percpu_size());page_address(page=
);
>>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigne=
d long)page_addr;
>>         }
=E2=80=A6>> B)
>> @replacement4@
>> expression object, size, source, target;
>> @@
>> -target =3D object; memcpy(target, source, size)
>> +target =3D object; memcpy(object, source, size)
>>  ;
>>
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/=
bin/spatch --max-width 100 --no-loops =E2=80=A6/Projekte/Coccinelle/janito=
r/use_memcpy_assignment4.cocci arch/arm64/kvm/arm.c
>> =E2=80=A6
>> @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
>>                         goto out_err;
>>                 }
>>
>> +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_st=
art), nvhe_percpu_size());
>>                 page_addr =3D page_address(page);
>> -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvh=
e_percpu_size());
>>                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] =3D (unsigne=
d long)page_addr;
>>         }
>=20
> Not sure what is the point of all this.  Try:
=E2=80=A6

Would you like to acknowledge that undesirable difference displays were ge=
nerated anyhow
for these test cases?


>> Would you like to reconsider implementation details accordingly?

Are we looking for corresponding software improvements?

Regards,
Markus
