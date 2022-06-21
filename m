Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACDFC43334
	for <cocci@archiver.kernel.org>; Tue, 21 Jun 2022 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CLD/m7Qqp2t2bBuHh6YS9lJMpz/6HdwtmIdSSa4rHy4=;
  b=JKsz2BSsDxmcYBI3T0+Bvhvmy5lwYWX2g71LdmWZCgOYmBOz8/89CRY+
   /TdG9sR/wMG99FUIibQ7SFFfuqfHgbqgTOB+xmOoA/DJXDQPt0IH/Tc9y
   cWPa+olE/eHiZbluunAt2pRNmvbOp9g+LSd3Nru3w61Bh2DYwhv+hHdqF
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
X-IronPort-AV: E=Sophos;i="5.92,209,1650924000"; 
   d="scan'208";a="42231696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jun 2022 19:16:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 348A0E00BA; Tue, 21 Jun 2022 19:16:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D307CE0094
	for <cocci@sympa.inria.fr>; Tue, 21 Jun 2022 19:16:04 +0200 (CEST)
IronPort-SDR: kQp7rZYnLjctHHhd2XLGcVLsLqajdGCw1/xsXbpCag84FkIsdhoWUn8oqTdZMVv56y7QwhM+1E
 PPMCGBy3hsABo6C9yO3f5PiOWtlvO9Z8g2hGG5C1Qj9PVmSXCWO5cPWF59+Q7Q4KXUMLrNxE6h
 bVC4VgpPel/PoAoaBFfs8ObHf+b1wUsyjrvnPgRJIm/9BZgtfUlJyhJc4WgCs0KVkb0HpIbaP5
 bZ9un2FyP51X4qpSqQKml+02RbuWbCxvYucS+mYiDRuBiSAs4ufRHIhiQOeKx3jfOhT5Sb6ZIP
 nZ4XlARSLdnJ1Y+w5vo1KtkC
X-IPAS-Result: =?us-ascii?q?A0BfAADv+7FihwMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IkgVcuBAtEhE6OZ4F3MYQhhwmHHIwhCwEDAQ0/AQIEAQGCD4JqC?=
 =?us-ascii?q?gKFSQIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBD?=
 =?us-ascii?q?A0JBQgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlcGAQwIAQGCeYJlAQMNIwesYYExgQGCCAEBBoRKHywiUoFcCYERLIpYg?=
 =?us-ascii?q?yN6JxCBVUSBPIJTMD6BD4M1g1aCZZlbJgQPAxotNBKBIXEBCAYDAwcKBTIGA?=
 =?us-ascii?q?gwYFAQCExJNBh0CEgUHCgYWDhQcEhIZDA8DEgMRAQcCCxIIFSwIAwIDCAMCA?=
 =?us-ascii?q?yMLAgMXCQcKAx0IChwSEBQCBBMeCwgDGR8sCQIEDgNDCAsKAxEEAxMYCxYIE?=
 =?us-ascii?q?AQGAwkvDSgLAwUPDQEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDA?=
 =?us-ascii?q?gIbBwICAwIGFwYCAhhWCiYNCAQIBBgEHSQQBQIHMQUELwIeBAUGEQkCFgIGB?=
 =?us-ascii?q?AUCBAQWAgISCAIIJxsHFhkdGQEFNicGCwkhFgYKHwsGBQYWAyNKJwUKPg8pN?=
 =?us-ascii?q?TY8LyEbCoENFiwJJCEGIgEbAppAc7IrklI0B4IUgT2BRAyeLgYTLZZVDgaRe?=
 =?us-ascii?q?pZuIKcWgXiBfjMaJIM3TgECAQINAQICAwECAQIJAQECjh0ZHoNuii0/NDsCB?=
 =?us-ascii?q?gEKAQEDCYVHAQGJOAEB?=
IronPort-PHdr: A9a23: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
 PLmpZdEWVZzGv5IUyxY
IronPort-Data: A9a23:JLc3zqjG+0Mla7/Bf3oMSgu4X161TBYKZh0ujC45NGQN5FlHY01je
 htvUGzXPaneZ2ukct0jO4vl/BgOupbUz4BhSABk+y01QX5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/ZeGYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Npls527Fy0XJKn3n74bVycfHjhCJ7Qa9+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bY7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYYHgG1o3ZsSdRrYT
 8w+SgZuNg3EWRNWGFgzEJQYx+qjo3aqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkyMNWAwD6B2mCtg+XVlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3L
 U0fpAAQt6wJ8xatSue6UgSEumfYsUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAODKUudpHVTGM
 XfWxrvU6SxTXK69FSPFruzPxd+mEXhJdzBeDcMRZVZdu7HeTJcPYgXnYvsL/ESdrdTvHSrq3
 jCHxMTVr+pN1JVUv0lX1XrOjz+q46dimhQp+gjSVG+/4WtEiGONYou19R7E4PwGIIvxori9U
 Josy5b2AAMmVMDleMmxrAMlQunBCxGtbmS0vLKXN8N9nwlBAlb6FWyq3BlwJV1yLuEPciLzb
 UnYtGt5vcEOYST2PP8sON7qVKzGKJQM8/y6CZg4ifIRMvBMmPOvoHkGibO4gjy8zhN2+U3BE
 c3BK5nxZZrlNUiX5GPrG7lEiOFDKtEWnC2KDZH90xm917eCLHeaIYrpw3PeBt3VGJis+V2Pm
 /4Gb5Xi40wGDIXWP3eLmaZOcwFiBSVqXfje9p0MHsbec1oOMD97V5f5n+h7E6Q7xPs9qws91
 irgMqOu4AGj3iKvxMTjQiwLVY4Dqr4m8ylgZXx8ZQr0s5XhCK72hJoim1IMVeFP3IReITRcF
 pHpou2MXaZCTCrp4TMYYcWvpYBubkr5mg+EeSaoOWBtc5llTg3P29nlYgq2qHhQVHXq75Nmr
 u3yzB7fTLoCWx9mUpTcZsWv+FXt73ITr+R/AhnTKd5JdUSwq4VncnSjjvI+L8wWBw/Ewz+Wi
 1SfDRsC+7vSroVz/NSQ3fKIqIKgEu1fGEtGHjCHvOjsanSApjKumNYSXvyJcDbRUHLP1J+jP
 egFnevhNPAnnUpRt9QuGbhczZU4u4nlqYhcw1k2B37MdVmqVuhtL3Taj8lCsqpBmu1QtQesA
 xvd/95HJfOWNcmjHFNIfFgpaeGK1Pc1nDjO7K1pcRugu3ItpOKKARdIIh2BqC1BN78rYokr9
 ucWvpJE4QKIjBd3YM2NiTpZ9jjXI3FcAb8rsIoWXN3ihgYxkwgQZJvBFmnp7ZvJZ9gVahsmJ
 TqdhazjgbVAxxOeIiRpSiWXhbJQ1cYUpRRH7F4ePFDXyNDLsf8A2kED+zoASAkInA5M1Ph+O
 zQwOkB4TUlUE+yEWCSes6GQ9wB96Nmx/0vs1x0WmWefQ0TAuqkh6oEiEb7lwazb2zs0kvtnE
 HWw12vvFzrnFC009jVnQlZr8pQPUvQonjAvW6mb8wCtAJQwJzbo6kNriazktDO/af4MaIb7S
 SWGMQq+hWAX9cLdnkHjN7Sn6A==
IronPort-HdrOrdr: A9a23:G3MVPKqlDopqiliXu8ws20saV5oPeYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,209,1650924000"; 
   d="scan'208";a="17420334"
X-MGA-submission: =?us-ascii?q?MDGYN1zPp7PXF46uJMrGZu6Zc8yKt8rLJOv5F7?=
 =?us-ascii?q?UxFKIGdwtU6rfBlM+raWOCKkRUOyHKj3v2RRxkTpVVlF3lSL4Mm3Yg1d?=
 =?us-ascii?q?pH7x1l3tGgilIqvZ9eqYA5gaOyDFDjVPpUHvusP17QtcoT2PtfT811FO?=
 =?us-ascii?q?FUpJq5X2CJBM2RWPQEqoHfgQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:16:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1655831761;
	bh=CLD/m7Qqp2t2bBuHh6YS9lJMpz/6HdwtmIdSSa4rHy4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UlodDUVjMtscNIQ/L8WfpBMLUej5QKHfB8xd4lsIQR9q7/n54i2SMheLEonzZM95r
	 U35t1bHGF4m/mQ40fvjoVtGRonLNzvTgQqXPs+p8H/Rr7RNg/3bSRzlBiXapbLPjSv
	 J2SRPUBTNnbTEWpkWLe4ElbtOpdZ5xb9E3l1BYzY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.132.147.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1oOnN82HwF-00LvvM; Tue, 21
 Jun 2022 19:16:01 +0200
Message-ID: <e887b364-7e69-267c-3a25-356bb2075699@web.de>
Date: Tue, 21 Jun 2022 19:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
 <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:24vfIWe1WMuwrqvw9KgGYMEFpyKpWV47wr35/zwjNlkjnqcQrc5
 UTv/ZUx3GDCTM8M9Kq8vzevuJlaNgvt9TRCNqKd84vG7BCSIJKo28v9imZF60fl5ezgbpH8
 fMrmrg6srPeaZ3rqZvev91c8qXWH8UOUklijUoFmZ08Kp2Q9qrEckBPQOws68bMvA6jclLJ
 mJwDmiGRxtsOwryF+FrPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0EFHqubax7c=:oGiACr5Gldcqq3L5GYq8qU
 JpziZPaUlMUHxwaEgpZr/rceTB0f3WKH5+lBLKW/kS1rhnMVkEuXXaKGBSdhgf3GTcyfPESKb
 1u9s5Ad1uQAwAGOZU8cEzLhs08YDeV9XURmPtqxdYwDnikii9A7n+JlL5ieQZhQDGMz90wVak
 3/1TmxE/cuQB/9FNgQoKJlkN/d5Nj3DzZHXz0fQNGt5UX8sibqhRIAwIK5kmrkpchyGjZYDPu
 DmNvckpFx7B/aUTLH+EOUD++Vkz/RuKGEIhFMrsFPSqwUqyvE729SgniCvcIOem6nwpL7LghF
 xZ4Q3w8aaMRQ6tpkC8ZFwrCqeIV0DTm4wXtw2D2BeU8bH2uashzecnTTPClHc1Rdq3FoIz1KJ
 EQvxeYF9ycQGeCRdH8CmVH8kk4C4MGW+Y2liLNqUxaE6mne/Vcpm3q2FzEd3ozqDWQKLSke6k
 vIqgse43pPPwgqGHS4VW3kGDCSfBAvj/jM05EAxhFg44odl7LndKYays85EK9PPRY8XbkdJrY
 Lctqs/bDi/FuTBuiJFC5AtISWXX/G1fqbrZccw2jFRZmZ6dvUlN4VDMecnKEloYsEwzCRzJk1
 BP9NQeXJFDqqIRkG4DkA99ThyZilFEcqz75aTSnL5zFpl8SGBHbdxUlL2LeP7cljA9Bm6Y3Gd
 4DotnjIbzno6s62OjvL4I/IUStzHiOsFROyUGHDqxfZkP4CSqHTAoU+q/fYQgbjpSrP15x7RH
 JamZe/5y1VMVrc5wrcnEDjB1vw+6IBvxroSpd725f2YfheEyr5LCKlTjdHKIhC7sl52ZNypbX
 EEQtd4gvCla2dXTXu4YP/4n7qA7KIAmk+1bY3tCn6DDGP5fG6E4y7eH2CpRURd63t014l5Vu4
 uhitLPKf3X7pwtA7Rf55BJhUPzQl0j6zOM40rHYsxfmZYr5vKLTjtwl4JJ88O28GpuP/JHPLu
 kSrZI2TXT3WFj5KgoclCEyd7l5Cl1HKA8BHW92mvrho6UbHF9tFaywerJZN+jReVD+cSOXkfd
 aunCGXFTxwvAIt7Y09qf551sapY5YdGtPx/LkGWnhrKL3qf80tFHq7myscRuP4/nqyOIl+RUd
 L3cYSk6iK2j/0ZrC4vVXs/oVnj+aDYnRGhd2glMjgbX9o53chfXscGxyQ==
Subject: Re: [cocci] coccinelle: Extend address test from ifaddr to every
 test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 448
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/e887b364-7e69-267c-3a25-356bb2075699%40web.de>

>> Thus I suggest to reconsider the usage of the word =E2=80=9Cevery=E2=80=
=9D for the patch message
>> once more.
> I'm not against changing the patch's subject.


I propose to reconsider also the patch description accordingly.



> Would you find it better if it was "coccinelle: Extend address test from=
 ifaddr
> to test expressions"?


Another wording variant?

* address test =E2=87=92 address check

* ifaddr =E2=87=92 script =E2=80=9Cifaddr=E2=80=9D



>> Will further adjustments become helpful for desired source code analyse=
s
>> and corresponding transformations?
> Do you mean adjustments in this semantic patch or in the coccinelle soft=
ware?


Both.

Are we looking for further collateral evolution?

Regards,
Markus

