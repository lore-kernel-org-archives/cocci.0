Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E86C433F5
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 21:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Rtqe5eQ5pZ0UhJm4tw2RoR5w/eI4j5XUWG6AWSh9VEg=;
  b=OmHeTIVXYtPUFJlJM/owgnJzlGPaXTis5PFEdQJHVlP4Y78Ux47jIgJH
   ivkRqY+ZvdSYoxdn1MKpijUY7vP/X+7AmRsZ7xV+zKsn8yfPsgavw+AWK
   m21rbEF8GLmKuXGxrLfdeiLkCnTMGKWTZHyuqb3Sqc564wWxv8IyePRzD
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
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25327828"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 22:16:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C6290E0362; Wed,  9 Mar 2022 22:16:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7632EE004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 22:16:46 +0100 (CET)
IronPort-SDR: 8gyxswha0/+HLJLBgiSNOHn+PcNudc9+ZfHtS3Lshw+U5V6PNWfO/HKg5EScmoH6VtbWYvdsRY
 cvsgrNbzuDYTUdR3y2dnC04Tpr4NUZXlnZ3rIU6yHHbkT7f2eLZjA48KrCmhgpiAOPA5aM4zxn
 Yvve05u5WfhEM8SFpTeYTHIGls15kpkQGxM3cO2a3Hz++AQtvwmMFSIAB4159R2ysFfNkPsiDT
 288jndwEFSUSeEhkVlrbNYfPN4HLho90oAaih9X+gt7h9syU+yV0Dl35YAZYhBHhHPPzTT16vd
 bVXV0rycDN7sq6R7r4Rh0qzt
X-IPAS-Result: =?us-ascii?q?A0C0DAAfGClihwwR49RaHgEBCxIMQIFcgiZpFVcrBAtEh?=
 =?us-ascii?q?FSOc4F3MZI5iieBewsBAwENEgEBJQUBAgQBAYISgnUChCICHQcBBDcDDQECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQEMDQkFCAoHDhAFNgZeB?=
 =?us-ascii?q?mQEgUsEgXQLNA2CNSKDbAECAgEjHQEBESYBDwsODAImAgJXBg0IAQGDAAGCZ?=
 =?us-ascii?q?AEDDSULrj6BMYEBgggBAQaBPwETQYI0HywiUoFbAwaBEC2NTXonEIFVRIE8D?=
 =?us-ascii?q?IJ3PoJjAQECgV6DGoJll1FZThKBXcAnNAeCEoE6gUALiT+UTAYULpY5DgaRZ?=
 =?us-ascii?q?ZZVjROZZoILA4FoMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDWTOBC4khQ?=
 =?us-ascii?q?DQCCS0CBgEKAQEDCYVHAQGMJgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:VbPy2Kr9K6th74Bia55c1qf50UJeBmIXYxIvgKrLsJaIsI4StFCzt
 garIBmOM/iMMWX0KNB1b9ngp0oHuZ/UxtRjSgBlrXg1EXxHouPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYA79gFaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSTVB9yII7Wn94mcCRlAgpjMKhD57z+dC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KZecmpSKEncwbvsqF64YrEEasALCcDxP54E/FxkwyvYC/kOXp3JBanHjTNd9G1t3ZoRTayDD
 yYfQTZSbBv7ThxmAE1NN5wfoveJviXRIiIN/Tp5ooJuvjSNlVUvuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt93WxmqnQkCm9VI96+KCEGuBCo0CLnXIwEhosbniGnOiSl0O7Xs1cE
 hlBksYxlpQa+EuuR9j7ehS3pn+YoxIRM+a89cVlsGlhLYKLuW6k6ng4oi1pNYR675VqLdA+/
 gDZxoOzbdB6mODNERqgGqGoQSSaFQV9wYUqQCgCUQIP6sT5yG3Ypk+REo87eEJZpuf1FDD2x
 zmMoG0GibwXn6Y2O0iT+Ffan3Szq5KPQgNdCuTrsoCNvl4RiG2NPtLABb3nARBocdfxor6p4
 iJspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiD/I9ANuG8mfBw4aa7onAMFh
 meM6Wu9A7cMbROXgVNfON3Z5zkCkPSxTou7PhwqRoASOMIsHON4wM2eTRfNgz60yRZEfVAXY
 NnCOceqEXsAD6l7hDO5L9rxIpd7rh3SMVj7HMihpzz+ieT2TCfMFd8tbQXSBshksvLsiFiEq
 753aprRoz0CAb2WSneMq+Y7cwtVRUXX8Lit9qS7gMbYflE5cIzgYteNqY4cl3tNxP0EyL2Xo
 injBie1CjPX3BX6FOlDUVg7AJuHYHq1hStT0fUEMQn61n49T5yo6atDJZI7caN5pvNux7h4Q
 qBdKcmHB/1OTBXB+igcNMWs8tY9KU7z3Q/ebTC4ZDUffoJ7Q1Kb8NHTfjzpqHsEAB2xuJZsu
 LanzA7aHcEOSl06XsbbYf6i1X2run0ZlL4gVkfEOIcBZ0jmtoRncnSjgvgyKsAKCBPC2jrDi
 1fIW0hF/7GVrtZsotfThK2Co4O4KMdEHxJXTzvB8LK7FSjG5W79k4VOZ+a/e2yPXm3D/qj/N
 /5eyOvxMaFckVtH79h8HrJswf5s7tfjveYDnAFjAWmNcFmhTL9teyHU0c5Kv6xL57lYpQrvB
 hPRoIYHY+3RNZO3CkMVKSokcv+Hi6MelA7S2vJpck/00yl6oeicWkJIMhjQ0yFQcOlvPIU+z
 btzscIa8VXm2B8tL8rAkS1esWiBdyRSX6Iiv5AcIYnqlgtylgAcO8OBUHeu7cHdcchIP2krP
 iSQ2vjIiYNc8UyeIXA9In7AgLhGjpMUtREWl1IPKjxlQDYeaiPbAfGQzdg2cuiR5hBAzv41J
 WVhcUF4TUlLE/GEm+AbN11A2SkYbPFaxqA140QEnivVQiFEk0TTeXYlN7/lEF8xqgphk/syw
 F1c4HnoW3DmcakdG8f0tVFN85TecDC6yuEOdA1L0ShI81nWrAcJWpOTWFc=
IronPort-HdrOrdr: A9a23:Dgl5yq8ni9xFswCd3Hpuk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25327825"
X-MGA-submission: =?us-ascii?q?MDG1np3XXLQU81exUKrHCSuGFH7VsoPMi8dPgC?=
 =?us-ascii?q?SFqXluMgn2LP+OZLvzn5pY7CCWqHpxoSc/ChsPvEkLOVp/y75K3bjyft?=
 =?us-ascii?q?9fQUxCCgFIRsCg+G5VlMHdRxqg6NnktjgMYlOLezXbLerbgEelOYnaSQ?=
 =?us-ascii?q?5bPpfkMEzDAHO2VQoisEKRhg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 22:16:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646860604;
	bh=Rtqe5eQ5pZ0UhJm4tw2RoR5w/eI4j5XUWG6AWSh9VEg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VzFDnGMp6zyf2kj0n5Jbax6JrJxO0+DcjenhRmYmnIDq7iRwtUaPg4kKKMflmaGuh
	 EUFGpNVfV0Sd23cq8zfM4UupILArB+gpiCsapIf/6GKWFVT9ZxRyJBQSABmozlXeYH
	 W0lWaw4aZMKuuzh4ghqZ7QzVwnV88sItxnE2zkOU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.114.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1nLBu138sT-00FjHf; Wed, 09
 Mar 2022 22:16:44 +0100
Message-ID: <7e14337f-c91a-4823-2678-865e85f3d16f@web.de>
Date: Wed, 9 Mar 2022 22:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <f79b9c33-f5d0-7d38-06bd-fde9f9e089d1@web.de>
 <997d4c43-9ee0-1fe0-a6b-1946b918ea3@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <997d4c43-9ee0-1fe0-a6b-1946b918ea3@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZHHWWHtztctmqG4NwkG7uXOYreRtphze6w2Zi2f4JlvTVKUFPO
 6753/CcgAe5r+zjnkv90njYSi6JPmO+Vo83bC87JVX/KXwqWXI5Y41trnYYiSqlt4RBGcGP
 k1x5efpTC6FwcR4NEOxaXxf9DBBWwnNaTAzWYXAwFMv+kGCzS/RQ/2IrBzpsTblKXUb1nEa
 f3DSIIf7EwPA9UpXevLZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VU8b1RVmq/I=:VTWUo60pafs1EezdbAwmAL
 +jAks+pxo2uR9pegPTq8rM/278iSsPKXA4avdlMvg1K17vfBhWC8f56T7o5mMeG6jk206/LRR
 7cPSQqFDtiHiXz8qhfAvm/IIj/Ky0Cb5bzM0lK+2xJko6U8HXLqg5dk66ldEWPjPqSUGZESYY
 wo7jENklA+SUIHoONsC6szvzt/xSfv+G1gtF49mrW8vFEQk3ZlzgPALXJ5LfnTjdjXNDfvVAE
 YOOLyRtuZLXqseKbSlnQU6Sb1JtmK/ZXGrqWsKa/87XHE2jgcNHFHZHqGlN6Hid8K0X+FE8qr
 mDRGYpRJg7jColZtBCoc9AbP47e6MkHvjeu20frVJW0Gr2v5y/2vm6EjFlOQ9ybcdnuksMn4t
 zkAGSz2i9L4t9xhuFTWWen/kDy7iTb7HnYoia1bZUquvKfGxoX5ONte5E8l+trjHTzC/LL4Pt
 bBb9ftigLY5NBy0z3pZkArhV4V6vcnV78w6i/gGIZUJMnNrUL9gxAlGH4kd2gQdHGBZHYpUzl
 k7gdpbvWACwBj31tp5SA7jlSUwm7KrQyYqWWfXaRXTE63vmtwPDuTf9DD3wyhTFBoi/aeQTQX
 OGW/IC/Q00NUI8XcK53cYthhuYrg0wnZOxDIoYQFKrjmVkqcYxY60baCDsDX1Q55HZWNih16O
 W4Phb5E5+JQ+WXo9Tw761hg40s9rpuhpLnv16y+8n9PKW8cmOkKikc76z1gX2JOaD3HA3DKaN
 10/QyzXuMRMKx0GoaMYO2CQLh9TUEsMaazjWXOzvYDJvkzLfsy8eQ/ImNLgH/H/0F13wY6K3y
 noPIAxDP02FIRjDi4V7EjS3b6tOxRJhvSNqDTrjgXQsVRv9P8I5S762+147/fdkW5sAQ3lVWM
 19KELguLmTTbyUOVGMdrIZa4Ld/2s0cjwVaBdVRs6mkqhG6IYetKUnyL3gXv0fGnv2g3eyub0
 KnvaKq8hAOjeoioKz9i438/aHws/px+Z/7EsZCpSzTsuDgbLkdHPU3qonpQ5GfM+y+mRnaBhH
 uimLzZ4iNckPBdULJAkpSznVDjlRsHqRawWGpuH9l85rec4szNk0QP06n46ZkxRNEJ3T88Gmh
 VJUo5UTvyWktMc=
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 197
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/7e14337f-c91a-4823-2678-865e85f3d16f%40web.de>

>> Literals can be found with the means of the semantic patch language
>> by the metavariable type =E2=80=9Cconstant=E2=80=9D.
>>
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e8=
4ddd5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L216
>> https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b=
6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L216
> Can literals match substrings like ".gplot" for cut-and-splice?


The Coccinelle software contains some known limitations.

Some limits can be adjusted if you can manage to activate extra possibilit=
ies
by switching parts of the corresponding data processing to one of the supp=
orted
scripting languages (like Python and OCaml).
The application of (advanced) regular expressions provides various chances=
,
doesn't it?

Regards,
Markus

