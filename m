Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E895DC433F5
	for <cocci@archiver.kernel.org>; Sat,  2 Apr 2022 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2yqsF6XNMZecnidZl0aEp96ddQFjtrKT7PghFMfSRAs=;
  b=WZjcj5fCRTXXd8yxNG9x1l+5+fM95HY9epz0gnaui3ptR1LiW4vH4sbz
   LqZkyD8r8K76XfjVMFgIV2LzPeSHnsjEKGaISTm19kZN6Q0meeRJmNx35
   GDlji55DGK9DfE85P2NpFCn0vxI8vYs9Oi8t2LSanhe3xYtUxoLyNMuvk
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="29689047"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2022 18:01:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5810CE00A8; Sat,  2 Apr 2022 18:01:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2BF23E00A8
	for <cocci@sympa.inria.fr>; Sat,  2 Apr 2022 18:01:21 +0200 (CEST)
IronPort-SDR: Ap2y+pRF1sN1iej5ZAiprtcKx/1fkR9+qLRTv7aPsGJJg+pgcUAK3fj7ndRwL6pR/dcc4Wn9IP
 3LwBJE9NEiDdPkcaKPiDz7uQEzbQAA1X7Jj329cPs//sQ7carTkWMsikXr+rx8pAs2m5B/8M1H
 ifkgnFEKkVwBb9x43oGj/l+eTyTciKGJvhst14Ot0Cxcq5xh708HHkH3wsNo7JGtNNZTRgjwaT
 9TpBCpZS/WixXbIoGXEIC0jYTP2EXK3QJIKJAHxKI+Lo2IWaJ9Ua1jqnuGtQJY5eb5SAUURkzL
 tQUiEkdiwCL/ca8p203b+vsr
X-IPAS-Result: =?us-ascii?q?A0A0AgDbckhif7DQVdFaHQEBAQEJARIBBQUBQIFagiiBV?=
 =?us-ascii?q?SsEhSORG55uAQMBCwEBQwQBAYljAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQ0LCQcICgcODgVgAUVkgU+BdwgDAT2CNSkBg2QBB?=
 =?us-ascii?q?RIRFUEQCxgCAiYCAjQBBQEcBg0IAQEegmKDFwSiP4EEPYsygTGBAYl8CQEIf?=
 =?us-ascii?q?iyOTiccgg2BPAyCdz6HX4JlBJtwgRUiohVcniaDU4QWm1IGDwUug2IBkmIUg?=
 =?us-ascii?q?SWQUZZepmMCCgcGECOBVYF+MxoIGxWDJU0BAgEBAQ0BAgIBAgECAQIJAQECn?=
 =?us-ascii?q?HA+bAIGCwEBAwmQBgEB?=
IronPort-PHdr: A9a23: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
 BwHxb6+JoMWZNWTM6NKZVxznYCMEE3VD4klnw==
IronPort-Data: A9a23:UX7ZVaiotX60wk3J+/mB3+QcX161txYKZh0ujC45NGQN5FlHY01je
 htvWDqAPauDNDHwLt9zaom29UJT7cOBzNcwSgRl+Hs1Qn9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq/5WFYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplnLnrdAsIMbD1uNsUCyhYHhM9YfJDweqSSZS/mZT7I0zudnLtx7BqDhhzM9RHpKB4BmZB8
 fFeIzcIBvyBr7jukfTrF6823pRldZa1VG8ckikIITXxHPsoW53GRLuM6dJe3SwYicVHHPKYb
 M0cAdZqRE2YOEISYgZOYH44tMauoHTSKABgk0C2jIUovHru5TZQiLe4ZbI5ffTTHZkP9qqCn
 UrC9nvwBhUyJt2awyCMtHOqnO7G2y3hMKoZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtteL
 wkQ+HNro/FtqgqkSd7yWxD+q3mB1vIBZzZOO8QfszyB66XJ2iamDzA1TjNzK4B5sfZjEFTGy
 WS1t9/uADVutpicRnSc6qqYoFuO1c49fT9qicgsHVtt3jXznG0gpkmQEYs7QcZZmvWwSG6gm
 WnbxMQrr+xL1ZZj6kmtwbzQb9uRSnXhSwc04kDTXDvg4FomOsiqYIun7VWd5vFFRGp4crVjl
 Cha8yR9xLpWZX1oqMBraLtXdF1Oz6jeWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPuM8DYCb3NvIuM9LZ5yEWIU7IRYSNuhf8PoomX3SNXFLvENxGORbAjjm1ziDAb4lva
 c3BIa5A8kr2+Yw+lGbsLwvs+bAswS86yAvuqWPTnnyaPU6lTCfNE98taQPQBshgtf/siFiLr
 r53apTSoz0CAbWWSnSGquY7cAFaRVBlX8yeg5IMLYarfFE2cFzN/teLntvNjaQ+z/oL/goJl
 1nhMnJlJK3X3iaYeV3TOik8MNsCn/9X9BoGAMDlBn7ws1BLXGplxP53m0IfceZ1+ep94+RzS
 vVZKcyMDu4eGDvC8jUZK5L6qdU6JhisgAuPOQujYSQ+L8YwHVyXpoe8c1u97jQKAwq2qdA6/
 O+t2wbddpwJGFZvAcPQX/Swwg7jpnMagu9zAxDFL4ALKkXh+YRnMQLrifozL51eIBnP3GrI0
 weQHAderu7I+tdn/N7MjKGCjoGoD+ohQRIHRTiFte67bHCI8HCizIlMVPezUQrcDG6kqr+/Y
 eh1zu3nNKRfzlxEhJJmFLNw1awzuon0rLhAwwU7TXiSNwa3CqltK2Wt1NVUsvEf3adQvAa7V
 x7d+tRePrnVasrpHERLeFggZ+WHkPUWw3zctKtrZkr94yBz8fyMVkALZ0uAjylULb1UNoI5w
 Ld+5JRHtVTn0hd6YMybii109niXKiBSWasQsJxHUpTgjRAmyw0fbJGAWDX65oqDN4dFPkUwe
 GPGgaPDg/FYxBOHfSNsSz7C2u1SgZlIsxdPlQdQK1OMk9vDp/k2wBwBrmhtH1oNlk1Kg7BpJ
 2xmF0xpPqHSrT1ms85OAjK3EAZbCRzFp0H8xjPlToECo5VEhIAMEIE8BQpJ1EUQ8mYZejoCu
 b/BlzijXjHtc8X8mCA1XCaJbhAlocNZrmX/dAKPRqxp3KXWpRLqh6avYSwDrB6P7QYZmhjcv
 eczlApvQfSTCMPTypHXz6Ge1LINWFaPI2kqrTSNOk8WNTm0RQxeEgRi56x8lg2h6hAKHYKF5
 xRSG/9y
IronPort-HdrOrdr: A9a23:8M3lLK+ESUJ5dwi7F2tuk+D7I+orL9Y04lQ7vn2ZhyYlC/Bw5P
 re+8jzsiWE9Ar5OUtQ5OxoV5PwIk80maQFmrX5eI3SJjUO21HYTr2Kj7GD/9SIIUSXnY9gPO
 VbAtBD4bXLY2SS5vyKhDVQfexQpuVvvJrY4Ns2DE0BceipUctdBstCZjpz23cYeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,230,1643670000"; 
   d="scan'208";a="10375091"
X-MGA-submission: =?us-ascii?q?MDHej/hjiak4dxph2ICWh1Tjqjt9ws8ihoyGzI?=
 =?us-ascii?q?izcZW4wEfpkPn+DkaiFq+uxZF7sQxsNGBFjW6/c0ml60nxpJSAQ19Z3u?=
 =?us-ascii?q?JsWwqpBU0MGs+V3o7rSPOMwIyZmgMYM7pgvf0AalSyqtPwpFlNb4LUfA?=
 =?us-ascii?q?rOPIJUWOWl5QBHfpCE79gdbA=3D=3D?=
Received: from mail-lj1-f176.google.com ([209.85.208.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 18:01:21 +0200
Received: by mail-lj1-f176.google.com with SMTP id 17so7569038ljw.8;
        Sat, 02 Apr 2022 09:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2yqsF6XNMZecnidZl0aEp96ddQFjtrKT7PghFMfSRAs=;
        b=cdvRDIlm2UL6TLLtExpvo1CFABGRxnJXhmwyam0qSDvNcVgSOjc0ljwXt4PKLRa4L3
         uAbET043IBbv85zG17vYob37ikA3ht4IlQAlQYOYLsBJaTDr/pLh0dz4GnAwIBjM7rAU
         Mftr2Umlz1olwi2EhyQpTEd/LWrNAuoMEpP35/d0KAsYwCBtwz/Q4etgHdePbDXR9iV+
         nnsyfx5PwqCgdfQT/8/le+2avLh9Crtb4EPj9Be7zn5gqK1enT8/qMJiFMFunlOL24UB
         GxpyJFSm1ZKKUIwj47mpeHXDqLkstSy3kvld8R2aYSouub0HJCxOubU8a8ZihKcy/pSi
         AFRA==
X-Gm-Message-State: AOAM532nHpnPq+lkeSg5kAX5VK3y42vyndWbnxDjY7DtgEwVccQRD/g9
	m6cxkTjXg6Ol4NJ4fnmlxVNP3i3lV2A=
X-Google-Smtp-Source: ABdhPJwGTUr1GK80fcN9H37rsNmAy74QncKWSMRuXd6NWSMaxZ8JrOpFV7VRs8Gy20FiVINh2pgXLw==
X-Received: by 2002:a05:651c:996:b0:24a:f361:1d9 with SMTP id b22-20020a05651c099600b0024af36101d9mr9637555ljq.346.1648915279177;
        Sat, 02 Apr 2022 09:01:19 -0700 (PDT)
Received: from [10.68.32.117] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id v25-20020a2e4819000000b00245f3318b8csm498533lja.31.2022.04.02.09.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:01:18 -0700 (PDT)
Message-ID: <f8523faa-865b-3875-2a9b-48b8bbf5fae0@linux.com>
Date: Sat, 2 Apr 2022 19:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <604dee67-dbd0-2994-f6a3-b06675c931b6@linux.com>
 <alpine.DEB.2.22.394.2204021757290.3208@hadrien>
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <alpine.DEB.2.22.394.2204021757290.3208@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] coccinelle match fail
Reply-To: Denis Efremov <efremov@linux.com>
X-Loop: cocci@inria.fr
X-Sequence: 334
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/f8523faa-865b-3875-2a9b-48b8bbf5fae0%40linux.com>


On 4/2/22 18:58, Julia Lawall wrote:
> 
> I think there is just a typo in your rule.  As far as I can see in the
> code, there is no & in front of data.  If I remove that, then all is fine.

Thank you! My bad, sorry for the mess.

Regards,
Denis Efremov
