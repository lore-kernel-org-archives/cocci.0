Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9991BC433EF
	for <cocci@archiver.kernel.org>; Fri,  8 Apr 2022 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Gf63zT5CXdBzGR99rC5rxJ6Lb/le8KGPd4z1tkaPGU0=;
  b=WwLq/8eW0kHuL0zCQe8hfixALFf2eHmOdNJFWWcRvsc9pEXLiBuH3U02
   wdzJSv1/Wg47mpQZRE/P7sSEw4I7cSHOOg79+pfYecOE4WAddtCVCl13G
   mlHZTpw14hClaaN/l5YiXrJXJWCxpUP0Gf2nzk4ygPF+5hyHoGbWe8/ox
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,245,1643670000"; 
   d="scan'208";a="30850925"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Apr 2022 18:30:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6F7A7E0115; Fri,  8 Apr 2022 18:30:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 738B7E00B8
	for <cocci@sympa.inria.fr>; Fri,  8 Apr 2022 18:30:26 +0200 (CEST)
IronPort-SDR: sTMY2oR+0PbTrZ7b5hX+ULBHrYzrQPAKr6m6oVJW8TTwRBAY8DCEza/GpFWkm/h+kJJOrr1MFG
 w2moaTbrZ4Pomqrcj1JoHAZ6Cj2AwFNOFc00o1L65d2QtrXlnAoEWrKV2aiu31NJYPjDKh1ZGd
 1ThNfEBESgGNNpurqPIy3fg3/PS7H2JyID1jgoexMo96tqefvhsoKXBSHHsMG4z3OTwq7O19Tl
 /IScVFF/wiJjGoS+ydzXfw58R+pKS5ACBb6yNA+lUSxcbtOpSRzgb1BLJh+rOPeVU0Gk/aWk2q
 EDu1aEgn7RhG75lClRNgSvOl
X-IPAS-Result: =?us-ascii?q?A0DOAQAtYlBihwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiaBVSsEC0SEVZEciyeHGowlCwEDAQ1AAQIEAQGCEoJrAQkChG8CHQcBB?=
 =?us-ascii?q?DUFDQECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHD?=
 =?us-ascii?q?hAFNgZeBmQEgUsEgXQLNA2CNSKDbAECAgEjHQEBESYBBAsLGgImAgJXBg0IA?=
 =?us-ascii?q?QGDAIJlAQMNKK9XgTGBAYIIAQEGhEgfLCJSgVwJgRAsAY5OJxCBVUSBPAyCR?=
 =?us-ascii?q?zA+h1+CZZxrggiSKY9GnlA0B4ISgTqBQgyeHAYULoNiAZJkDgaRdpZeoV+FM?=
 =?us-ascii?q?oF5gX0zGiSDOE4BAgECDQECAgMBAgECCQEBAo4dGYQMii0/NDgCBgsBAQMJh?=
 =?us-ascii?q?UcBAYkaAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:u4ReM6B6LZXwvhVW/yLlw5YqxClBgxIJ4kV8jS/XYbTApGgr1z0Oz
 2QXCziHM/iIY2WnLdAkbdi09UhU6MXTndQyOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YThU1vX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYowrQtdRyz
 9hLjr6LWwMufa7XwdxMSSANRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWD4Ir
 KZwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOGsiTHv2bv4UwMDEYgupzMs6OR
 Ocje2BmSkrwQyQVOXwbIcdr9AuvriCiL2MB8Qz9SbAMy2PUxwdw+KP8NcLcPN2MX8Rc2EiCz
 l8q5Ez8BQwGcsOSw3yJ/xpAm9MjgwvEAagWF7q18MVIu0+XwS8QE0QuBEGC9KzRZlGFZ/pTL
 Ekd+ywLpKc09VC2QtSVY/FeiCHf1vL7c4UKe9DW+D1h2YKJu1rCXDRsoippN4x/5JVeqSkCj
 AfR9+4FEwCDp5W5ZBpxHJ+xqjWuMCIcMHVqicQsEFVZuoGLTG0btBLCT9BnGai5y+X7EDXiq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCZE2bZBS2OAApJCz+Vgqb7POREDnCFt559wH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3wI+Rcl9p2zypST9FWy13N2YDBg4WirjUWC4C
 HI/RSsKuve/wVP3Mf4pONjZ5zoCl/OxSYSNug/ogipmO8UtKlbeokmClGbJkTmlkU4wnLs5N
 IvTeMnEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz6j+b2TCPLGN8tbQrWBshkvfjsiFiEo
 753aZHWoz0BC7eWSneMruYuwaUidiVT6Wbe8JAMKYZu42NORAkcNhMm6e95INw6wv4Nz48lP
 BiVAydl9bY2vlWfQS3iV5ypQOqHsU9XoS1pMCoyE0yv3nR/M4+j4L1BJYQ6d/8r+bU7n/JzS
 vAEfeSGA+hOE2iWpW5CMMOl9IEyJg62gQ+uPja+ZGZtdZBXRzvPpo3ucDzp+XRcFSGwr8Y//
 +at21qDE5oOTghvFujMb/erww/jtHQRgrwgQEbCZNVeIR2+/I9vIi33r/k2P8BVdUSdnGTHj
 V7ODE5B9+fXooIz/N3Yvoy+rt+kQ7lkA05XP2jH9rLoZyPUyWqUx9MSWui/ez2ABnj//7+vZ
 LkOwvzxbK8HkVJNv9YuGrpn1/tntd7ouqMc0QluWnnGNgz5BrRlK3iA/M9OqqwUmu4H41TrA
 BrX94kII6iNNePkDEUVelgvYNOD4vdIyDPc2vI4fRfh7yht8bvbCkhfY0uWhCpGIOcnOY8p2
 7546ssR9hD5lRcgdNqL13gG+2OJJ30GcqMmqpBDXN610FV2kAkabMyOEDLy7bGOd85IbBsgL
 AiUs6ye1b5S8UzPLigoHn/X0OsB3pkDtXimFrPZy4hlRzYEuhM24PGV2TEwUxgT0RhNle5+U
 oSu24uZOo3WlwqERuAaN4xvJ+2FLAKU8Ar9xjPlUUXHGlKwWDWlwHIVYI6wEYNwz46YVidW9
 veUxQ4JlNoskN7ZhkMPZKKulxAvoRGdOOEPdABL0vlpx6UHXAc=
IronPort-HdrOrdr: A9a23:TFMG6KqTk6Bs+5kT0+HXy+QaV5oPeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,245,1643670000"; 
   d="scan'208";a="30850922"
X-MGA-submission: =?us-ascii?q?MDG5U7wuo9xekQMY+KTf4HVzt5tKefhm+fKeOI?=
 =?us-ascii?q?IcgNXUg/ZWEGCA6xVtcA/qBR0jRYPHIBlQFwFmX6WxEJ5TyCnJEd6rMy?=
 =?us-ascii?q?dwbuR5FPON89lHOj87tJRtmEC+04xCvizvhQ/jFMNtw4qmkR1eDpiAtA?=
 =?us-ascii?q?nEzlDD1t8wqc18AkH09LdyGw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:30:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1649435424;
	bh=qxIJI/3kul9u6JQaJPXaFKFhLi9MauprbcWPg01goYA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=gltMmC3VvSOwYs/i6YPdZUKhr5G/7L0N+w+369k0pY9gH+F0Rd6iMeAUY+gNEwZzf
	 3lpyb29B9VmxGn/VM3zivZaLc6ToA2mxSbHW9ceDNhS19LgSxS8wAuQF83NsBafK+G
	 3sOVBZ2eXEU+bNzaBtmFenBMJvjge8SI1KiLxaJ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.76.216]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQC7-1nkpaP0Kzd-00H1d0; Fri, 08
 Apr 2022 18:30:24 +0200
Message-ID: <19d5c85f-277a-7225-c175-db415aa32ee9@web.de>
Date: Fri, 8 Apr 2022 18:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-GB
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <b59aa9b9-8caf-2256-8f1e-6404e56a6410@linbit.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b59aa9b9-8caf-2256-8f1e-6404e56a6410@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lSAvlQigbOqBI6PgYqOjyE8cBw0WHt9b0J9vGSm6IGbwd2UmWtY
 D/LVupWQUDh3JqQPabZRA1WEojqjU+D5RvYWSuQTo1o2CnopOJYiBLZlNt1LxUU18LLbt5Z
 6XpmBmHgeDBGpQb6Izt/+FV7GUmbsbqPGika2nlON+BfPX+J41/23+gCS4jz6KTNfayrtmQ
 OxDKmIa1h82JR757LzL4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QgZcbnKW7mQ=:m8XZife0TpgD4DkaEDLtm9
 HaPow7T+x4vo9mNrftCBn8IY9fZl6YZ33VcQaGgAySMwv8+c8pN3BOSmuMnGCmCUPkyaCi0uR
 nqh9LB2nK+9zLHQvwcSRZJpS4lwUQK7HPqech/z1uFUx/m+FlT36cdwZirULwdvyDOrA7ElzH
 5X204LNXfJYZs/5faCVVbPSnXiNLZe3xCPSSJzxObhhWlE46Smn/klcNZo/QC3UlpmDZJcJDM
 k7K+jK11pfQLPBIcM4Pp4EIv0gj5LRfQmo399Vz43aAvP5n3rOHVZp48O41+e28Ykkd4au9bJ
 F/VF+4hw2OAjmwXbsD7gkb/nA4H2cJpqaPQYitjmn9UMQxp24UGMfy9JmW4olcVle1NLKG6LC
 tJFzASUaFWhSoz9zEwq8tWd1SweUoIMwVcUuIjxTg9y1zh2a/nxuNE8imJ7SlWYeodYUPYiqJ
 Rso4ZYEpXrvsOcGPrsnAg25GooYLmQECdcZ5slr/KtaPZnr/jk+oIUg2jjeFicfFCb/gZICIX
 jIXz3hHufOudx8k57rO5HHNWB2C7joBLcdm1DCVVHImooSsAa2QIO6Z91QpS6YeG8GdueLh3Q
 1aU1RSwamlK6NvGAwfTjySNWrhVEDgUYB4Xa8f3vqFrISuIY5g349f+NLMwt/bCx01tzHOWLq
 zE+rrF15Vl0mttFbnQ7Btl7/8bo04gDyO+fl1XbLpkj5ecYYsQoYNz+Er+GHOt149hcyVqdu1
 DJFy3oAfe8J6G562jPzQmDx5GBURhX1I5SkMBt0gzxtFIi2Z5gAjOgVgKV2NJy9TU9pPUsyxe
 UCYSpsPPKN4BSOde7nw3vqINqeT5JIuaXlDw48wRQT7WM9Q8QiPeve2r6TQBqCcWwXp58QZGv
 KrJt9ey1hF4fUZge8yvBxU+X6uMIQY95AlFpaXJ7wHnPATB18wT6PVd8/pFihDALiITVtn7YN
 MbSBovyMwoBZb2L5Stfvk9pVYyn6+eJUKHn/tAxPuhp4/FMiPvAAGO6ng/ge8+7WH02KxNMyu
 +QsXpi7KGbqi/wQVuk6JUkMLOdkno6jXMOSKguk/yGnKTAR4arccWO3QhZiCqXYpqgDN0WbQC
 9/NteCdO4HAKt0=
Subject: Re: [cocci] Matching a label after a return
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 361
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/19d5c85f-277a-7225-c175-db415aa32ee9%40web.de>

> and the following coccinelle patch:
>
>
> @@
> identifier x;
> identifier label;
> @@
> if (x)
>     goto label;
> ...
> - label:
> -   do_something();


I find such a source code transformation approach questionable.

Would you like to keep the goto statement valid?


> Is this a bug or am I holding it wrong?


I suggest to achieve further software evolution according to affected implementation details.

Regards,
Markus

