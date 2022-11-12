Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0D8C433FE
	for <cocci@archiver.kernel.org>; Sat, 12 Nov 2022 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pvHfAaWlRaDXpkkSO6iEvJUjgTGecEGM/ip/z04R5VI=;
  b=X3kgmESLiBDB/MJtzJ+RBPlNaXoIS14nAMqMX0g+Y5LqbcVDKgp+hGHI
   0zxkUdrEM9qtg4wDRS6x2BimWpStz5V1Znu+LdzSZs0+vx7Q4kIgrA19/
   KjtLDOy7kmOgxLSqu4NJmVnRS3oJJCZ92djbnio06pLZd0aUZgrkAX4UC
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="77858324"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2022 12:45:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8E0ACE039D; Sat, 12 Nov 2022 12:45:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 57FA9E0092
	for <cocci@sympa.inria.fr>; Sat, 12 Nov 2022 12:45:03 +0100 (CET)
IronPort-SDR: 636f873e_RlAQO8zSyrfayh+97j2Jf2SF1IVC9pKuscz18E6za3xbxIe
 UlLtC5+2OuUlDEkFQyKrtar+DrDjvTvFDatlcWA==
X-IPAS-Result: =?us-ascii?q?A0GNCgCQhm9jhw4P49RaHgE8DAILFYEqAQEiA4FDAgEBZ?=
 =?us-ascii?q?IECA1MuBAtFhE+QbDGEKY5QjDUPAQMBDTkIAQIEAQEDBIILgnMChHwCHQcBB?=
 =?us-ascii?q?DUFDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARkJFwcOE?=
 =?us-ascii?q?AUihWgNgjUpAXWBCAEBAQEBAQEBAQEBAQEBAQEBAQEWAg06GDs9AQICASMdA?=
 =?us-ascii?q?QERJgEECwsaAiYCAlcGDQgBAYJ5AYJtAQMNIwcMqxmBMoEBgggBAQacBh8sI?=
 =?us-ascii?q?lOBXgMGgRQqAwEBAZASeicQgVVEgTyCUzA+gmIFgV2DV4JnjnWIaiYEDgMZK?=
 =?us-ascii?q?x1AAgELOzINShsxJw4JHxwKBBcNBQYSAyBsBQo3DygvZyscGweBDCooFQMEB?=
 =?us-ascii?q?AMCBhMDIgINKTEUBCkSDSsnbwkCAyJlBQMDBCgsAwkhHwcWESQ8B1Y6AQQDA?=
 =?us-ascii?q?hAgOAYDCQMCJFRzAi4RFQUDCxUlCAVKBAg5BQZTEgIKEQMSDwYmRQ5IPjkWB?=
 =?us-ascii?q?idCATEODhQDXoFpBDVmmj+CHFoiPwlylz2sQzQHgh+BTIFNDIl0lHIGEy6DZ?=
 =?us-ascii?q?ZMJDgaSFJc0jUOaNYF6IoFcMxokgzZPAxkPjjmDWTOKLEA0OwIHAQoBAQMJh?=
 =?us-ascii?q?UcBAYUrAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:eaF/tKH5Iebu1cospLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="39563093"
X-MGA-submission: =?us-ascii?q?MDFOeVYJoAXMy/A42lmwqJMRwH/QKiVXS4AZ5l?=
 =?us-ascii?q?rirhs2WvTfJMEjTXEjpX+nLGjgRggE9sH8y1emim0dePDShYUn+JFGX7?=
 =?us-ascii?q?7DN/88XNPLkAiQzjwioeU/LiZonOvrCGVhlSdNKRxeevnbYi785l0wpF?=
 =?us-ascii?q?DihujvxKnVLfjQ4GFkCsG+TA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 12:45:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668253501; bh=pvHfAaWlRaDXpkkSO6iEvJUjgTGecEGM/ip/z04R5VI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tqm+3zVAHUVy9DqQYYMf3F0P3KXETr6Efd8Mg+lJ4xl57j6eQEsNC59K/+WbM9Iix
	 rezYvbZHek5SdweSs6hWqpWgu6S8a/6kAGWTeShQFPlviTPleneUqGu2pykBDTpWAg
	 IYnzqz8jW6m4h0rq+8x9UdVR8l1prgcnDebCK9fNm/0Wlspgmf6odlOXLnFGGAMA9n
	 xQxcX2XiG7T/361LVOr0sAH6fKebniJK9dZJFFGGSuf61mW2mTzqEIZQ7OHGKQ5hlq
	 FTsNuHf3Kb81EacY0hZluSECLiRQW/5uKHJ90fBCvaEoE2+6Qx5jR7HFUOoTrGlUs4
	 C48ArW4nKsoXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1VL-1pOl2h3qaV-00dTq6; Sat, 12
 Nov 2022 12:45:00 +0100
Message-ID: <42482c56-0add-0ad4-0a5c-b6542536329f@web.de>
Date: Sat, 12 Nov 2022 12:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Elia Pinto <gitter.spiros@gmail.com>
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
 <1282431d-b379-0ddf-5dbd-a50cb5d1605d@web.de>
 <17a6959f-993f-3342-dc79-ad684e4ac67b@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <17a6959f-993f-3342-dc79-ad684e4ac67b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:76H5dRwTsSdy2Udvou8KDjLJgd+yJxUXj5T7kOaUWREJ+4MMvKz
 xdeYntCkFOqOVJsl6Tr7Qxl2MdKWAm4UMFzDAESETcMO+G1pnv0ULGI0lrxNmzCFjvTiH9k
 VFjdLccQBPnOwagM9CEp8tqwgFkap4P8hHa1wEu6VvsvCAJ6yqcH4P+CbXAcsQDle9zQVRy
 8StJ/MkljNq25bBA463oQ==
UI-OutboundReport: notjunk:1;M01:P0:MiHwr0H9YJk=;iXLF4VOL6RKb06ADOlXb9jHHfbx
 9SRc9Tjc4q9AsJInOTTmQmBsRWgpREr1bbbbMcUI4PikmqUO7E/bo/61odxmX6WDcCniN33Lh
 tAFc+azxi9P1rgSfTbvj7YfA2Sj+DQcd+lXV53aDN18pGZDMiHPH1yy6jqHdO7aU1AGKe+EE+
 yqUbRD0bwK26agApwo2FBecVryG2du42B/lY6SjW0hAGlv73W9tj+/mM7v8c2XEjdCoMphd9X
 iuNhUV+ctcFO+GxDZly7uQtL+TcSnS+tgDLyrTs5APSemEF7OR0CSSiSxXYYl6Qq+9kPC9HNB
 c4y3wk8AGneFVDoA7ZBwOrnnCQP0wQcsmOjPlCZSYWHfQZAG1o0vmHs5ZYMIi0md+8q+5hN2k
 CC2Z0CwJdDWayKFE6gRqPD8MqgqOz9iJrrzfk3zIlU6cvAKB61qywWM7RJuXeal3lO+hOV8fr
 EfNgf6voYJlGxEIZTvKqjx/ge7z6LrdTM2hcPfVhBcEVfMJr72lGEFrXDD5I+9TMgll04WQLy
 5BOK9pdu+5oA0mE4eQjJRx6+5UuyqU1ohoihHoZCjXPgIUC01dL6VeHSgdr6DUdLla3+fqBT6
 Y6BgczzdGxzg0hhwtheP0EY8sNioqLfMi3SHLGJg9reo28eYV6EwSZ+0rQK4LvOWpzoC8y/V3
 tF8OAZaZ/xpHf2ZRdTMng4wYWnRK1IBOUjWK+qUs+vow/soyKaIKoHBFl7Zb2u1MX8tDH6KD5
 AraPEPMH7xDEujzjZUXZs713cJVVkPxqeUkheX7m0irBX8vStaKrKiWFYmbjqjvPthuGLztYV
 g60QlRwMbC6rtG0ZDNCVWVPJphTwlX7tXm5ZWOVnXLV/XqDn3HFe9SWv/gCroRBmbtGBzmW3i
 qpqWA9m1iwwMSQMQ92sD6oiCpT9FOr/pk6POhK9mTNr56vjfhPQCVEnmMl5f1bysJDXmqLAXt
 W+ZHvg==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 738
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/42482c56-0add-0ad4-0a5c-b6542536329f%40web.de>

>> Can another variant make sense for a transformation specification
>> if you would like to increase the change precision?
>>
>> @moving2 disable decl_init@
>> type t;
>> identifier x, y;
>> @@
>> =C2=A0t
>> -x,
>> =C2=A0* y;
>> +t
>> =C2=A0x =3D 'x';
> Have you actually tried this?


Yes (in principle).

I stumbled on the message =E2=80=9Cminus: parse error:=E2=80=9D accordingl=
y.


> Because multiple declarations, ie of both x and y, are not supported in =
SmPL.

Can this software status be reconsidered?
https://en.cppreference.com/w/c/language/declarations

Regards,
Markus
