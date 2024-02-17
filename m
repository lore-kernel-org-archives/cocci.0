Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE45C48BC4
	for <cocci@archiver.kernel.org>; Sat, 17 Feb 2024 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rTV42JcLjxnCBfyN4Qtuof3I52EllDCzxp6mgp7w8s0=;
  b=cfJAmtbCMfM6nQraIEpbsvpDTG4/VV/KUdO5SPSzdLqpX9WvBSrPB0io
   o+DULgW/p4XTSaDJuMdTwy/jAY0KgX8A6w+Dxy703gLzqzpFU/0KVRx9n
   T0faheIlWfyJLro754mGbdwLYEvxiiy4e9lfT5w1Fey8ML58cump38Ae+
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
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="152434910"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Feb 2024 14:14:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47219E0CD5; Sat, 17 Feb 2024 14:14:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 78437E008A
	for <cocci@sympa.inria.fr>; Sat, 17 Feb 2024 14:14:35 +0100 (CET)
IronPort-SDR: 65d0b13a_JY/GrK783Jw68FvTxTB6cr/kUw1QvVhEl3cpbXGEkl0kPEs
 wnNzcB82PrxTj5IKteLOpimoudJ+qEgvO4XoArg==
X-IPAS-Result: =?us-ascii?q?A0HZBQCVsNBlhwMP49RaHgEBCxIMQIQIfANTMgQLSIRTj?=
 =?us-ascii?q?0SBdTCEO48FjAY+DwEDAQ05CAECBAEBAwSEOUYCh2QCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CVRiBDoEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFwINOkEBAgIBIx0BAREnBAsLGgImAgJWGwEBg?=
 =?us-ascii?q?nwBgioBAw4jBw2xTYEygQGCCgEBBq9bHywiVoFhAwaBGi6IJgGKKycPgVVEg?=
 =?us-ascii?q?TwLgkcxPoJhAoFgTYMOgmiFUYJ/lwlUgQIdA4EFBFoNGxEeNxEQEw0DCG4dA?=
 =?us-ascii?q?jE6AwUDBDIKEgwLHwVUA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUA?=
 =?us-ascii?q?zgDAwYDCjEwVUEMUANkHzIJPAsEDBoCGxsNJCMCLEADERACFgMdFgQwEQkLJ?=
 =?us-ascii?q?gMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDE?=
 =?us-ascii?q?IE0hTiEbAyBUgMZKx1AAgELbT01CQsbBiIBHQKfEQGCUIE5IsdFNAeCNIFgg?=
 =?us-ascii?q?WEMihuVHQYTL5cwDgaSX5hYjW+bCIF7I4FcMxokgzZPAxkPjiAMDQmDWDOPR?=
 =?us-ascii?q?0I1OwIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 dCTW1xApPuc4HEB6h2aM3NM5DxpILvc8xs=
IronPort-Data: A9a23:BHEuDa9AWxplg9ei2Jw/DrUDp3qTJUtcMsCJ2f8bNWPcYEJGY0x3y
 2cZCjqGPqnZNmH3e95/aY7no01Vu5OGnNNrQAc9qSBEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYqWo4ow/jb8k835q2t4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE5NBfDRwGOZYk8/tXGH9+8
 dw4cjFRYUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTuJkDtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2IJ+QrL+vFui4TV5CVq/bTBaOTLRvDJAtpXs0W6r
 U7M1V2sV3n2M/TElWrdqSLz7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDafzMXkCIpGW4twM8QsRgF80asgDRxf+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQx79V5rlrDqN+pQSOOBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmhm
 lhmTwBn2d3/aPLnMY3mrTgrZBrx+fD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxJDOtbheV8/dynXXKAnoIF1Pz6nYWNE7qQEyd6TNCxz3oyL7FWytyGolehw5bq7ohxe4P
 RGC0e+u2HOjFCD2PfcsM93Z5zUCzK/mEs+tTf28Uza9SsgZSeNzxwk3PRT49zm1ziAEyPhjU
 b/FK5rEJShBU8xPkmHpL9rxJJdwm0jSM0uIGcukp/lmuJLCDEOopUAtagTVN79hvf7dyOgXm
 v4GX/a3J9xkeLWWSkHqHUQ7dDjm9FBqW86kmN8dbeOZPAttFUcoDvKbk/treJVok+4R3q3E9
 220EB0Qglfup2z1GSPTYFBaaZTrQcleq1A/NncSJlqG4SUoTruuy6Y9TKEJW4cb2tZt9tNKa
 sUUWt6hB61PQwvX+j5GYpjaqpdjRSuRhgmPHnSEZWEhc65ZWgCTxN7AezHr1SgRDxiYsdk1j
 K2g2zj6H7sCZVVGJ+THZM2/y2ieuSAmp9tzeE/TMPx/SV7J4qEzDwDQ19gZe9otLzfHzRukj
 zemOw8S/7TxktVk4ev3irChhKb3NelHR25xPXTRtJSyPgnkpluT+5dKCru0TGqMRVHP2fuQY
 MtOxKvBK9wBplFBtrR8H5tNza4T49jOpadQ/j97HUfkPkiaNbd9HkaohcV/lLVB5rt8izuEX
 kii/tp7O7LQHOjHFFUXBhQub8Xd9PUytwTR088IIxTB1HcqxIaEbERcBAnTqSp/KLAuDpgp7
 918s+Er6iu+qCEQDPC4sg5u+V+hFEcwC5ccislCAavAqBYa9VVZUJmNVg70+M6ubvtPAGkLI
 xiVpvHwuJVB9GX/cl4YN3vE7cxCj7sg5TFIy14jIQySu9zn3/UY4jxYwQ4VfC90kCpV9v1VA
 Xd6EXF1KYGl3SZatOIaU0+CQwh+VQCkoGrvwF43pUjlZkiPVF2VClYiOOyIrXsrw0gFchd1p
 LinmXvYCxD0d8TM3ww3a05vi9rnafdTrgTiusSWL/6pLqkAQwjOo/GRPDITih7dH8kOqlXNp
 rBq8MZOeKTLD3MsjJNhObaK94Y7aU6iH3NDc8FD7alSPGD7eROO4xasBX21WPtwI63tzRflJ
 e1oftlCRjav5hao9zo7P5MBE5Vwvfwu5ecBRI/VGH47g+OhiQRt4b3t9XnYpW40Qt9Rv943B
 aHPehmjTGGBp3tmtFXcjctDO2biX9ggYTf4/eGq8dcmE4AIn/FsfHoTjJq1nSSxGyl28y2Eu
 DjsY/ft8NVj7oB3ja7AL75mBTjoGejsVe+Nzh+/g+5OYfzLL83KkQEf8XvjACh7IpoTXI5Ru
 YmWkduqwn7Agqk6Y1rZl7aFCaNNw8e4B8hTE8DvKUhljTmwY9Dt7zQD6lKHB8Rwyv0F3faeR
 iy8dMeUXvwWUY0ExHRqNg5vIyxEAKHzNqrdtSexqsqXMSck0CvFEciG8EH4ZmQKZw4KPJzDU
 jXPgciM3ewBjopwB04jPcpEUq9IeAqpHeNsctDqrjCXA1W5ml7I6POoiRMk7iqNEXWeVtrz5
 ZXeXBXlaRCuo+fywcpEt5Bp9AgiZJqnbTLcompGkzK3t9y7MILCBeEaLIlAFZxe1CD/vH09i
 Pchc0N6YRgRnxwdGfk/3DgndhiSDKoCN78V4xQ3qliMZX7e6JyoWdNcG+QJ35uyUiTuxqerJ
 LnyP5E20geZmvlUeArY2hB3bSqLCB8XKrLkNH0RS/DPPis=
IronPort-HdrOrdr: A9a23:8ijJWapOGMGrmrslZ6hxo0waV5r1eYIsimQD101hICG9Afbo9P
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AnXMKpGnisIaUsJmqxD9cuAWkJQnXOVr4/XaNE0u?=
 =?us-ascii?q?jNW90aKSLeVuw2Pllz8U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQHcJOw5ZgZSYugGINK6Xgqx3xoxB+ImiJBgzj6k?=
 =?us-ascii?q?q+I6bNwFzGTyxhh6OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,166,1705359600"; 
   d="scan'208";a="79906731"
X-MGA-submission: =?us-ascii?q?MDHarsx9bdxxaos5gksWvDUufKQowcY/ruqWox?=
 =?us-ascii?q?4CPPgaByZj3SM3icUX7KmH70ZQlMC95PCCCEzeTTci9+qf1/N0AmjiAu?=
 =?us-ascii?q?Ax1Yo7BmmLZeY/9fb5sJmBtkxY+zYn7FgJkjr5AC3BzpcTa18bCuecKh?=
 =?us-ascii?q?2N7E2WDKtEOfGbkt6jBZcMXQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 14:14:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708175673; x=1708780473; i=markus.elfring@web.de;
	bh=bUIQ+VZHabMojDwX8JtGLBH8bEtCjieSy3FtqeQblvs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=bbcLuYSj9MtCIMrYHH2eyg8UzxNSxXxTCnGWG6djrfDbJFg4pFhFqw4mkwBnOBKn
	 /3uscuCxoAOVOHxBmWAjn4rxDM84RYCE3uwuQUc0kSjdZZoIKEJqST6zRJYg2qajE
	 GIrR9HrT/EYif5bJLKRHKvugSMmOUIB/OVqkljp6ssejNhhZi+pnzilMCeWwtDN/p
	 oCKXWDmsbuQUCswfD7vvEZfJ4CRBZ85F3EgCDnRJpyDzy+viZWtBwX/bNvjkgP/yz
	 XBMxY6hufBs+VH0E63zk7kjVAfKrZfS24ylJ57oVI16ty4iWu7GdjNt0VdHuOvr5a
	 xbhAZ8A3O2kf/y3Hlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1qmwpE3CqP-00tUwm for
 <cocci@inria.fr>; Sat, 17 Feb 2024 14:14:33 +0100
Message-ID: <6d5d2b50-2878-4d39-b1f3-ae894f880dc4@web.de>
Date: Sat, 17 Feb 2024 14:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: cocci@inria.fr
References: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c5bcc0b5-1a19-4256-8572-b9ee5e78ea0f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LnJO7qx9/s5grQYagSXH/2KfA7mZqPDz7qdCPRfTgL2OEUyX5m5
 gpqrqQVoIr8laGO4G+UHSRRLCuchzbC5fmfDI+5y//y+/9QilKKBk6tQ6JdSsGHHM94bQ22
 9x69cltt4mYyatoXoc0sfmNI1iuzvakGU07Qj7eGipNHGwGWKU2Jzun04lRidtq4+RyPmSY
 Cb6TbyxAsJ6RtFo6vstIg==
UI-OutboundReport: notjunk:1;M01:P0:oTcnr6BN4F4=;kU0rBHHpcjGAtsIgUMn0ng2o1ly
 KbaEdebzPfOeqTJzix4BoxzGn8+n8LL1WwHX1Ir7SlghkVOz7H4KhHiv1Sz/evHdeABJ3u8So
 9D5NE/igh8xikk1kQMvN9kzEsJ+1xPDNj+y/vrPS1h05nRdgVwX4sijyD8GibFRgtDZtdxbLn
 c6AmXX7W/mAmuHww2rwxFN1UUso0Wx0rpERXAQEXuGlEfb8hPeuUOx6Qo7iInle6Rg1xTZjc9
 09QG+wGy4/k+PGXtadxA5qQnvQ1VTweiusureBw8id8r20Ce7LTC+/5BMPHKRTk//AeLtwKz2
 1FN+D1xHqayxkWWpioZ1qcBZK4kHssTsnX1opo2yUVWD6VrYegJCsWv0wICqvPwfzgErV2W6M
 0gfpkTousucW6dtYx9+Hx5fH20ZDLnGIgKmEcTT1LIhmSNfWJpEN+X7JyteTOyvqUqB8XFo/y
 IukuAo/CP4O+87/wLeSiHPRw0MDOPBgqdBWjnOowHDqdOozpwHsOzsKWpcJTAC3ebPxhKB1vZ
 vcPe5vhES9u3UqUtigy4oKOspZSsAQuKF55ThHwfZS+U2eLQs9mGA/UqfAVLBq+07tLzWG3+Q
 aodQDyEcKJ86z1kdAHIZIwTstnmQCNS1lFF3X+bVw+sLepOkoHVmDajOlBpBBkubY85PefF2E
 g1Gbr0k1c1YKig8+LpO+U7g3IAq93CI9IczPBEvHO7ZYr3y/nUxpc2H3Fzelko2kGVXiO+7dp
 kepM38Mcfe9dzNwVf6YghWUt+bVTvnm4yg4/gK9pry2mcYod7Q+LuF4GgPvVUoTxlrH4b1++x
 JoLUX70tGymWkYFqbgRTVHMyDnHmigODIYj4iQVQPh2zo=
Subject: Re: [cocci] Fixing the SmPL search for a bit of duplicate code
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1570
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/6d5d2b50-2878-4d39-b1f3-ae894f880dc4%40web.de>

> I wonder then why no patch is generated by the corresponding test.

The clarification can be continued for the data processing by some scripts
of the semantic patch language also with the help of the following small
source code example.


// See also:
// Fix the search for a repeated condition check with SmPL
// 2024-02-10
// https://github.com/coccinelle/coccinelle/issues/352

int my_test_allocate_components(void)
{
	int result =3D x_allocate();
	if (result !=3D X_SUCCESS)
		return result;
// placeholder
	if (result !=3D X_SUCCESS)
		return result;
// placeholder
	return X_SUCCESS;
}


A patch is generated by two SmPL script variants where SmPL conjunctions
are applied together with metavariables of the type =E2=80=9Cexpression=E2=
=80=9D or =E2=80=9Cstatement=E2=80=9D.

Thus I wonder still why no diff output is produced by the following SmPL
script variant.


@deletion2@
binary operator bo;
constant c;
identifier var;
@@
 if (var bo c)
    return var;
 ... when !=3D var
-if (var bo c)
-   return var;


Regards,
Markus
