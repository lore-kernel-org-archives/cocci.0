Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBD6C48BC3
	for <cocci@archiver.kernel.org>; Wed, 21 Feb 2024 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8eC4ZJjIKoFzHslElNfmBHM5OFzA2SZMayhO48TlSe0=;
  b=kllgMa0zhlOjzHsbk8bZU6lUFZmxd9KivF1KmGRlYrNAexPnYYFVNKas
   i6qJUEF+r0bYu6onDx6wTyE8YIk3mUlN2fdtA4MPK1jKtwT0y4h8LOb8i
   9bTMow3L53SUVSC6KVOqhluUtcaMrgC3QI0Vx6cB+eTdQKtD6XADYpdAY
   U=;
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
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="153053305"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Feb 2024 13:09:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9A750E0CD7; Wed, 21 Feb 2024 13:09:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 64465E008A
	for <cocci@sympa.inria.fr>; Wed, 21 Feb 2024 13:09:21 +0100 (CET)
IronPort-SDR: 65d5e7f0_Dqv3uo/zI6WpxC2a8WQoe5JK9bezwh7fAnffF8wWNZaEPPm
 dHKRUqyOpoz8petHrP+XBVHCC8IacL90T7zWJeQ==
X-IPAS-Result: =?us-ascii?q?A0FiBAB459Vlhk7ASNlagQmBT4I5Yh1TMgQLSIRTj0SBd?=
 =?us-ascii?q?YRrhzeHToRrhVuBfg8BAwENQQECBAEBAwEDgguCdAKHbAIeBwEEMAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEhGQcOECeFbA2CVTuCE?=
 =?us-ascii?q?CyBCAMDIx0BAREnDwsaAiYCAlYbAQGCfIIrAQMxB69+gTKBAYIKAQEGgmesd?=
 =?us-ascii?q?B8sIlaBYQmBGi6IJgGKKycPgVVEgTwLgng+hENNgw6CaIIWgzuIfYpjhlZUf?=
 =?us-ascii?q?xwDgQUEXA0bEB43ERAFDg0DCG4dAjE6AwUDBDIKEgwLHwVUA0MGSQsDAhoFA?=
 =?us-ascii?q?wMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMUANkHzIJPA8MGgIbG?=
 =?us-ascii?q?w0kIwIsQAMREAIWAx0WBDARCQsmAyoGNgISDAYGBl0jBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?XQRAwQKAxMHCwd4ggmBPQQTRAMQgTSKJwyCCAQDGSsdQAIBC209NQkLGwYjH?=
 =?us-ascii?q?QKjBhSCc5J4B5Mjnn40B4I0gWCBYQyfOAYQAy+XMQ4Gkl8uh1aQVah3gWQ6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OLA0JhAuPR0I1OwIHAQoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:OeAKHqHFbn0a6Nk4pLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK/yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4pgPM
 xbE5SWZueAaGRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:vU03XGF6O414QEcsqmI2808aG9kAXEf2wViTLXblKTxTUqSsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Az6l5NA8f+nP5QLdpqKAvVqqQf8U574STFBhSrZ8?=
 =?us-ascii?q?PgczZKhdTImyzsDviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="153053289"
X-MGA-submission: =?us-ascii?q?MDFDkK6R91etM/Gq1xBMYXeZMMQ4NowopS5lyR?=
 =?us-ascii?q?Fwnjyat1QjTcjiFt7dXwOpPbWVeLuM1gWx4T9NuXH8KhnXG1w0nv7y+S?=
 =?us-ascii?q?JJYq7JHHbao6iNrt54f94mo+vh6S2HmI6frKS/VUxZY45EDatUoipfmX?=
 =?us-ascii?q?G/B8uL2vu6tJlPe4HCLMPGqQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:09:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708517360; x=1709122160; i=markus.elfring@web.de;
	bh=cUdVfgrDMF+N4SQVay/9gwBl+eEDjZBlUPLjpMeVw8I=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=g+1iCL8plkrEk9ixwqrUujkDzrksyXZEsBrfF+hvH58B8mizxlGjEV5Y6ZsXWhb7
	 XP5m1vcBAf3a+OG4qWTvVt5OA86mAhz+iTukQKQIRt9Uel52zLx1JRvlvVGyUNxWV
	 UNnLXQBX4e6nmP3WWOXicY3acMA9l1IMnMSEDFBui5XNdLGW62zccucKzVHuxFHly
	 bAvL8MLT3HWVi2CN1vGMyf9oSfMSTHakczjcWQXtFpBUkCCH1HTWR9/6kuVXkJ2Kt
	 E8aGxerQvjRezNkZXZNmpHEclzis+fdDQyEz+MbYqxrMWGj8KMBc/uGD1GotzxyOP
	 GWKsjLzBvvqh2N0dmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1rGRAs3xEP-00M8YI for
 <cocci@inria.fr>; Wed, 21 Feb 2024 13:09:19 +0100
Message-ID: <69327415-eaf5-4e2b-a5e9-557252c21e12@web.de>
Date: Wed, 21 Feb 2024 13:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
In-Reply-To: <755ceff5-2eca-433c-8cba-c0ac0d46b3fc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2UY5qeiQjK4gvShD8VA4oqBCz0nVs5A+P/C3KSFptxe0KOV/hdL
 +Luz++resMx2OmeXMmMu9S6klRa4/AK5AcBaZmTYswHMp3HgB0oU563S85XO2o/ARpzkiJA
 ul2DlbIjsXCK7v959J4twDid7sfdu7/F/NKkQhSA/sMeoQ4ZXNFXm9Pont+3pXRQbFKaagC
 T6yplMhKwBnSNQEMpmvdw==
UI-OutboundReport: notjunk:1;M01:P0:6NbY+DnGf9c=;KTr8sOo9vA4A2r11gWRRaQ74QIp
 08xailn4sy0xVmHpno2xOe73Uy55wp8hlKGahC22FDrANA07sJglyBfZ6T+mXZ2OKg+N3/fRR
 r1C5XfZCs+jg9P5Pvp8lUK6daYzz2LbWF5DI4FlG1KLFGpmIk53ayfN7iwmYjN02M0y5f6qm8
 7otL6nd13JRcEJs6MmzsTyGKW+sy0yq/wHQfqBqWTGuwrlPSQvtZZseXugInz3nACDS1lJFnP
 Mt/w88e9LgNmb8wFRv4LrdZ7c3vkgjqLLVMPV2CbI1g+3NI+TC0s9d+SROPxujFHVjHdJAPu6
 +hQEd5SzWdnzbzjY+3v8u2Z0Qzui1Wa9vYMMYxkiciwbyIcpl6W4BKJ0iY1kxipN+fHtXtfO7
 43+tdPBMZuDUJWltSMiQmRJ73miwBgX2m+h82mB9RbxWeVNwrK9eGH+zvkuHFYPSOuCpjiThP
 Z+l78+WW5jkPNXW79guOKkjpWKfNj8xm4rlvepAHa1x0VCNj5/u+W0xhw85+x2FZUCt0khMKJ
 5yn+F0DyKsV5KKeghXL/H46erqyO+nHpkNt3yQfvT82VFieQdVe7yxZy7Xbo4rP+2qdGK619+
 jFHkjX9C9XnE18+TTM5q3SMbUiV9km23Jb3tTseN9Z3wVsf5ni56IdZlopcH0Qmz+FSjGYo3d
 tpcmQcRZdX0oujJ+auwoMmRW40GVokOfFN2goLGW4bhMTQ9BHvcGi2mJe0IC+agJkBS+6/KqO
 4JF6XgZ+HK+svr/LubcSvn9lKI2MHrUOck19L80Vr1lOmaiTIw0n5UVOd2ogI/L8OgsH6dr4b
 SyAepm5/bpEMJ+wawWGWNMe9upANPM0/905FNMZqu5czg=
Subject: Re: [cocci] Moving fwnode_handle_put() calls to a single place with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1591
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/69327415-eaf5-4e2b-a5e9-557252c21e12%40web.de>

=E2=80=A6
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch --=
timeout 123 --show-trying pmic_glink_altmode-excerpt2-20240220.c ../janito=
r/adjust_exception_handling_in_pmic_glink_altmode-20240220.cocci
> =E2=80=A6
> Fatal error: exception Coccinelle_modules.Common.Timeout
=E2=80=A6

I would like to add that I could not reproduce such a questionable softwar=
e behaviour
with the following example files.


int my_test_for_refactoring(void)
{
	struct my_handle * h;
	int rc =3D my_configuration(h);
	if (rc) {
		dev_err(dev, "Handle configuration failed\n");
		put_handle(h);
		return rc;
	}

	if (5 > 1) {
		dev_err(dev, "Reconsider comparison\n");
		put_handle(h);
		return EINVAL;
	}

	return MY_RESULT_AT_THE_END;
}


@adjustment@
identifier rc;
constant c;
@@
 <+...
 if (...)
 {
    ... when !=3D rc
-   put_handle(h);
(
+   rc =3D
-   return
           c;
|
-   return rc;
)
+   goto free_handle;
 }
 ...+>
 return MY_RESULT_AT_THE_END;
+
+free_handle:
+put_handle(h);
+return rc;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time spatch adju=
st_exception_handling_in_test_function-20240221.cocci test-put_handle-2024=
0221.c
=E2=80=A6
real    0m0,061s
user    0m0,043s
sys     0m0,015s


Diff output was produced in the way I would usually expect it here.

Regards,
Markus
