Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D80EC54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h2ULmNe1EKw/Gy5qgX/w6Gbto7E7Px8S+dW+NtjqQYU=;
  b=YX4hieIzo06g+7x8Q62BrWAVSpNf24GpwnmICrj3P9b6R+zyiIxP1k2s
   k+6zeI0CnowvwqqJl7cXMvHj8XqUFJbPuZMLjct6k0m932XCjw1A5U+V+
   TBhTn6oX9dgHtGV9P1OR9U842TNb+cQl9x68jHuWmjTgJo4VFitqVWSWK
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90060954"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 12:25:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 465E2E7441; Mon, 30 Jan 2023 12:25:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D064AE743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 12:25:46 +0100 (CET)
IronPort-SDR: 63d7a93a_P3zAVz5x9jd3x3rJdtRM7Hvjfzb5XHGhS776rdpfG18cgCB
 1V0Cp+NPJXCBoew4Qfewnfcw/M84ZyfmhTPsUIA==
X-IPAS-Result: =?us-ascii?q?A0E2EgCoqNdjhwwR49RaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8CgiuBCFYuBAtFhE+OeoF3MYQrjlmIY4FWgUA+DwEDAQ0UAQEnBAECBAEBA?=
 =?us-ascii?q?wSFAAKFJQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4FCwUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICDToYOz0BAgIBIx0BAREmAQ8LGgImAgJXBgEMCAEBgnoBgm0BAw4jB?=
 =?us-ascii?q?wypSYEygQGCCAEBBpwJHywiU4FeAwaBFCwBjHWDNnonEIFVRIEVJ4MDPoJLF?=
 =?us-ascii?q?wQYgUaDWIJnkGOLCgqBOXeBJQ6BRoEPAgkCEXRAJQQOAxkrHUACAQs7Mgo/N?=
 =?us-ascii?q?QkCC0oQGxobB4EGKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZpCQIDIl8FAwMEK?=
 =?us-ascii?q?C0JIB8HFREkPAdWNwEFAg8fNwYDCQMCH09wAi4REwUDCxUqRwQINgUGGzYSA?=
 =?us-ascii?q?ggPEg8GJkMOQjc0EwZcASkLDhEDUIFOBC9egQQGKSadHYMtLIIEogehMDQHg?=
 =?us-ascii?q?iaBUoFSDIl+lHkGEy6Wfw4GiyOGeZdPII0wmkOBYjqBXDMaJIM2TwMZD445h?=
 =?us-ascii?q?AyEYY07QDQCAQE3AgcBCgEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
 JdcEtezsXQqG/lcBkk3RLTqz79oUzlinbPJ1aY1
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:qrv7P6gKCuPbWTMFCZCHXSqMnXBQXg4ji2hC6mlwRA09TyVXrb
 HKoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46348071"
X-MGA-submission: =?us-ascii?q?MDHc3Yz2h26NEblJN+I1MjTUwwfc1iHAqdNjQc?=
 =?us-ascii?q?NxbLa8IiPbLUcc+qLzY82qoj/R1t8wFyPNxESSlc650cAeBu/w5og4Re?=
 =?us-ascii?q?ArzSBdiR45K0g3HmmS0QSsl92kPMNzYulzIISFCfj/IhBPnBffKU2apU?=
 =?us-ascii?q?yFEgSmrIz6Xn9l7GqVVIT3Sg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 12:25:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1675077943; bh=MHTmeYkuSuwY9xjBRfxbxJykS7B9ikiOKu+kzokxnRI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ji3dyDpVcv63nLlezySQu65U8495GF243yrT8WGhnjFPoDSPGWlb17eoH3ZWt8wOW
	 dEC+esLCxtzgROy8xDNuH5Slf2Ve223EmNGLs6+DqngCn0FqldZNVP33YoBMmvE4CU
	 n5EZ8v9qXPgBDbrBQX5vBmJmXyqVGQ1ZFyb6rEIr0el7UgrrzW2H8IPZZH5i1TGtnd
	 d0ZXfRsh47pjHopI3OAyr+qZxxNCtK1uwjoRraG090LYwzjXhc67Zomi2jaYTQ+0iY
	 weTrzRsgxDSfhs3I8vZE59UdI8wuhAzqxKKCITOJ8M1gyBsNaOUq1skJbcL+TXbF5j
	 RZcdUV7Qsl0BA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1orVFH1Ogi-00mYUf; Mon, 30
 Jan 2023 12:25:43 +0100
Message-ID: <c5a37a0f-5b45-9aec-db71-4e41b0b07509@web.de>
Date: Mon, 30 Jan 2023 12:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Luca Coelho <luca@coelho.fi>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
 <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
 <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
 <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
 <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
 <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VWg9rkIVMZvJc8jU/O9fa8mE14I8lgYNotpl5FrH/DlLcLOpixX
 rOYhIVYfEyNmWPfLhL0qtSp9KRLZrj7cktlpt16A9dnaTv0R2RBzSrpTSuibcFwO5pcyDxW
 32FyCvgEADLZzfIOnslNdYEdr7aA1W2vyyjiZKLx/hj9QzP9dJMma+seZmdxXNy1rPfypTK
 hQQf6fSvF9+952yUXgonw==
UI-OutboundReport: notjunk:1;M01:P0:9SNk1RA2asQ=;MSxM7SacGqBqGl0wW492zb8OGgF
 U0hO/8SP5hdlxackZgvu91Wmdn3/uMv9aPJBkbTcYncr+mhiskrXVEaES1FAKeIrcbTaaFVFs
 x31ES7+AUiSyQjzmdhWy5KlY3gF4V8Q70d2BJ8ctlEpe6px2wRkogpRu8uzYfvvwI0GCPK2t9
 4Rh/uTlpsgiqXJ+vfRQLQZW2TIO09UJiMgl9aS+bDCIg6hWFMiEHM4fDbdBu3fH7zXxVE4Wz8
 oDpgJxk9YB4d1v5bZn/TC/rqwevuj0QXh6EOotlp7HDt7ZP3H9AtXmxEwCLYuarmGW72/pFl7
 EEY1oQykze+sgHL3S7KiXhpIqr6jlsoS3eIZBHEyZ0/7+x27ZESYEzg5ATemc1V/CTqe4LUfo
 12WTI8pVqj4a8cTjgqMwpl9xkpAwi9j4GSya9d4XCDWemXsHp5swPU4SwAEZ+iaGTFK1034Yp
 rTaWiZhwCixIwZ/iVS3rrRCKYEgg32pIqaqisqh9J5r2pRyLavnPyCdr6DfQIxSihIdCxQx5G
 aM9rn3a6gmzESY1m6vkkzX3fkWYlvu21MMvnFW4UDRIApruKQFyM4fUXPTuAklOTzFfXNGpwp
 lTgFrs9uwtfz/SbF1NhwtTL+LlKui4f2+5vcJFO2HIUdhR9+7lWLSgVsfpjMH2dSv7HO+1PNu
 yV/GB0pj5vENyPZIZBdPCZkDeHS3J0HxoXBIhZr8urTeqnf1hZjzl9ckfF4rfy0ceT7YxmohS
 z6lrk9s+BdoWjILhxlIo4Ctw5UVEt5gFHZBkBtlA8QChu1wkcckME8vPrgujZKx/0GXJg299z
 zyLomub82+wXQqNv69zsFhcIcIg+ItTvhWcCTlMMsvoivgw0G+q+mlXUTNixNu2fvwaiZNex6
 sGfCL/ieUDGdQizfFA9dSzprPxBsHt85N9PLAPsItBCZ5E0MI/0qxpJ2glLnjLTmZw78pt0bQ
 OB9XjA==
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 855
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/c5a37a0f-5b45-9aec-db71-4e41b0b07509%40web.de>


>> It doesn't find the file with the definition.  You may need to give mor=
e
>> paths.
>>
>> I have the impression that the result is improved with
>>
>> -I drivers/gpu/drm/i915
>>
>> Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you add th=
e
>> argument --relax-include-path then just -I drivers/gpu/drm/i915 may be
>> sufficient.  With that option, it will just hunt around in and under th=
e
>> various include paths for a unique file that has the required name.
> Alright! That _does_ improve things! Now I can see lots of DPLL matches
> in that file!


Would you like to compare this test result with data which can be provided=
 by
the script =E2=80=9Chttps://git.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux.git/tree/scripts/coccicheck?h=3Dv6.2-rc6#n5=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.2-rc6#n151

Regards,
Markus

