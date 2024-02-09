Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D614C4828F
	for <cocci@archiver.kernel.org>; Fri,  9 Feb 2024 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZRT0xfCHj/QShRnNITP4iihYXb2sKIy09+wUZDUTswU=;
  b=LQtXnAXvx4AVkEvyDaw/Vg0uVI2iyjj54na1+knsmhpJvfjW0StUTGha
   37atHxYjUylu3yQH79JOv21w/dqK3ZWamihHg5cSwYdjGqcO9X1nbk5nQ
   x4kmEgvecAiVcKJxXGmydFc9eMjc4Ai5o0zDmKQc0FgdSlxdEohk7qD43
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="151096918"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Feb 2024 09:15:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04CC2E0CD5; Fri,  9 Feb 2024 09:15:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3839FE008A
	for <cocci@sympa.inria.fr>; Fri,  9 Feb 2024 09:15:23 +0100 (CET)
IronPort-SDR: 65c5df1a_KEgmv8JKMWMkKbhyxNIlVy+yTlLp4ymvWhXI1RbqXQC7j4H
 bkeBSguJRJLOYG6DUzOAYJ7rpG4WaF/JT/nUqpg==
X-IPAS-Result: =?us-ascii?q?A0FIAwA13sVlh07ASNlaHgEBCxIMQIFEC4I5fANTMgQLS?=
 =?us-ascii?q?AiES5E6LQOEO5d1gVaBQD4PAQMBDT0EAQIEAQEDAwGEfwKHVwIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CX?=
 =?us-ascii?q?AEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAkdCAQICASMdAQERJw8LGgIfBwICVgYBFAEBgnwBgioBAw4jBw0GtjiBM?=
 =?us-ascii?q?oEBggoBAQaBV0GtQh8sIlaBYQMGgRouiCYBhW4JhDInD4FVRIE8gwM+gmEBA?=
 =?us-ascii?q?4ElOYNbgmiCGIM8mAZUfx0DgQUEWg0bEB43ERAFDg0DCG4dAjE6AwUDBDIKE?=
 =?us-ascii?q?gwLHwVVA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwV?=
 =?us-ascii?q?UEMUANkHzIJPA8MGgIbGw0nIwIsQAMREAIWAx0WBDIRCQsmAyoGNgISDAYGB?=
 =?us-ascii?q?l0jBw8JBCUDCAQDKykDIXQRAwQKAxQHCwd4ggmBPgQTRAMQgTSFPoQOAxkrH?=
 =?us-ascii?q?UACAQttPTUJCxsGPQKdWwGBUHVgCFkJfMZfNAeCNIFggWEMihuVHQYTL5cuD?=
 =?us-ascii?q?gaSXphXII1PmwiBag0mgVwzGiSDNk8DGQ+OIBkfg3WBC448QjUCCTACBwsBA?=
 =?us-ascii?q?QMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
 HUmVbJRElA4RKpyNw==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:BnxjC6xu4EnTdXySFNbAKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:t9sRQWMN4ys+0u5DfXc92k84M/EcdyeNykrWJVOZAj1uV+jA
X-Talos-MUID: 9a23:zrxOIQnB5vEvM70716fNdnpTadVR+572OnwsiLwKsOubDBJbZC202WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="79178250"
X-MGA-submission: =?us-ascii?q?MDF3G8SovJ6TXMGreDksAr2X/1z7IXSuwCb3ct?=
 =?us-ascii?q?q9y1S3iDuY3c3iS8v6r9m1QvyBRAYnBB2gh/5d2iYRGQ4bcqSEcZ+KvB?=
 =?us-ascii?q?xrvJWBcCPow6wd363tt1roTTnwpUBhGxC3PSgNQ7mpoOE4dLABiF0PQE?=
 =?us-ascii?q?k30X1Gg8R911bhXBiKjJ2HHQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:15:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707466522; x=1708071322; i=markus.elfring@web.de;
	bh=2mlvXso+J8LJyERbnamDwIHYzEs6f+ld0F/fB1kib/w=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=KakUamCBKsiYIoa6EZ/uICJaZZNoitH5q4bOTJkfZhhPwrQkotMPGOnawUBxLmBc
	 qYsiWei4K+L3M1qX45mQfubVzm8eJfkF9azfurMGjeftfVZEq3Ksrg0UyTnzdgYj1
	 QnCDYSgMPvqPMJukbkJYOLoA8m+rVlqCkK2iNstTMMRlMmjzDYt15iRNIwOgwGM15
	 QtOcgoyBsMR2TpMGKaK+7kgp417/2QeYYsHQIspWeX3fJ5TadtdgDEyk5wH2CdwTn
	 LV41KbtPthesN9/Sq/a782KEY3junGd4cuhRWJq8hXCxXdM1uK4MPcHyqckn0stfm
	 TEFP9n401MXT41MuBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1qgnPz3a5O-00sZQm; Fri, 09
 Feb 2024 09:15:21 +0100
Message-ID: <70dc14fc-5e21-4eee-be17-c9fd30b99cef@web.de>
Date: Fri, 9 Feb 2024 09:15:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <41052adc-2065-4cf2-9160-2e986de1bf9b@web.de>
 <289a052b-86ff-4ecd-ae55-89fc0238373e@web.de>
 <alpine.DEB.2.22.394.2402072108500.3138@hadrien>
 <d983ec62-2e0e-4102-bddc-4c420a75601b@web.de>
 <51feebc2-751d-4e1b-bf72-28dc8ed975c9@web.de>
 <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <eb10beb1-c8b-47e5-ab28-5c1bba502d2a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/tkxIn2r+UuAgYd5tCoYFcHTe2uCiBOvAuMtWb8faGxhqdgWeTr
 ZrHX7OI/AgPuQKHDxhK7P6EAYVH56vKZlpG78LHiRW9tO/VZh5helR7g/9a+xegu5iB3PCI
 8YlTWrjHu60FTqmUzWPleUD4ICXVfzjQGK9AyyKjpUZM1v9NGCXFwTwatY9x3ugLL8LAdf/
 7seOXXO9fxz5cq+bjWI8A==
UI-OutboundReport: notjunk:1;M01:P0:GX+VPFwg67E=;uTUwIGd9I0yzIsLpuOXSS0SNjHs
 hAu+ph/VSiRc3JLD/u3rgviXgYMjyipKJQ9VFcoVZSI31MiP/VzvVc5t+CVbYqgJdQ4MGNCAW
 QjafmCU1/6hDFEuuoZo2bSC+NLGF83Yx+4g+CLFz+3OamMo1C1+yirXChmSS3taC9DeWA59sL
 fUpU8JbQ4vZxA0vW+tWxWcupgTc3eAgF8YNZg01s3bBDgo07DQw31Oa3zEhIbeCuFEAe7R0we
 kvTobV3muK4Yqux/0eZGAmI84BnKkFURqlPrm1EhSfln9dH3Im264nQwm/oB0ykWtS4mH/q2C
 ZNgSV2VdbzQ5sk0h1z4v5fkVOqOCc41/XAnlYuG2zxdWXk1A6+o/iL2UTDych5se+5+Mm0F/u
 1a2xOsueUN5xXfgAketEpeUOBl1pXYBBPWnMKVJIfnQlBiVZsBlwZ6H2jT1rPnOl7/3QFCVqo
 R8VDl3Dkx3Y0s+rujccmkeL7jv1PeptHROk4EkvhDsziHkxn4mj5ZyUGxem0piCdjOxYtt5Ly
 bGIlYe9KA8OmSsbPCJ7JDPRehyWxt3CjQnL3C8eq10crIzMiPLNj88pRKobY9fprpTKUCJRT3
 8L/ap3mNpg3kNbddb6gBUdhmislXFfY4p6o/yy8pdGEfHTDhadcOKs3WwijAThpWQ/lQcwIUG
 2dg6Xc8LVlJ1iIVQOAngFBrD6bCJJ94/RRSQ/anQ8ghYSC8n50lODs8Uif5RP8QFOLsAgoNhb
 D/z6QyGcyZbLoBV6NFIP55CWIxSE4imsGYk03mKtmSbO34Peh3u1AKJDsRGBDstqjSYSDLRjC
 R1Toq/hehHN43KKqrUzkMUkfewaLmH88WAV17+jwtxQgw=
Subject: Re: [cocci] Supporting transformations better according to reduced
 number of function call parameters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1526
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/70dc14fc-5e21-4eee-be17-c9fd30b99cef%40web.de>

>>> Will the understanding improve also together with a script variant
>>> (like the following) for the semantic patch language?
>> @selection disable decl_init@
>> expression action;
>> identifier var;
>> position call_pos, declaration_pos;
>> type t;
>> @@
>> (t * var@declaration_pos;
>>  ... when !=3D var
>>      when any
>>  action@call_pos(..., &var, ...)
>>  ... when exists
>>  var
>> |
>> *t * var@declaration_pos;
>>  ... when !=3D var
>>      when any
>> *action@call_pos(..., &var, ...)
>> )
>>
>>
>> Are there any opportunities left over to increase the avoidance of dupl=
icate
>> data processing also together with the application of SmPL disjunctions=
?
>
> I think you would want the disjunction to start with the call to action.

No, not for this use case.

The case distinction is essential here that a variable declaration
must be preserved for one function/macro call while it may eventually
be considered for deletion according to an other function/macro call varia=
nt.

The semantic patch language supports some metavariable types.
Special restrictions can be achieved by combining them with the means of c=
onjunctions.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4965f42eb94d2d67f7375=
c66b268997457cbcefb/docs/manual/cocci_syntax.tex#L1041

Can it be that a branch of a SmPL disjunction can not directly benefit fro=
m
metavariable matches in previous branches by reusing their contents so far=
?

Regards,
Markus
