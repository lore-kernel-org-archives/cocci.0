Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3FBC00140
	for <cocci@archiver.kernel.org>; Thu, 18 Aug 2022 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JQIy+ZGJSZRgYcHo2ChCkqxMH2BBhu/NvLszbgtC48g=;
  b=c2kxT/QiKwH+6cuppGvGb7Ojr5Nkmuj9lLQjIeYgTcge7DlOSf7wDlPr
   4jzb6oQ/47bZEGDKmD1Uf8ZhsqFvoavcxHD0F50vDSPNM9wIoC6U79hPn
   TK7j3ndP4Qob3A9BuHE0sEbgzgWxeW8sipRZCV2Z4iZ8Ylnp4dc7qdljH
   8=;
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
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49156149"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Aug 2022 20:00:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89C0DE0385; Thu, 18 Aug 2022 20:00:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8C461E0380
	for <cocci@sympa.inria.fr>; Thu, 18 Aug 2022 20:00:34 +0200 (CEST)
IronPort-SDR: 6P35gKlXbDKDUNdw1VrpUYfe8pGxR6uNnnrhrdJ+2lDUk1PQdqrRXgAybSj5ugFYHlru8i0Iv5
 CEslXSC7OYXpID3M4rRson7gUJFhjcBopTgSqknH55u+dVpvvIsAmx6ESUp6EjZtA4Gh+6CFX7
 FCWHJtwf5Fy0NNs6pUdKYZuT/0bdqx4Ge2BXIynRPrZPrACQgigyO+Rtc0g7g+egG9Hh5XbWi8
 /Xo8iawW7j+NZYzRO1Yf2YhzEW30z58wIj2N9tOBSSgsKfN1x8cuvk0HMOtBDlQ26TiuL/gqZt
 OvQ7uKvSaza7aHhXsTRifDXG
X-IPAS-Result: =?us-ascii?q?A0ChAgDaff5ihk7ASNlaHQEBAQEJARIBBQUBQIFPgiSBW?=
 =?us-ascii?q?C4EC0WETpU0hxGHH4wmCwEDAQ0/AQIEAQGFBwKEegIdBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDAsJBwgKBw4QBTYGXgZkBIFLB?=
 =?us-ascii?q?IF0CzQNgjUig2wDAyMdAQERJw8LDgwCJgICVwYBDAgBAYJ5gm0BAzIHqHWBM?=
 =?us-ascii?q?YEBgggBAQaETh8sIlKBXAmBESyLJoQiJxCBVUSBPAyCdz6IGoJlmU8mBA4DG?=
 =?us-ascii?q?iseQgIBC1IICRcSEBACBBEaCwYDFj0JAgQOA0AIDQMRBAMPGAkSCBAEBgMxD?=
 =?us-ascii?q?CULAwUPDAEGAwYFAwEDGwMUAwUkBwMZDyMNDQQYBx0DAwUlAwICGwcCAgMCB?=
 =?us-ascii?q?hUGAgJOOQgECAQrIw8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJxcHE?=
 =?us-ascii?q?xgbGQEFMicQCSEcCgQaCgYFBhMDIG8FCjsPKDM1PCsfGwqBEiopFQMEBAMCB?=
 =?us-ascii?q?hMDAyICEC4xAxUGKRMSLQcrdQkCAyJpBQMDBCgsAwkfHwcJIiY9BQVbOgEEA?=
 =?us-ascii?q?wMTIj0GAxcCwQaeeTQHghaBP4FEDJ4+BhMug2QBkn4OBpF6lwIgpzqBeIF+M?=
 =?us-ascii?q?xokgzZOAQIBAg0BAgIDAQIBAgkBAQKOHRmEDIotPzQ7AgYLAQEDCYVHAQGFK?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:46rJQKxW7XgCGEAE6CR6t+dnwCrEfRIJ4+MujC+fZmUNrF6WrkVUy
 zQZWDvUOqmLMzGmLY1+b4+09ksPuZPXnIQ3HgppqlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOCU5NfsYkidfyc9IMsaoU8lyrVRbrJA24DjWVvd4
 IOq+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPh28
 elLkbqTcD4pBYrDvr4EDxRcHA9haPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7kxXjsIr
 K1Cbm9dBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/mbvIIGhWtv7ixINauBQ
 vcGbCBjUDWaZTJqZFI5T9U/ps790xETdBUB9Q7L/PNpi4TJ9yR617PmMfLOa9mSTINUmFyZr
 yTI5QzE7goyMduC1Xya/3jqiuKncT7HtJw6E4SE8NpMo2Sqxlc0BztMTAe2pfaXlRvrMz5AE
 HA89i0rpKk00UWkSNjhQhG1yEK5Ug4gt8l4TrRguVDWokbAy1fFVzFcJtJUQIZ+7KcLqSoWO
 kihs/6BONCCmLiSVG7b6bqe6z+/UcT0EYPgTX9bJefmy4O7yG3Wsv4pZog6eEJSpoOscQwcO
 xjQ8EADa0w71KbnLZmT81HdmC6LrZPUVAMz7Qi/djv7sFsmOtf9PNf4sgCzARN8wGCxEQnpU
 J8sxJj20QzyJcrc/MBwaLhRTe/yvZ5pzhWF0A42RvHNCAhBC1b6INwOuWggTKuYGp9KIHfoZ
 lPeowVc+NdaMxOXgVxfM+qM5zAR5fG4T7zND6iKBvIXO8QZXFLZoElGOBHIt0iwwRBEufxuY
 v+zLJf8ZV5EUv8P5GTtGI8gPUoDnXxWKZX7Hs2jk3xKENO2OBaodFvyGAHeMbFjtf3f8V29H
 hQ2H5Li9iizmdbWOkH/mbP/53hTRZTiLZyp+cFRaMCZJQ9qRDMoB/PLn+E+doYjk6kMzrXE+
 XS0W0l5zlvjhCSbeFvQNS05MOviDcRlsHY2HS0wJlL2iXItVoaY6vtNfZUAe7R6pvdoyuR5T
 qVedsjZWqZPRz3L9i4zd574qIA+Jh2niRjQbTWoan4zcsc4FQDO/9bleCrp9TUPV3bm65Fh/
 uf4jg6CGMgNXQVvCsrSecmD9VLpsChPgv92UmvJPsJXJhfm/r9qHCqt3PU5FMcBdEfYzTyA2
 gfKWhoVqLWfo4Ix99WV16mIo53wSrl7GVdGWXbW5/C6OHCCrGakxIZBVseOfCzcDT+lpv/9O
 L8Nl/ysYucamFtqspZnF+g5x6wJ5+zp++1QwDNiESiZdF+sEL5hfiKL0JUdrKFL3bMF6wK6V
 ljWo4tfPqiVftzoGhgdKVN9POiE0PgVnBjU7Og0eRmrunUooeDfCUgCbQORjCF9LaduNN13y
 +kWuPkQt161hC0sP4vUlStT7WmNcicNXqhPWkv222M3ZtfHC22uYKAwzgfz54yTLcpBOA8mL
 1d4QUYEa6t0niL/n7gbTBAhHtaxQbwRtRoMwFJqy5GhhI/envFutPFO2W1fc+mWpymrF8psN
 2ItO0AdyWBiOdt3rJArYl1A0D2tyPFUFoIdBrfJeKDko5GUa1Hw
IronPort-HdrOrdr: A9a23:3L6PG6PmwWJ4EMBcTu+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/N5BRB7PoT+2ODYq4dKTS8gduVbd619QYWcengBpsL0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49156147"
X-MGA-submission: =?us-ascii?q?MDE6fErsO+JjUMUOAVqrv+LMGQNo+7t6sB3KJP?=
 =?us-ascii?q?LJNiXmM9M8dymUd6BivZEEIgqbuy+uDxiDZMxER0QuWQdE3ablnpxYaO?=
 =?us-ascii?q?OwvepRrhiz8h9+2miYxr26ULmkSnL0/HqHMLXa5+8ZWkkiF8WYZpNwLq?=
 =?us-ascii?q?j5FUtDdkVSQIMVid0A75ehmQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 20:00:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660845632;
	bh=PwZ8SEIRnxiybEq5B3EUIwk1l6mLRHRdznYpP17plSs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=VrmQjFPRCC54rp/jiUJJXw4JB7oKdFYsptjvgE90hP1SLIeEAoAvEY8oK36mJm/gY
	 3pisXJBwrlvSUD1Jpsgolt0M47zIFk7EBIp5Jmj3m7sAEnWZ8ZN2OTZFD35x5nCK/9
	 xX8wdKXYgIXPjHPCM6wvd3uC071Fqzr9p/YTSfyY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.48.17.173]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1oGSMQ2vss-008JlA; Thu, 18
 Aug 2022 20:00:32 +0200
Message-ID: <5e521717-d631-8536-43db-7095d2e64728@web.de>
Date: Thu, 18 Aug 2022 20:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-GB
To: Jakob Koschel <jkl820.git@gmail.com>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:++3nAdALzBC5y62wyzgaUeQpMftIcrRLuR1PHJ2SyREm1c3rZng
 2Fd1bnW6XOAhalO0wdrwKf98VaQeCcSa7EHwSR4GOXZfJp/mncuPk4hXXLsQjIv+1b7+ZyI
 afhJjOlqfjhbpunuEE7/mLKgXxrk+YiO/1gfGu/rSqTY1stGH+ucCKbk0MXARO7LpyPm6M9
 kgOroE2HkLn4mW0/zidWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nE5Xt/yzzn8=:tSaWpEjqyb1TtheGuCjVfB
 GpyF4SWjh67BPY0zVLylTrTHv6LYoiTNzccpI5sWNf/hzLhOzhk7dGxlklBkdiyNQpgYh8EEG
 p6zQYoYSjsD0DUDKDP3+dHgCgGM9FEmK1YJWaGzQ9ZoZLYCPTM9x2gwy/KQTIj+Pe/kkEXvWk
 gNnEUoAQXLC4Z/QzBPrGPbnp8f6YGOXt1XmUJVOTTjsQp90Sc2+8wqOQCB4lFMkQmvmMBRgpj
 +fSTTFnsUGNj3HgQIUgM+iK3cGHxCtpv1KilqoXloGCimFuBaq5zP5+JdBTkhmy8Q48bz9Wo8
 BLdax4VIfbtEGQCwYd/eYVZBXu7rwG/eJoYZdAiHE3TagIIRV9lQtn/DuxKRuCYX3fKSoNC5H
 fttIgSR65ds6tJoEITAGWrN6v05c8D4dgSeKl8oPbiNPNqitXIA6tjj2U8DyiY/SN3P7OnIUC
 FsFN6uHeNOj1jjtm3jvALxzo0+OCLB+DQ0vUhvgL0eJVVXI2WEAsT/jixEqxofXW8qHkr3BsA
 JYAitcKtadecg8DvenJWstyWEDv3peNhlYr3Tg3KwzX6fInVGi8KC85AsFA6jJfFUKdYmPt53
 KZKAU5LmShpF80XonC4/MXQMjzO7k90AJNP44fkbWEpOmyC/TfdB3dUNXEAT4Tdz5MYWyT5Ue
 u+xBJfXBPbHst+9xU6IkpnLwYIj6T0AnW+Ag2iifnDKQE52HM2zLPUXflal1i4qKpmE8GyLJj
 ooFFeTU1o5xTudvOu/55xgxWeEvSR2GBnlkbPRRg1svTDPlrwNboqFuRPFi6fnh4vLyofS0pR
 4JqNJypoQugCKJ+tuECJDH7be600d0GtI/gwN0gD4s4DcT22iKPH41xBlFmQV8/wvAEXxgXm7
 202lrjHTOUUAtGuKHixokRFMJs5wpq6jCTWmg7JsUb0KZyWPZa1lex5SXMEvEMgjKE2TCEGh1
 pNdN9YLV3JUkRJE9bzVrysrrRpKSBSBy0jhY58GZjD2dEQAw8b8meER1Ew/RIzQP+S3+Hvmje
 Hea7l2dqbuSyWm6sfp8T2ciyg/3j3utvYy6juF0G3sOT6zBG+hH9E+TjYdh5/8a0y6oPu98Jb
 RpvcVoSxV9HdwGheZgnC+mOnrRr+WrEDgEcUnEEXi6HhTMONpBiqm8SSA==
Subject: Re: [cocci] Checking a comment addition
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 520
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/5e521717-d631-8536-43db-7095d2e64728%40web.de>

> +++ /tmp/cocci-output-test1.c
> @@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
>  }
>
>  int main(int argc, char *argv[]) {
> -  int x = 0;
> +  int x = 0
> +    // test;
>
>    func1(x, "asdf");
>  }


I find such a comment addition questionable.

Do you expect that a semicolon should be used for the variable definition here?

Regards,
Markus

