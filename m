Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C157C6FD19
	for <cocci@archiver.kernel.org>; Fri, 10 Mar 2023 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kyicINDk7LyR4Xw3ZAmUJkVw7ziwCI5KluWtqbvS5mQ=;
  b=FSuQCQFxpi9v3QNwnaz0117PYQ2LxhEe40fTWe9MFgs7edaXXTGIZQFm
   aq2roOepXRjdF0os7WMcAIWQbMMovDCef/pSGu3Gix4y0LpB+50GCSt7W
   Sjwu9yDmVqp7V2bGiT3QbSWzDTj5dKsKsAYMEiio5KzE9zreuPDZcSapD
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="96478903"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2023 11:09:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2FF4BE0C95; Fri, 10 Mar 2023 11:09:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38908E0010
	for <cocci@sympa.inria.fr>; Fri, 10 Mar 2023 11:01:41 +0100 (CET)
IronPort-SDR: 640b0004_El7mgXEjgZHpfyWLqkgxTWlTVBUHmdeT/cXSf+LUHXXHoN/
 Br4c5E0yC7BFJbBrtVwqe2W5blUq/HeiK/ZIJ2A==
X-IPAS-Result: =?us-ascii?q?A0HOBQAQ/wpkfzTQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwRRjVGGN4F1i1iCE4QpjHo+DwEDAQsBAUICBAEBAwQ4hEYChTICH?=
 =?us-ascii?q?QcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEZCRkHD?=
 =?us-ascii?q?g4FJIVoDYI3KQF1TQM4AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQQCfjkBAR0BAQEBAgESKAYBGx0BAwELBgUYLiMRAQUBHAYTIoUEA?=
 =?us-ascii?q?QMOIwMEpD6BBEKKOHiBFwUCFoEBggkGnAsKGSgNa4FbAgcJAQgVgRmEOCOCa?=
 =?us-ascii?q?YUog016J4EDFYEQhD8+iwMElzsBAwICAwICAwYEAgICBQQCAQMEAg4EDgMBA?=
 =?us-ascii?q?QICAQECBAgCAgMDAggPEwMHAgEGBQEDAQIGBAIEAQsCBQIKAQIEAQICAgEFC?=
 =?us-ascii?q?QEDAQMBCwICBwIDBQYEAgMNAgEBAwICAg0DAgMCBAEFBQEBEAIGBAcBBgMLA?=
 =?us-ascii?q?gQBBAMBAgUHAwYDAgICAggEEgIDAgIEBQICAgECBAUCBwYCAQICAgQCAQMCB?=
 =?us-ascii?q?AICBAICBAMbAgMFAw4CAgICAQkLAgMHBAIDAwEHAgIMAQMYAwICAgICAgEDB?=
 =?us-ascii?q?woECQQCBQECAQQLAQUBDQQCAgICAgMCAQEDBggGAwoCBQQDAwYJDw8IBQMBB?=
 =?us-ascii?q?AMCAwIBCAsCAwICBAgCAwECAgEGAgMBAgIBAgIBCwEBAgMFAgIRAQICAgICA?=
 =?us-ascii?q?QECAwIDAQcBAgIcBgQFAwMFAgIBBAECAgQEBQsCBAMBAQECAgICAwILAwUDA?=
 =?us-ascii?q?QYDAwoHBAEIAgYDBAIFBAMEBAYCAgICAgEEAQYLAwIEBAMDBgMJAgIMAhQCE?=
 =?us-ascii?q?gYBBAsLBAECAgIOAwQGAgMDAgIFCQQCAgICAgMGAgkEAgIDAwICAwMHAwECA?=
 =?us-ascii?q?gIFAQQFBgMCBAIBAwIEAgIEAwQBBwICAgICAwECAgMDAQIBBgMCAgIFAgIBC?=
 =?us-ascii?q?AIDAgICAgMDDwEBAQIKAgMBAQEFBAICCAYBAgICBAQBAgICAgICAgwDAgICA?=
 =?us-ascii?q?wICBgMCAgMUAwICBQIECgMBAgIEAgIiDwMDAiADRB0CCQMjDwMLCQgTFygGD?=
 =?us-ascii?q?Ac0BDQBFAcMBwcGKg4GAgYDBAEKCwUEBQgBAgEBBgIEAgcJDAIBBgEFAgIDA?=
 =?us-ascii?q?gEFAgEGAwECAgICBQYFAwQFAxMDAQEEAwIBAgECAwIDBwMCBAIDAQIDBAYGA?=
 =?us-ascii?q?QkEBgUNAwQCAgECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAoHA?=
 =?us-ascii?q?wMCAQULBAIDAgMBBgkEAgIGAQIEAgICAgICAwEBAwkEAgEDAgIEAwYCAQIBC?=
 =?us-ascii?q?QUCAQkDAQIBAgEEAQMJAQICBAkCAwcFCgICAgIIAgIOAwMCAQEEAgIEBQkBA?=
 =?us-ascii?q?gcCBQEBAwUHAgIBAgIBBAMBCQQBAgMCAQEDEgMDAQQCBQMDDQkGAgIBAwIBD?=
 =?us-ascii?q?QMBAgECAwEFBRcDCAcUAwUCAgQEAQcCAgMDAwIBAgkGAQMBBQIOAwICBAYBA?=
 =?us-ascii?q?gEBAgMPBQEBAQEXAQMEAgMBBAMBAQIBAgMPBAEEBQsDHAIEAQgIAgIDAwECA?=
 =?us-ascii?q?wUBAgMEAgEICgICAgIJAgoDAgMBAwUBAwIJAwEFAQIHAgYBAQECAgIGAggCA?=
 =?us-ascii?q?wsBAwUGAgECAgEFAgECAgUDBQICAgIEDQIFAgICBQECBwQCAgIDAQICBgUBA?=
 =?us-ascii?q?gcHAgUCAgIDAwoEBAcEAQEBAgEBBQECAQMDAQIEAQIBAgUDBgICAgIBAgIBA?=
 =?us-ascii?q?QEIAgICAgICAwQCCJtFGXtmW4EkliaNBKBMB4N9hAScYkwTlnSSN5dkommFB?=
 =?us-ascii?q?QIKBwYQIxKBRCOBXDMaI4M3TwMZD44gDBaDUI96QDQ7AgcLAQEDCYVDJhMLA?=
 =?us-ascii?q?YU7AQE?=
IronPort-PHdr: A9a23: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
 0xu4jY=
IronPort-Data: A9a23:EOrgLamMYcWRbwnTOpPEwa/o5gxtIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbW22Hb/3cZWGmedgnOt6y80IDscfVyYRhSQtl/3wxFVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTres1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82MyYzJ8B56r8ks156yp4WtA5zTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1FNEYVZrEk2t9bQkRT9
 vkREz9cMhqM0rfeLLKTEoGAh+wmJcjveY4T4zRukGufAvEhTpTOBa7N4Le03h9q3pEITauYP
 ZJJL2c1BPjDS0Un1lM/Ep8m2uuvmj/5dCVwp1ecpK5x6G/WpOB0+OmzbIWIJ43XLSlTtkWeu
 nrY1lXIOEg9Ks2C+Cu442mNm9aayEsXX6pLTOHinhJwu3WXz3MaDBk+R1q+q+OwzE+4QdNWb
 UIOkgIlqqM59WSwX9zlVlu5pmSFt1gSQbJt//YS7QiMzu/Z71/cCDVeCDFGb9MiuYk9QjlCO
 kK1c83BLgRok+apdVKk2vSxsDC3MBMafDMIanpRJeca2OXLrIY2hxPJa99sFq+pk9H4cQ0cJ
 Rja/EDSYJ1D3aY2O7WHEUPv2G3z+8CYJuIhzkCGATL/t1IRiJuNPtTwsTDmAeB8wJF1p2RtU
 VABksmaqe0CVNSDyXbLT+IKE7Wkof2CNVUwYGKD/bFwrFxBGFb5Jei8BQ2Swm83Yq7onhe3P
 yfuVft5vsM7AZdTRfYfj3iNI8or17P8Mt/uS+rZaNFDCrAoKlDXp3EwOxTNjz21+KTJrU3ZE
 cfLGSpLJSZKYZmLMBLrLwvg+eV6mnhvmT27qW7Tk073i9Jym0J5uZ9caAfUBgzIxKyDpwrR/
 r5i2ziimn1ivBnFSnCPq+Y7dAhURVBiXMyeg5EJK4arf1U+cEl/UaO56e16IORNwf8F/tokC
 1nnBSe0PnKk1SOZQehLA1g/AI7SsWFX9C9qbHNyYAj3gBDOo++Htc8iSnf+RpF/nMQL8BK+Z
 6BtlxyoU68XGAfUsS8Qd4f8p4FEfRGmz1DGdSm8bTR1O9YqSwXV85W2NkHi5QsfPBqR7MEem
 ryH0h+EYJwhQw85Mt3aRsjyxHyMvF8cutlIYW32Hvdpdn/Rrbdacx7KsqdvIuUnCwny+T+B5
 gPHXTYavbbspqE2wvnohIeFjYGjLMVmFGEHHWOBtbeSHgvZ91qF3oVvfrupfzfcdWWs44SkR
 7xf4M/dOc09vmRhktRDAZcy6okh9f7DmqR88j10OFnqM3G6FaJGIFSd+MtE65122b5SvDWpV
 nK1+tV1PauDPOXnGgUzIDUJQ/ui1/YGvCv79tUwfVvH4RFo8Iq9UUl9OweGjApfJuBXNKIn2
 eIQh94E2TegixYFMse0sQ4Mzj6idkc/aqQAso0WJKTJiQBxk1FLXsH6Ox/MuZqKb41BD1kuL
 jqqn5H9vrV7xHSTV1ooFHPI4/hRuoRWhjBO0205Bgqonvjru6YJ+SN/oBUNYCZb9BFl695IG
 3NKMhR1LJqe/j0zi8lkWXutKj57BxaY2xLQzlcVpVLdVG2tcHLHF0wmGOO35EtC2XltTjta2
 7C5yWjeTjfhev/q7BYyQUJIr//CT8R70w//xOSLOtujJIZjRxbImYqsangshzq9JPgulWvVo
 eVO18RhW53RbCI/jfUyNNiH6O42VhuBGl1nfdhg26EsRkT3ZzC43Gm1GXCbI89iCaTDzh6lN
 pZIOMlKahWZ0RSOpBA9AYonAed9vNwt1eo4VoLbH0w0mJrBkWMxq7PVzDb0u0EzSdY3kcodF
 JLYRwjfLkOu30lri03/h+gaHFrgetQVRhzO7Mbs+sUzKp8zmuVNc0Yz77iKg0uoIDZXpxK6g
 C6TZov97fBT9oB3ro69ToRBH1qVLP3wZsSp8Seykch/UtfUFfjwtCYu81zBAyVLD+FAReYth
 bCptfjp1njkp5czaXjSwLOaJplK5OKzfetZCd32J39khhm/WNfgzh8A2mKgI7lbuYl5yuj+Y
 CXgc+q2V9oee+kF9U1vcyIETiosUfXmXJnvtQaWjqqqCCFE9SflMdn+13viTV8DRx8yI5ekV
 zPF4ae/1Ot58rZJKgQPXcx9IplCJ1TmZ6sqWvvxuRScDUiqmlmygaTjpzVx9QD0DmS4L+ii7
 aLnXhTecDGAiJPMxvxdsK1wuUQZMi8sy614NEcQ4MV/hD2GHXYLZ7ZVe4kPDpZP1Df+ztfkb
 TXKd3EvEjj5QS8CSxjn/dD/RU2KM4Ti4DsiyuABpCt4qhtaBb9sxJNk/yZkpnp6I37tkbvhJ
 tYZ9Xn9eBO2x/mFgArVCuOT2Y9aKjHynxrkOnwRV+T9Bh8fBfMB03kJ8M9lS3ncC8+U/KnUD
 TFdeI2HKX1XjWb+FM9hfzheHxRxUPYDCdk3RX/n/eszcLl3AAGNJDMT9g0zPnA+gBw2GYMz
IronPort-HdrOrdr: A9a23:TT3NW68jjQZbzk3GO5tuk+D1I+orL9Y04lQ7vn2ZhyYlFvBw8P
 re4cjztCWE8gr5PUtLpTnuAtjifZqxz+8W3WBVB8baYOCEghrSEGgB1/qF/9SIIUSXnY5gPO
 VbAtBD4bXLbGSS5vyKhzVQfexQpeVvM5rFuQ4d9RpQpM1RBJ2IJj0WNjqm
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="96475595"
X-MGA-submission: =?us-ascii?q?MDG7LdjiJNs5z4y/visJbQYr1ZIIaIWGk+53NL?=
 =?us-ascii?q?NCvOEOvR8ffl1y38Fyu+XSqqN3dVS8q2fSsRs9q3AObeZqDOQ/afpEmR?=
 =?us-ascii?q?1ShGhHmaFBa/Qc/DZT8w8HVg5dn2AbBzGgLyEbf/DzYv83kTgxKeNZDQ?=
 =?us-ascii?q?OZmNwxLD8QTklsOb8CUYht5w=3D=3D?=
Received: from mail-ed1-f52.google.com ([209.85.208.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:01:39 +0100
Received: by mail-ed1-f52.google.com with SMTP id da10so18320058edb.3;
        Fri, 10 Mar 2023 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678442500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyicINDk7LyR4Xw3ZAmUJkVw7ziwCI5KluWtqbvS5mQ=;
        b=bo+mo4Msx4akaGEqzFUcf6nRWN/Nh5TuH6BGpFj+AXCMZ/kQOM5FHA+8eCPwjMdKCJ
         dyjxPgTtYR/L6arNd3tBa+oNi/UNdhJYfVX5XAcjlaAfhNLrsIezVN0CCrBxMcOKsu+S
         zORSnJz/61H5suyJ0ivUxL9tmgJN1rIo9B/dQyTF7QAVaFZBppTcWCv6tnFy4rPnjI6o
         py1MC3sds2czndpQiISxGRa5eoiOZYC/mpbpJDJvst3O9Hop2F8JbSLzRgiCwTjRXSYf
         QwLHJPx+ixG2bNjmTizwrLhhpub9rpoL/IOtjklI1V6lbQloxf6aq7bopuDDq96qn7no
         ovuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678442500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyicINDk7LyR4Xw3ZAmUJkVw7ziwCI5KluWtqbvS5mQ=;
        b=pldvG5C0O61FKJeTZetcecjUAYwGWxDEm77UkRFNdq6S5yjYDbm99YyO5M8ZNZs/6G
         1/E6n+R5H5ye2yHorUDBbGTogsaTcl+1nB5oNabYuQ6oL73/8CZYBKiHWEIqp3ZxPUip
         d5eexy06OfQegbi6du2f3d9vh9w9JZQoUdf/UxiwQDKGHsfLAJ9+INEeCS5KkTgr44Ba
         Ty5K74307JgvDMLYAggQDnIqon8ILf7C5+SAsCw3w5Wt7f+YvjdW8Q5NymJgaqv1UQOj
         6AaaDn+MZDYD9QcuQgIYyEVDvDjY6fvCyH6K2G6WEyCprSZqkfuYtGtGvZpwOwyPVpfJ
         jrog==
X-Gm-Message-State: AO0yUKVhrO8xXI1bR6gZ2FJgUiVwhivolmjwTVD/Bvez8uy5rB/OsaXw
	RZASKN0t9bbv2YUzGmHyDCw=
X-Google-Smtp-Source: AK7set9tKA6MMY/ZPduu64c8R4NCgbuvqmwFSTmSG8iGWsOpzdy+CyhzLMDv4WRDWRSImtUxCxXpxw==
X-Received: by 2002:a17:906:7710:b0:8f3:8bfd:a8e with SMTP id q16-20020a170906771000b008f38bfd0a8emr1627456ejm.26.1678442500088;
        Fri, 10 Mar 2023 02:01:40 -0800 (PST)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709061c0900b008d173604d72sm761519ejg.174.2023.03.10.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 02:01:39 -0800 (PST)
Date: Fri, 10 Mar 2023 11:01:35 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: rep.dot.nop@gmail.com, cocci@inria.fr
Message-ID: <20230310110135.66cbd31b@nbbrfq>
In-Reply-To: <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq>
	<89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
	<ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 886
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230310110135.66cbd31b%40nbbrfq>

On Thu, 9 Mar 2023 09:47:17 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Thu, 9 Mar 2023, Julia Lawall wrote:
> > On Thu, 9 Mar 2023, Bernhard Reutner-Fischer wrote:
[]
> Another issue is that your semantic patch could be more efficient.  You
> have the declaration
> 
> type mpz_t;
> 
> I think you meant:
> 
> typedef mpz_t;
> 
> Then the only goal of the pattern
> 
> mpz_t i;
> ...
> 
> seems to be to ensure the type of i.  This can be done in the metavariable
> declaration:
> 
> local idexpression mpz_t i
> 
> and then in the second rule, it would be:
> 
> local idexpression mpz_t mpz_0_find.i;
> 
> In this way, you will not be matching from the top of the function, but
> rather only from the relevant call to the return.

mhm. But if there is no return statement whatsoever in that scope?

Consider:
int myround (double dbl)
{
  int ret = 0;
  // mpfr_t outer; mpfr_init (outer);
  if (global_var)
    {
      unsigned long ul;
      mpfr_t i;
      mpfr_init (i);
      mpfr_frac (i, dbl, MPFR_RNDZ);
      if (mpfr_cmp_si (i, 0) != 0)
        {
	  ret = 42;
	  moan ("round");
	}
      /* mpfr_clear (i); missing here */
    }
  // mpfr_clear (outer) insertion works, there is a return stmt.
  // probably breaks in a void function like in the scope above..
  // There is no 'i' to clear _here_, of course!
  return ret;
}
EOF

If i'd understand a local idexpression 'i' to have a scope, i would have
hoped to somehow get at the position of i at end of scope?
But i think i need to match either a return or end-of-block, so i can 
insert the mpfr_clear properly in either case. Somehow.

Ideas?
many thanks,
