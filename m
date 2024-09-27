Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983DECEBF8C
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8KlKfdcaNlNsTQlDDcnWB/Hs0cRkcSLb4t/+1YCMuZ8=;
  b=M4d/7gjfqoJ2QdsnAcd/5yE7oi8fMSE/Z/rk/CVmGlEnsoH9MptnZLxG
   1O+JwpYHbVmaMcokVjOuDlnOujg3AqfMnUrRBLecUDuAZCtJUVRm+Nfcl
   AP21z9zXHRQZV/xlOSfaO3HPCpn3qZnP0XxweQr/QTjMpZ1jh1tlCo+XU
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185482951"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 11:44:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BC45E0CCA; Fri, 27 Sep 2024 11:44:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C214E0141
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 11:44:28 +0200 (CEST)
IronPort-SDR: 66f67e7c_L3q7uI+OuWzIKX32kwNFtrscuf3kTWtSAZCmwvTmIynfeKq
 ljbr7QPgPn5qsEz35qfgQOlVdg+1p/SuIDeHIrA==
X-IPAS-Result: =?us-ascii?q?A0FyAACyffZm/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDB1shVDMEC0iEVogdhzCBdTCEO4c6h1SIdoFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBIUAAooHAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECgQoIC4UvRg2CYxGBFIEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREnDwsaAiYCAksLBgEUAQGCfYIwAQMOIwewToEygQGCDAEBBtpaH?=
 =?us-ascii?q?ywiV4FjCYEaLgGISgGFVkuEPCcPgVVEgTwLgng+hEODW4JpjwCDDYIahQaDU?=
 =?us-ascii?q?nwliF9wkSxSexwDWSETAVUTFwsJBYk4CoMcgW4mhBYIgSsTg1+BZwlgh2dig?=
 =?us-ascii?q?Q2BPoFZAUaCc0qDT4F4BThJglFrTjwCDQI3gigkaoJcgScEBYNSdh1AAgELb?=
 =?us-ascii?q?T01CQsbBj2uP4JBg346xTc0B4I3gWSBYwyfUgYTL4NyAZNLDgaSc4YgklYiq?=
 =?us-ascii?q?Hs1gTI9gVkzGiSDNlILDg+OIQwWhAu+AkE1OwIHAQoBAQMJAYFVg3ABAYZBg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23:BtnCha1KZMwHMh/p9PbD5fxwkn2cJEfYwER7XKvMYLTBsI5bpzEAy
 TMbX22Cb67bNGqkf4wiYduz9BhSu8WHzdJnSgVr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8glaYDkpOs/jf8EI146yr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWzjV2+o0Vls6AZ83x9pLXjpzx
 +A8JBlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMvIMwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKm0F9ALP9PJri4TV5ANayLy1NoaWQd2taoJsu1aVi
 W3q3nusV3n2M/Tak1Jp6EmEgubQlCf/cJATEbei/7hrhkeSzyodEnU+XlywqviRkV+7Q9sZK
 koO+yNoo7JayaCwZtz6QgH+v3OO+BIRMzZNL9AHBMi24vK8y26k6qIsF1atxfR/3CPqbVTGF
 2Nlnu8FwRRqt6CJD22Q/PGYoFte/MTTwXAqPUc5ockturEPY73fSjrQQ9wlHKPdYhjdB2Tr2
 z7TxMQhr+x7sCPIvplXOXjYjjjqqpWhosvZIOnIdjrN0z6Vr7JJq2BlBZY3IBqAwEukooG9g
 UU5
IronPort-HdrOrdr: A9a23:w9Av0Kp6qE/sm+z7mhlToAgaV5u9L9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Km90KnpexLhHO1OkPEs1NaZLX/bUQ6TQL2KgrGSpgEIdxeQygcZ79
 YHT0EcMqy4MbEZt7ef3ODQKb9J/DDEytHOuQ609RdQpHRRGsNdBnBCe2Wm+yNNKjVuNN4cLt
 6x98BHrz2vdTA8dcKgHEQIWODFupniiI/mSQRuPW9t1CC+yReTrJLqGRmR2RkTFxlVx605zG
 TDmwvloo2+rvCAzAPG3WO71eUdpDKh8KoPOCW/sLlbFtzesHfnWG2nYczCgNkBmpDi1L/tqq
 iNn/5vBbUx15qbRBDPnfKk4Xib7N9p0Q6r9bbQuwqfneXpAD09EMZPnoRfb1/Q7Fchpsh11O
 ZR03uerIc/N2K0oM3R3am6a/hRrDvHnVMy1eoIy3BPW4oXb7Fc6YQZ4UNOCZ8FWCb38pouHu
 ViBNzVoK8+SyLsU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsJg9V55H7e
 LZNbkArsA7cuYGKaZmQOsRS8q+DWLABRrKLWKJOFziULoKPnrcwqSHkIndJNvaCaDg4KFC5q
 gpCmkoyVLaU3iedvGz4A==
X-Talos-CUID: 9a23:3GOgwW6u66C4LYzouNsst3cMBZp/aHHh3ljtH3PnUltbVJmZYArF
X-Talos-MUID: =?us-ascii?q?9a23=3AMVL0pQ3ErEC3J6UyCrW+KAE3EDUj7I+2DBgLzdY?=
 =?us-ascii?q?9uu6rchVVKzqygxiWXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185482904"
X-MGA-submission: =?us-ascii?q?MDFNDltN2LG4Vm6JKQOrEEp/IyDgXDGuBVWTH9?=
 =?us-ascii?q?8usQXGt8jbdX45pWvrSXSHObEhbfwC/ITcM4g66MLjeVwJuqqPWrP4eP?=
 =?us-ascii?q?zOAXzpUQFe1LnzR4B1csqde3a1Lkg9YsrIPto9nLkT6hLG0uSXBzSsLj?=
 =?us-ascii?q?L68iHkz3+xpG5SXOLHUb+cAQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:44:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727430257; x=1728035057; i=markus.elfring@web.de;
	bh=8KlKfdcaNlNsTQlDDcnWB/Hs0cRkcSLb4t/+1YCMuZ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iskPUG5hfvmxpBNyzEdFkU17Bz9khq8SPh2BaBTas4cO70yYOrQcMISRbRgy5knl
	 yGtQrTTkGQuD2W/jF/MT1zpIjUyLsm6SiHTINaKBWVnf1NqquobXd/R4CYGvboTGI
	 pSbAX7IAc0+HDtpu+eY1dYq7mDFTPqs78NBkPSoUd77zhKvRuFO0OHpayCzzZZGKx
	 Dv8ck3MvnQGceY1vKNq5UUTxsrv8bCdJklAAyuqcJFn6p+A0ECLrnva2q+ccuda7G
	 g2Z0qa9jrOMlG6X6bQ5MESjuup56/H5DZIyntICSW6tA2AGb8g81wI74zKuQUmZ8E
	 oBfs7sRyIaiso1TH6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjIR-1sNoyk2F5L-00V4ah; Fri, 27
 Sep 2024 11:44:17 +0200
Message-ID: <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
Date: Fri, 27 Sep 2024 11:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
 <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZ4SjNJAJ/LNKnPsv1UtfHZHgi6kOxXk2qXZsVYBeCUaFLhbh84
 BCO/xcSEUadW8ANAeWHe08iknc/MkAA+0qJ3a3C+V2AYcs1e6wTvSfaGNGexQgRXdn7obq0
 jno9I8TVJYc/uc0YUnxZun5kBowhq/9uFQDHj9hihSC4q303lWTcZ1SkfEC9lc3MZFPfMuV
 ut/ErEQ8JRptt3L19h9Pg==
UI-OutboundReport: notjunk:1;M01:P0:j2RW3d1euww=;s+Ih0T0rYCp3O8AzrJCKl/fRt9K
 6mvmZjf3SK9waW978Ub6hNeFXbBzKrdq7ylOCf8Mvk13vA0AviMDDSR3amvUcvVMqBBjzKcKq
 3T0zwFi/n96rVlJQCBNdb/ku9HXcnLq4lEBE++uIJVcMSV3i9ngwC7ekNOqlVeyCQ6l4CcAJv
 XIQQKClQEZY9//T0smU+u9j7aLx/akFY5P0mDWoWQRR1JIJ12oZ0y3ub7AFyVHXUNWCvvmnMG
 fXaKwrlr09WEx/iF0zK051fAGdERwjQ6arR3blGKs1pp4+AKyLGs7rRYdM+ABLy8d4AnSccCw
 Xy1MQ0KL5sx5569Ec2zof50uPWnq4y6UTLCwWlaM8fMPOMLdGjUSxSinEShm6laTGNRbkeSsm
 N71tWd8mkSKTGEBKR0E2KTQ2vLO1KtZd7Lxh3pOCrjkA5kT+jf9IdEVAjNL2+8AbWu9AF+KhT
 ZpgfLjtBxgi9qAfeH74kjSAMspRdTXXMxcJ/lCl6gMoUJnMTOdrR9uBcFT6m1S6v6lww2IwnD
 92hJKCibCekt7zeg6GSIU/bDPAo+z/N1/St2vOBM+Ct53rlsaJLee4z/d7Zcx1CGOTWxm6m6q
 6ozYXVcOpCmFvmF064OK5+biPPQpkCUeoL8aoFvPG3WxvhASSf6ooh2MsIQXXgxjfRQMQpUau
 755qKi/tTWNr0dyjYR+lhGNJTSieIve/T/HtZJahJPffUvHeEZfCYWtmCgczFUXJ9pOUeqBGC
 gC4V9utD/lpVrNmHmAyBIfkKNOCNQbeOmvomdlBjgGzz52nXcTfhvMmgfOcSP+r7ThLXa1rO/
 IFpB45GwDjp3pfhV3ncCICXQ==
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1891
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/4ec353d5-9771-4db3-83ed-7571b35eadce%40web.de>

>> May I expect that such a search approach should also work without the e=
xtra
>> SmPL filter =E2=80=9Cif (...)=E2=80=9D?
>
> I don't understand why you want to get rid of the if.

There are more control flow variations possible which do not begin
with such a key word before compound statements (source code blocks with
curly brackets).
Will the support grow for this general use case?

Regards,
Markus
