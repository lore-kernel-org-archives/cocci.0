Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C58C43334
	for <cocci@archiver.kernel.org>; Sat,  4 Jun 2022 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kmSARx2eyqvtjcLSeyBA+4XJYaA5aAV+pH24tazn3D8=;
  b=qqfIvKZjVA04lKJUmz77HUTxcy+k+pmwHmdlOxL/Y6jwHoEv15PWVKH1
   VOBWGC8PuVv4nvbn3Dw/WauzlPHr3QMXhpgmvRg30i9SKJR4s1qeA/UUf
   WJRtlkBP+4lh4s3Gf5IfJMRmWQET41PpuJ7ECP5yHsSyq22CEcnW+RhQG
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="39504529"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jun 2022 16:03:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C2F3E02B4; Sat,  4 Jun 2022 16:02:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0C1BE007E
	for <cocci@sympa.inria.fr>; Sat,  4 Jun 2022 16:02:54 +0200 (CEST)
IronPort-SDR: UDnDRBqu7ZjAL4Kweso++oEA4XDEaG4rJIr/Uveye3tGluy1/TqYSMT1sHv6uduHSy1rrJqlQy
 +iu29+mKQK0Kq/kx3CYArNu9YxE7b1+K4cZV+B3OOKqsgFIAGv4+VN0RZK/uz/tSz6h0gTh+4m
 5ykalBQ573f31Evj2jvnUKY3OayMS/IFGf+K5SvopCbqnVTQGbyZ+6hrfDbKeTu/RdaUqxBlr8
 RhpQZlneqLBNiKhw0SASIB6c17WDR4B1+eI5EsrxkkVl3Y33TzL6zHoJqe5Mcfwei2Bh2IL55/
 AKnz9UEU2moJ98soBzdWkcRD
X-IPAS-Result: =?us-ascii?q?A0CgAQBlZZtihwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFWLQQLRIQRPY5ogiiEIYcJhxqMHgsBAwENPwECBAEBPYRFAoVGAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHD?=
 =?us-ascii?q?hAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBDBcdAQERJgEECwkCGgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJ5gmQBAw0oj2ucEoExgQGCCAEBBoRKHywiUoFcCYERLIpHhBsnE?=
 =?us-ascii?q?IFVRIE8DIEJgW4+gQ+DNYNWgmWVI4IHKAQPAxwtNBKBIXEBCAYDAwcKBTIGA?=
 =?us-ascii?q?gwYFAQCExJNBh0CEgUHCgYWDhQcEhIZDA8DEgMRAQcCCxIIFSwIAwIDCAMCA?=
 =?us-ascii?q?yMLAgMXCQcKAx0IChwSEBQCBBMeCwgDGR8sCQIEDgNFCAsKAxEEAxMYCxYIE?=
 =?us-ascii?q?AQGAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDA?=
 =?us-ascii?q?gIbBwICAwIGFwYCAhlYCiYNCAQIBBgEHSUQBQIHMQUELwIeBAUGEQkCFgIGB?=
 =?us-ascii?q?AUCBAQWAgISCAIIJxsHFhkdGQEFNicGCwkhFgYKHwsGBQYWAyNKJwUKPg8pN?=
 =?us-ascii?q?TY9BiIBGwKYF3EBAYENw2Q0B4IUgT2BQwyeLAYTLZZRDgaRdpZoIKcTgXiBf?=
 =?us-ascii?q?jMaJIM3TgECAQINAQICAwECAQIJAQECjh0ZHoNuii0/NDsCBgEKAQEDCYVHA?=
 =?us-ascii?q?QGKSwEB?=
IronPort-PHdr: A9a23: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
 IUDQPlXWQ5sfs4=
IronPort-Data: A9a23:JZ6rwKhVIKJvdDM3oEWzReyfX161eBYKZh0ujC45NGQN5FlHY01je
 htvD2HSb6rZZWWnKd4jaoqw804B6pfUx9drHQJqqHs1RSNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8x6TSFK1nV4
 4mq/ZWDYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplusOhbAAYZKPwvqcnUiJeFitFIJZ85+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1bY7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYYFjW1r25EXdRrYT
 /YGNWtzVRrwWDp0KFQSF4Iflb60gWaqJlW0r3rM+PZpujGNpOBr65DpOcXcftiiV8RQlFyR4
 GPA5WXwRB8AXPSUzjGO81q3l+rXlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3J
 BMF3y0f96YO0g+RT+L7WheDvUW+oUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAOAbWN8KqS8Ci
 g7RxIOzbdB7mO3OGSzEnluBhW7qYUAowXk+iTgsYSZtDzPLg4gpignVU9ZueEJepoKrQG2hq
 9xmhAI3i7gVyPGgA7+n4V3CiT+2qfD0ouMd4wLKQiS64wk/aIPNi22UBbrzvagowGWxFwjpU
 J04dy62srhm4XalynblfQn1NOv1j8tpyRWF6bKVI7Ev9i6251modp1K7Td1KS9Ba5hZJWW5O
 ReJ5l4Ltfe/2UdGi4coM+pd7Ox1nMDd+SjNCqm8gidmP8QgKlTdlM2QTRTMhTiz+KTTrU3PE
 c7GLZj1VChy5VVPlXTvD+YbzbIxwC0ijWrcLa0XPDz3uYdykEW9EO9fWHPXNr5RxPrd/G39r
 ogDX+PXlUQ3eLCvOkH/rN9IRXhXfChTLc6s96R/KLXZSiI4Qz5JNhMk6eh8E2CTt/8JzbigE
 7DUchMw9WcTclWcdVTbNyo5NuqxNXu9xFpiVRER0Z+T8yBLSe6SAG03LfPbpJErq75uy+BaV
 f4Ad5nSC/hDUGqV5DkXK5Xw9dQweBOujAOIHiykfDlmI88+HVOUoIe8c1u97jQKAwq2qdA6/
 e+q2DTbdpxfFQ5sO8DbNaC0xFSrsHlBw+9/BhOaItRadEj23pJtLij90q0+L80Wd0fcyzHc2
 wvPWUUUouzEookU9tjVhPnY/tnzTLYkRhJXRjCJ46y3OC/W+nuY7bVBCOvYLyrAUG7U+bm5Y
 bsHxf/LMMoBwARAvb16Hus51qk5/dbu++RXwwk4TnXGa1OnVuFpLnWchJAds6pQ2vlGtAHwV
 k/WootWPrCAOcXEFl8NJVN5P7rZiqxOwmHfvaYvPUH3xC5r577ZA09cCBm7jnAPJrVCNo54k
 /wqv9Qb6lDkhxd2YMyKiDtYqzaFInAaCvx1s5YHHMn0hwBtxlwbOc7QDSr/4ZeubdRQMxB2c
 2HO2/eY3+xRlhjYbn4+NXnRxu4D154AjxB9ygNQLVq+nNeY1OQ82wdc8GhsQwlYpvmdPzmf5
 oS224xJyaSyE/NAgc9eQyazFgsHCBDxFokdDbcWvDWxcqVqfjWlwK4B1SKl400TtW5RFtSe1
 K/N037rCF4GY+mothbfmidZRzjLUtF7sAHP8Cxi8wJpALFiCQfYbmSSiabkZvcp7Q7dRKEKm
 AWywNtNVA==
IronPort-HdrOrdr: A9a23:rWdobK8aj0oE9UzUfo9uk+D8I+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,277,1647298800"; 
   d="scan'208";a="15923591"
X-MGA-submission: =?us-ascii?q?MDEBgoo3QqV9dxceBcF37/gBtbsbcSD539scKy?=
 =?us-ascii?q?H+8F20jTjI6TamhoyFjv3IYI1pM/I3j7jc+ns8lgsFde2AIO1w+6kpwv?=
 =?us-ascii?q?caokeYcOuAd17qu0xaKDpXLfOlJn4DcEHtJAM/WvRO8dQclMkYNSeCFa?=
 =?us-ascii?q?U2Ztmj/Zi/Gs4dx8YyJFbTkA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 16:02:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654351372;
	bh=MdlmIfLVACZAdHMauczraFStSJAhxrpsNFeLMhbRQXI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=VwjEAZtXzsjkGwmix/dpw433ojfKY881zXSHxPczBv1IDBxCZclCWMuxM4SmZoYBm
	 8065FwCDZZ18AYDGr3h2cn+EonayNMnZZltdXpyii/uN94R8gAIQyaT4viAL9ewYFz
	 0TDTk62L2zgXsuUVf39RuNoCLhzQRP4nqgpQxlac=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.157.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1ni9Pn3Oye-016D6j; Sat, 04
 Jun 2022 16:02:51 +0200
Message-ID: <2490b8cf-4d9e-1357-6563-097264bcb01a@web.de>
Date: Sat, 4 Jun 2022 16:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB7603A9FB9FA6A62438B09A3793DD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cG3PRaj2iczSIFnDX1snj0DdfZipIAH6FxofDYYi8FqEE53HPb4
 WoKeitHY3h8qiYYTma2KGkxFSgZ5IH41RuRX2CWBq9zRW7jRtV10ENtQqtKRo+F2P+r/yc3
 4/2arLo0lEv+dkSSNhMz+vMndnht+2+GSHD4oIHzr/zPIcJZFkb9Th5y5wleVzRsNPFQ3bA
 dYje9Wimec/WB/oMx7f6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4jYLlnp57C8=:5cnVB9OtPH4QS652zyLwkp
 kPLvd5dyPH4CmhESp1FVfdnqgh8p71YG/WBRlObII+UGHVQqeCugQ2AcrR0bmkZs4ESAxFJNt
 GHEUHy+ikhJNSZrPYwMRotLUtRK0juqljF3m845y2P1UmJCzMUFWPbFQiDVPXZD6QR7rkMGSh
 YOWg1XL9ip4pks89PJ671A2cLQnefSPs8DUMsXo7SzrwUM39b2/J2MesSXIZLJgBSsgaJHsN4
 2XlppHpBMb58sf5LXrafUflYAE99Hf9ZN6GKlMwS3cfxgyThdQU77nmmN9TwpBiVIaIiH+5dO
 j4jazOZcyPcUBWq0SJdwnJ3a7zZK0WeJED8M5JMvZaYlJiX06w6UNtu17lz82uzpNn1pqyIGt
 UmFWFV0Js4gkfHNukwKyOzoceeMmj/404/9UDr5rYFn/LZimTVXrU0YXTI+CGsxq4CtMJyZdt
 zIMIXJzD9sRUQZ3TTKMp5W+sq8GFYTUh165G4jvtsFgMiavptUk17SGG1BGqff8dEvr23KdJ+
 OMscy8DR39ZMfdzGpuPfzpyapNjMaK3YOyFo10oe2AHCzazAckzoufo8p0EUCOSLWVDKq8TDx
 GC/efECnrsDBsENdjGOvaqUq76tq+GrH0cCy1mRY1Vnwq3LRxf15P+u5sH0yD2hTaeyhHXxiq
 2hYckzuwSDLz6sbqJaU5xKQxgE+Ce5tb8kxfx9KzWjcYKguQ7DV17e9nfQajDD8eymWXWCZol
 2TkjaiotMcdU1uWMhp3zYMMijlrL/jhTHelGodidw7hSEks/n81gHzTLizxqNeV/qyXGpL20o
 pVW5eUKkQRXtW3csWk3HHvl8pcyo7awlC4SeAkw2HsdQJ7YHgfIObGEqyxv6rowzW9UVL7l0X
 DGEmupwoUKrHXwVwgRJ0YesmbQujdeRpeghStao5WcvnfrPXbmxpucXWsaXEbjASBk3Sm7qwa
 TC/ujoHZmeSq4RpZP86IdsmIiDu4x4pgwLBi/E6GZlieRf4IMRS2GqflUywTpIHbs6QNiNEFg
 ao4BCIJnIsZ/1lWV1VBLgy1t/mgkvyv1DVzh/5Bcd3LGTF8WoaWmEhSUT0jMb1A60EIGx/Hcj
 1Y6Po2p9vcFOpPm3oL647ef+4tgBI+ln1wsw7rsLeq+b4nRqjLNQk8g2Q==
Subject: Re: [cocci] [PATCH] coccinelle: ifaddr: Find address test in more
 complex conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 414
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/2490b8cf-4d9e-1357-6563-097264bcb01a%40web.de>


> The test of an expression's address does not necessarily represent the
> whole condition, it may only be a part of it.
> This change aims at detecting an address test in more complex conditions=
.
>
> Signed-off-by: J=C3=A9r=C3=A9my Lefaure <jeremy.lefaure@netatmo.com>
> ---
>  scripts/coccinelle/misc/ifaddr.cocci | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/m=
isc/ifaddr.cocci
> index fc92e8fcbfcb..387af44a1256 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/ifaddr.cocci
> @@ -18,8 +18,16 @@ statement S1,S2;
>  position p;
>  @@
>
> +(
>  *if@p (&x)
>   S1 else S2
> +|
> +*if@p (&x || ...)
> + S1 else S2
> +|
> +*if@p (&x && ...)
> + S1 else S2
> +)
>
>  @script:python depends on org@
>  p << r.p;


You would like to extend a check for an if statement.
I suggest to specify the corresponding SmPL disjunction like the following=
.

@r@
expression x;
statement S1,S2;
position p;
@@

*if@p ( \(&x \| &x || ... \| &x && ... \) )
=C2=A0S1 else S2


How do you think about to use such a SmPL code variant instead?

Regards,
Markus

