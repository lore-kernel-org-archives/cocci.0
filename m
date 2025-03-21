Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B8CC36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 12:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NumCh1OvOIJohJV9M+w/XVOb1bE8o4gduwdDtHhoYJo=;
  b=PBnDHQGHVzfj9ix9WyqToPNDA/VUiL43KT+AJwZ85aHNpWPZsnaYV9cy
   0+OiOYl1JbaPl1afSzLA9eGw4Fm/xuBsVVzdNLkXiEoa9jkgnNZiABRTP
   QMIOIIONHNSClbyoig1k7eanuSTb5QjaWByCZPljiIfLqoZBEOd+xLEED
   k=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214119499"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 13:15:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42A71E0D1E; Fri, 21 Mar 2025 13:15:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 92C32E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 13:15:13 +0100 (CET)
IronPort-SDR: 67dd5852_szJc2UIU5j+pUZdZ4sO8wbVSccDzfF/ufHhQY8oyr8FHQ8c
 PwkHiBrVZDNJ6q5RRKlziD185QnrKYD89x8g6zQ==
X-IPAS-Result: =?us-ascii?q?A0HvAwAtV91ng07ASNlaHgEBCxIMQIQXgVczBAtIhFaPU?=
 =?us-ascii?q?YF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiyICHgcBBEcBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDjuFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJLCwYBFAEBgn6CMAEDD?=
 =?us-ascii?q?iMHrkOBMoEBggwBAQbaXB8sIleBZQmBGoYbgmMBhVxLhDwnD4FVRIE8gwM+i?=
 =?us-ascii?q?B6CaYIzhENnmXaQY1J7HANZLAFVExcLBwWBKUMDKjQxI4EiBTQ0DjgpgWNpS?=
 =?us-ascii?q?ToCDQI1ghskWIIoagQFgSSCNoQ+hECFUIIRgVwDAxYPAYMfdRyDS3U9hGMtU?=
 =?us-ascii?q?IJFHUACAQttPTcJCxsGPaQKhCOCCYIOxiI0B4I4gWaBYwyfXgYTL4NwAZNVD?=
 =?us-ascii?q?gaSfS6FdJJcIqkRNYFsgVwzGiSDNk8DGQ+OIRmEFLp9QjU8AgcBCgEBAwkBg?=
 =?us-ascii?q?VWDcAEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:U2AH06O/v6CVR8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AeNGwwWmOUQv2mRyHprMMSi8z0KfXOWfFxX78MV+?=
 =?us-ascii?q?hMnxoV4OlDlW+v49JitU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkFBD2gzhx+bF2jkDEAKw4gCd//maqL/0VWNSyM9?=
 =?us-ascii?q?dgOyZZD5ABA+0oDOORpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214119489"
X-MGA-submission: =?us-ascii?q?MDFUuitbsSo2GNx6YIBmSlnLTDt2KsKI+05vmP?=
 =?us-ascii?q?9nqiUXqdrMRz+XFZ9Umv+AAWBjqy9r8oRvmq5yhtSpiiqKdn4hmy/Nkd?=
 =?us-ascii?q?oxI5pjgoOxVPxUaxkDyxDfAuhLtHKeRbMiXgbL+FnchiwUgnLlWg/QXG?=
 =?us-ascii?q?ULuUJ7b6kfjjbrJlqu9/tj7A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 13:15:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742559312; x=1743164112; i=markus.elfring@web.de;
	bh=NumCh1OvOIJohJV9M+w/XVOb1bE8o4gduwdDtHhoYJo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M93wluMPAjQgOZVc+yCgFghViVxaxrM8FwKz0r+kQ1WSlF+DYXgAeKWuk/3Nf7N4
	 8HOkCCSSFE/98FXFwGOnCpeUn7z/MWNmeIkDI+bmojuZDlIhxqLNCw9QuPDBR3Mbx
	 Znu93dlPFoVykyjzlTq0R0/fJCZ98gMbw93FfcwH8BKZ9ufVv/N1T0ugPxJqbvxIL
	 dEP4A7IlyV8E6qWxovZ8O8LbWUqhedwfXv9pB6EImzr7oHqLPBSZvFKGl+8p5/pG9
	 Dccf8fIJnZqtShSpjjac00RDcFq+suJbvjV9I1NjaizW42dU76G3Opo8D0HZPh7Zp
	 ffjRW5eJ6KtQlqHNkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1tq5Uy1QqS-005oCJ; Fri, 21
 Mar 2025 13:15:12 +0100
Message-ID: <7ec894ba-ab6f-47be-8aa8-5778ffd1b02a@web.de>
Date: Fri, 21 Mar 2025 13:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZpP5B6cKWlTk/Y2gE0Nc8Dm/hTuzuTnhIhKXqUVwPH81uhae9P
 xPS5EyCkQOMLdY4nT+4FA4Se3Peo9U+ZrHJMnOU7sp+P9uqf3PCEeZvuaZlNemcodzMhV/O
 7HxNdlicjS2jibJEo8RDhTQlC75OKUdxW7z+7Ua9UH0JE1zbROGZRlTrj1FVSqf5pAcnZnD
 Ix/Eax6djbxtsJORZ+c+w==
UI-OutboundReport: notjunk:1;M01:P0:UFYTZR8Gp1A=;SDoi9wK8ueFz4IAYEy+FLUZNL6V
 AY2ZSq5gVwMGnbXIkxsfjjsUH4+Tm23pJ0vepiLs2xMrpjDWx4mX63jtwdnGRizZwJxat1648
 ZhZil21p5sNmyY/UH9fzTnblIXsQPLKbaq7/rRXdyH8Rm14EROrDmtrAnGG//H2uWPwhY1FM0
 +A0/BosVMEzxWX7Bh89Na4Ufwkyq/b5KY7DWrRfdbaPDrCABqD66O7gjtgHR7UBJSFYoOGU0S
 8ZE/0xSTAx0Abtlh6/mdNZsT3rxL/H5k6S1h/mBi4sbHy2fisvK+t7Ca6SHUje7wJNDl5bAkT
 fLdfhGLj8F12fRph2lwCA3VrHjaFSrO2H6QPnLu/YwNBdxdMS1/gKpOMmThLrTGtYK2u5JQP6
 e6ESH+cBhIkaC2UYVcIYjwYA3YezpkadCJbDHAkD+cq5xN+rz1hIYhGbDIOEOaOVbieL0Ta5F
 4w5iJWkQlCklUY0eQRd3mepTEsjg/otEzKd6zbC3BJt/rXrdZWH0isMEt4Jj3P4aGf2zg+Os1
 6Fc8KMp+UjxCEz+HVeji8K1bp5k+R1IgM68ljUcN3SutWJxivNOA3G9FSOeU/n2+8FvzChTCi
 aYAnW3ls5mOquHpETF5+K5o3IQo077h3C/fsYXOFtjPOGrT9zDraHHfZ94+CH+54Od+ESWYKc
 dkrK4bNnOxLJrW+O/09CoHg1mgwz228F/jhlSGj0dQC5+bPA5eWbgqKoycl3Ydi9zZolo7d8D
 KoHyKLyHpwp1VSgspWgmAc/Rl1vPuV/VnzLpF/F2HHamus4RPWGgVzLs3ukcRhqHogPKS6TU7
 4I7dmAK+ljX58TKsqMiXTflMUOPgWH4X9KAsxuTRuBmh/Ureurwy5D+OczqvKoee3FmRWwZq/
 MBtjDg0M/dbs9w2mnjhrgZ3wxJBzDQR21i6967Xdqk1yjvqURbdrQ8RnvQzyeAtRSOSiCoG7M
 6YOfOX7DYWWIFXhrv8vjIQU0QW5CUQKA6sxr+D5Nj7LeHux3gKxv9VyFEOrPbT36o//Y+WoLM
 2HYBVIjcEs0VKCDlSoD1VDPHGnra+wFqiphFBpW+wt4CWo9VpoSALyTLjVr/qOO0D+I/2PN2w
 vfgTwuzO/W8ejYXgu8EoZ+GBSwSMQjsKN1Tgl6A3Su/dVkNPNYli0OmfbaxaGJf3o3zKCH6tR
 e+z5PKdvmSFo1iJcfqmOYQPNQkCUMgh9vQI33KuxY0tQWWv/Ss5NS9SnGnYbcHw8Q9+z9yIC2
 3BUNGCSoPzzqwMFKZxkIjUHSHM9nn6CY3d84W+u2qpXjIsM4DA/SV9vAMpiLh5nr/EeXmEoV9
 oNhqJ5LLDcNK6QXhgyjgKou1D3/RPHBqCvKclox2m2BAN0mAjYuWdE+Q1itbYYPz7JQ5qUl3o
 pd+Vl+TlY9oIJvsfH5s4Nw1je8E4Bcu2rAuJ0+70bp9dKzLQv+rBw4Va0FUBTQuUd+sYKmqPP
 37VMc20PKGOjP43ZhnYk9VITf4+8l3vUkKp67XuVpVMcfdF0e
Subject: Re: [cocci] Adjustments for =?UTF-8?Q?=E2=80=9Cscoped=5Fguard?=
 =?UTF-8?Q?=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2663
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/7ec894ba-ab6f-47be-8aa8-5778ffd1b02a%40web.de>

> Any suggestions about a possible metavariable kind for these names?

I suggest to support =E2=80=9Cblock markers=E2=80=9D better.

Regards,
Markus
