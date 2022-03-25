Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BFAC433EF
	for <cocci@archiver.kernel.org>; Fri, 25 Mar 2022 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=CscK3+e13abaUU5hZ4kqSOa5F/ASd76SSD5EvmWOJQ0=;
  b=JJGegIp/Spfvbibbe3dO29eduZpA/jw9kSCVFEWSruugXVxINvMhqv6m
   TJX22Iy1UhRFgJ2WRt5Z3UQWxcfW4MKYR298Uso9nmpD1HDad2p5oXudi
   AoHelsV65JRkdpdfC1ZqoQFAZ1vFjk9sHdkNpHVvkYtXlzWhqLCtWOjOT
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="28206813"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2022 22:18:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02BEAE4370; Fri, 25 Mar 2022 22:18:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 18786E436E
	for <cocci@sympa.inria.fr>; Fri, 25 Mar 2022 22:18:32 +0100 (CET)
IronPort-SDR: xjNu4wgporsUsL1NSZfEJVvJwjI+cnIzp5VvoTlHJ9YjUAruZ8TnCT2qB6x0tzhWgkC9eNiodZ
 9/GkcTaY2R5mYb4Bi6C1BloKi6bncgJp0eZFiLq8uCvy6zoDJvC48o/9HsvhF0d7hAs/Q2xkbq
 BbeROt3DznxlxY8p6DEr/beMc6h3qrqOqE2LjYGEkplQFeo+YDwrULt9uGUdanOw3T3GIzXDna
 TzDuLzA7ouLfmny5Ita+9UDe6tOll2cWRdTZUHEw1B7fHQ7ip9dlqvpWKgYedKge//adg6QdxC
 osu+BEzJy0yKv4mIAH/2zeFZ
X-IPAS-Result: =?us-ascii?q?A0DeCABpMD5ihwwR49RagQmBXIImflcrBAtEhFSjWIoog?=
 =?us-ascii?q?XsLAQMBDRIBASMJAQIEAQGCEodFAh0HAQQ3Aw0BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0CwcIJQ2CN?=
 =?us-ascii?q?SKEFR0BAREnNAImAmwIAQGDAAGCZAEDMguwBIExgQGCCAEBBoJcgWwfLCJSg?=
 =?us-ascii?q?VsDBoEQLYYTFEOIBhCBVUSBPIJTg1EFgiqCTYJll2WCLS+CDjqSCBGtYjQHg?=
 =?us-ascii?q?hKBOgWBPAyIJYEdlE8GFC6WQw4GkW+WXI0WlDUdhRuCCwKBaTMaJIM4TgECA?=
 =?us-ascii?q?QINAQICAwECAQIJAQEChUuIa4NZM4osQDQ4AgYBCgEBAwmFRwEBjBcBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ECP+Ka1t2QOqMlkSMvbD5dt3kn2cJEfYwER7XKvMYLTBsI5bp2NSy
 2cWXTqEOfqKMDH1ctAjPYy+9kMOu5PRy9RkGQE53Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX5
 IupyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt5N+y
 OxKh5KQcD8kOZeVmfotaABYOT4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KNecWplghOr34paxJqeQ/Nvm99lAc3lJoIZtVl/wDufAftOrZXrEvuWtY8CgF/cgOhCD+bOW
 okSSwNUcRicZgVJPQYeMcwxybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 HiuwojiKhQdKcDZ1jePtH6h7gPSoc/lcMEdFIS/xPBKuWWewVZKCQMmbkK7i+bs3yZSROljA
 0AT/yMvq407+0qqUsTxUnWETJis4UV0tz14TLRS1e2d9kbHy1vBWjNeElatfPR55JZmH1TGw
 3fTx4uBONB5jFGCYV6wnlt+hRa1PzQcJ2Yff0fopiNYvYW6+OnfYjr1TttiFqq8iNGwIT/5x
 yLikcTTr7AUkNJNyKixu1zK695NmnQrZl5ojuk0djv7hu+cWGJDT9LygbQ8xagZRLt1tnHb4
 BA5dzG2tYji962lmi2XW/kqF7q0/fuDOzC0qQcxQ8l4qmj1pyP9Id84DNRCyKFBbZdsldjBP
 x67hO+tzMQPVJdXRfIrMtzqUazGM4C6SI25D5g4keaikrAoKVPZpXgwDaJh9zmjyQAtl70yI
 5GWbY6lAh4n5VdPnFKLqxMm+eZznEgWnDuNLbiilkjP+efAOBa9FOlUWHPTP7hRxP7V+239r
 ocPX+PUkUk3eLOlOEH/r9VMRW3m2FBgWPgaXeQMKrXcSuencUl9Y8LsLUQJJtU9xv8Px76Sl
 px/M2cBoGfCabT8AV3iQhhehHnHBP6TdFo3Yn4hO0iGwX8mbdr95asTbcVlYrQtsuBulKYmQ
 /4AcsSGI/JOVjWep2VDN8ag9tQ6eUT5nx+KMgqkfCM7IcxqSTvJzdm4LAHhwy8DU3isvswkr
 rz8jQ7WGMJRRwlrAMvMRuioyle94SoUlO5oARnXL9MVdEi1qNpmLCn4j/kWJcAQKEyfl2XAi
 FvMWU8V/LCfrZU0/d/FgbG/g72oS+YuTFBHG2T77KqtMXeI9GSUwbhGDLSCcwfbWT6m466lf
 +hUk6rxPfBbzlZHt41wT+Riwa4kvoK9orhH0kJ7EX+NY1nyUuFsJXyP3M9usKxRx+YF6FXsB
 R/VooFXaeeTJcfoMF8NPw57PO6N4vEjnGWA5/oCJkintjR8+6CKUBkJMhTQ2jZRKqB5bNEsz
 es74ZdE7guillw1P9zAgi0NrzaAKXkJUqMGsJAGAda321RxlQwYOcTRWn3s/ZWCS9RQKU10c
 DWas6r1gegOzET1dXduR2PG2vBQhMhVtR1HpLPYy49lRjYYaj4LMBxtHfAfSwNI0lNY3ug1N
 mUD24iZ40mR128AuSSBdznE98J96Nmx5UH7jVcE/IEcZ1f9TXTDdQXRJs7UlH30MAtgkvxz4
 7ySjmroOdovkAcdwQNqMXNYRzffoRCdO+EMdA1L3yhIInXiXQfYvw==
IronPort-HdrOrdr: A9a23:lVE9Aa+M0hbqcBzVr1Juk+DPI+orL9Y04lQ7vn2ZOiY0TiX4ra
 qTdZsguSMc5AxhPU3I3OrwXJVoIkmyyXcW2+Qs1N6ZNWGMhILrFvAB0WKI+Vzd8kPFh41gPO
 tbHZRDNA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="9648824"
X-MGA-submission: =?us-ascii?q?MDG3t9Yt7nwybD6clPK9BmCMtGK/l0KC52yatp?=
 =?us-ascii?q?DaNkwBY2PhnyCmKG4ApL/jp26wYvaFsZfaya7Mo2JTwj15/4pVRb/l3L?=
 =?us-ascii?q?ZzKKJPtEjdykDWd+6LPg5FqNfwQNwh+XCFjjPddGOnukLtXb9XV4apBF?=
 =?us-ascii?q?8mJ/v3JW2kr2n3O1/Oz3aZGg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 22:18:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648243110;
	bh=CscK3+e13abaUU5hZ4kqSOa5F/ASd76SSD5EvmWOJQ0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=PKd2AuXgr1MuJKKAdBokP3ApjT4dkag8SU8eIlCp972yWD7gusfqqVo78T1Zhn0QO
	 /JxFHyPc7xSOOVPhVjvGJ5rSstP8yNqNisQHTqrwjk4SEwWEX8FRrsXxpqdmj4M0TM
	 qruv2uS7++9sAz7uChmyTHstw4AVQJNGj659dB/Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.176.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1o7C4s0s6q-00ZI4J for
 <cocci@inria.fr>; Fri, 25 Mar 2022 22:18:30 +0100
Message-ID: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
Date: Fri, 25 Mar 2022 22:18:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gxLmG1kOrjzt8dtuPwL6eAtA2PsssY/0q6Iy/zjSiRy9Be8V/Pa
 Gwfjll6mclvLJ9wFW22Pf6IpnJNuRHF6x8vYzSwuDs1gLgihkN14VsVqXzuF/JfkGkCUD09
 6xF9EEkdmkTSCrXA7tluCWXl72I21sSqeWhHFT9WWFQd7XXAaKPmbHwtPFzYEhGtRlOAcX5
 GylMmthUp1Y7wWk8Nh5vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SB3zadR0rSs=:J2CK5vIczBx4eobE/bJ78h
 482WETNQBY7gboMu1Q9CPeXN+72Ps+BOO4tWKsH7NHryd1uD5qo3NczBdO1xWASbiHlkhWKe7
 Mw0+6gTaUdOQHmRF0dhWpt/NFbh4cxxbr/hc5GECTTWGDPmDqRWbRSe8xA11+IQMSG476JFai
 Z/VOnP0H50D9QyDru8rVu4bm3Cnav+46uoERDZD2nFUzWZuj754oBRK+l/DW8CSuV+jZr2FXi
 CCkPaSRMO5IX8ZwzN8EJ+6sGqd01OuOkMx3OHAOu1ZvJSIyJhoCi40uhTlEHGU042gu2QyIWE
 PcQU21olCoe5XlhLFUhFi9zQSsm2rQIbWSjDoRK76r5RUiEAl1oHsxT76vqaTUC2YYZQH5dzD
 qAI4igmoppbUaASvIiaj7E4vkC5VPFZS3WSskWiV8grIlEfeRBAJVOk6A3JMzMkv9GERK5TOX
 bdpbX9M3LUpuPCTIE3ufrvGC2JIV2iiujPw3Gjb3IHhZMqsLgR5LjqRcIQN1797ihlG53ESKT
 7YTYUp6AWKbGUe60+yK1vQiow63pPO3kRajs0WgI1zEqYw3p/BPSGJ1Xp/SJcnHlsTQfT00VM
 WfUfNNDU68Wh44VmERQJ7CAH2/zaxrDYldD2NKk+1g8ftBqGmuzOK11QMHcxebTHLThKRy5ps
 EM7ig/suylZjkiAS4c4MlQJJySoy7PkfBxdTSZXTe3iRoTDn2k+j+MPer0LGXOlgdUKfPKbQQ
 4fk6+ScWaB5w1HCu1tVF96nfFQdUTs9olz671OxV073iYtpuu72zM3AGKc4Vr+I/BV4dxHldS
 NGEqAMIxn0iA1tTemtNrE9bDu1lD9mEPoLknzABUakXKRmpMF/848u1+7Ujq6zPs6zl9u5zMf
 Hndp1haqOiDGmJuWUYFccSZp2HJXN0edWOvU+t9z7EVxgPVfo0l92gwMVdNO/vx4G8ehrg5Ko
 cSr1hZ57pOcaiG1/XFy/JtkMyh9nWkqiB5P+bLaMrKVJXh8a0b4h9lTgNEVgZa6R3jDxU7UzV
 wHKsIj6lV+4Y5rszVPDOBrXvMu3V4X1TgxEQaLOy4tabWuAXfaglEDnP50U9GHk+pkWCShD6m
 sZ8MbT68oNnwfI=
Subject: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 287
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/c17bb3cc-f839-625a-66a6-2b9de96c9264%40web.de>

Hello,

The metavariable type =E2=80=9Cconstant=E2=80=9D is supported by the seman=
tic patch language.
Thus some data processing can be performed for literals.

I would appreciate the support for metavariable types which will match onl=
y
string literals.
https://en.cppreference.com/w/c/language/string_literal

I guess that such a kind of metavariable would include also the enclosing
quotation characters.
But if captured data should be passed for further processing to another
scripting language, it would occasionally be more helpful to omit the doub=
le
quotes there.
Additional programming interfaces can also help to handle data parts bette=
r,
can't they?

Would you like to work with another metavariable variant for this purpose?

How will the chances evolve to extend the Coccinelle software accordingly?

Regards,
Markus

