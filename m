Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CC9C61D9B
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gF/lqb4EIxURsn2pxJoIVjA2xOH4/g9lIBtqQHaOVbM=;
  b=uHn+M19RODKPUmFUJE0umkS0Kw9mrJa8cg4C5gi0pT/BxNJyF071CAXn
   uSevZCuwsrfCzb5MwXLeEnsO2+CW+d34eNSAHXTgLigXgJKYYheYXiYH3
   54BaAeAvwRvT6OSaUTV6GmvkY7/X4EVv1Lpymq/whj2jJF/eqdo6hBzNi
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137968963"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 19:51:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2ADA6E0CCA; Wed, 22 Nov 2023 19:51:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BB2C7E004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 19:51:03 +0100 (CET)
IronPort-SDR: 655e4d98_sQh0v+u7R3rDEHT7HQAwzrCRKVeU1Sd5O3vdmN2TXkKma5/
 GWirmYibeXGPFaX5/CxGBxUO+g1oyucOrkutcCQ==
X-IPAS-Result: =?us-ascii?q?A0GSBQCkTF5l/07ASNlaHgEBCxIMQIQIB4FJMAQLSIRTk?=
 =?us-ascii?q?TIwhDuHNIdKiG+DFj4PAQMBDUEBAgQBAQMEhH8ChykCHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYJcARCBDIEeAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBFwJHQgEEASMdAQERJwQLCxoCJgICVwYBFAEBgnyCKgEDD?=
 =?us-ascii?q?iMHrw6BMoEBggkBAQavVR8sIlaBXwmBGi6IDQGFWYQ1Jw+BVUSBPIJSMT6EQ?=
 =?us-ascii?q?4NbgmiDbppiXSIFQnAbAwcDfw8rBwQtGwcGCRQYFSMGUQQoIQkTEj4EgWGBU?=
 =?us-ascii?q?QqBAj8PDhGCPis2NhlIglsVDDVKdhAqBBQXgRIEahsTHjcREhcNAwh0HQIRI?=
 =?us-ascii?q?zwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBNgUNHgIQGgYMJwMDEk0CEBQDO?=
 =?us-ascii?q?wMDBgMLMQMwVUQMTwNrHzYJPA8MHwIbHg0nJQIyQgMJCgUSAhYDJBYENhEJC?=
 =?us-ascii?q?ysDLwY4AhMPBgYJGwQOAxkrHUACAQttPTUJCxsGPgInoyqEC8R1NAeCMYFfg?=
 =?us-ascii?q?WAMnyMGEy+XIg4Gkk+YQCCoNIF6JoFZMxokgzZPAxkPjiCEK49HQDU7AgcLA?=
 =?us-ascii?q?QEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23:b0tZnRGM4coVfOhey1WHtJ1Gf+dGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33BmQANyQsqsYw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS+bL9oM
 Rm7rRjdusYLjYd/Jas61wfErGZPd+lKymxkIk6ekQz76sms4pBo7j5eu+gm985OUKX6e7o3Q
 LlFBzk4MG47+dPmuwDbQQSA+nUTXGMWkgFVAwfe9xH1Qo3xsirhueVj3iSRIND7Qqo1WTSm6
 KdrVQPohSIaPDM37G3blsp9h79ArRm/uxJw3ZLbYICNNPp/YKzde88aRXFcVcpVTiBNH5+wY
 5cKA+cHIO1WrZTyp0EWoBW9CwejC+3gxCJWiH/43aM10fguHw7d0Qw8BtIDqmjYoMnrOKoQV
 +2+0anGzS/Eb/NTwTrz75LHcgoiofGRRrJ7bMXfyU0hFwPfj1WQr4PlNC6S2+oKqWeb9elgV
 f+0i2I9pA9xpjavxt0tionPiYIY0V7F+jtiz4ovONK3Vld2bNi5G5Rfqy+ULZF5Qt8+Q252o
 iY6zKULtJ+lcSUW1JgqwwDSZv6af4aH4B/uV/udLDV7iX54eL+zmxm8/VSgxOP8WMS4zUtGo
 ytLnNfCuH4D2R7e59aFR/Z740yv2i6P2hjN5u1ZI004j6jWJ4A7zrItkpcfr17PEy31lUnui
 KKbeV8o9+a15+j9YbjrqIWQOot0hwz4L68jhMi/AfkjMggSQWeb4/my1Lzi/ELnWLhGkvs7m
 bTDvp/AP8QUvKu5DhdV0ok97xa/CC+r0NEfnXkaMFJJYhyGgJbyNF3UPf/3E++zg1WqkDh12
 /DLJqPtDojPI3TZkrrtY6xx51NYxQYt19xS5ZFZBqkEIP3pW0/xsNLYDgU+Mwyx2+vpD89y1
 pkdWWKSGa+VKqzcsVuG5uI1IumMYoAVtS3zKvc7/PHil2I2lkEFcamvxpQYcGq4Eeh+I0WFf
 Xrshc8MHXkSsgokUOPqkEGCUSJUZ3uqW6Iz/D86B5iiDYfHXY2sgb2B3CKgEZ1MfG9KEFGME
 XHyd4WFQfgAciySItV5njweSbehU5Mh1Q2ptALi17VnKfbb9TEZtZ/4z9h05+jTlQko+jBuD
 sSd1XuNT2BukW8SST82xvM3nUso6EqH0KEwp/VHHNhXr6dLTwM7PNjYxvNzD9TaWwTbf97PR
 kzwBp2tBjo6T/owxcUPagBzAYaMlBfGig+jGbwIjPSmAJIu86TTlyzULtx+1m2A+a0vlVggT
 eNQOGfgiqMppFubPJLAj0jMz/XiTq8bxiOYsT7blQJm3WldWQ90C+DeWGwHI1HRppL/71/DS
 LmnDfImNBFAwIiMMPgCccXn2HNBQvqrI9HCeySpgW7lIB+Sxa6XKqfudX8c2ir1F0UO1Qwer
 j6dLQZrPi66uCrFCSB2U1fmYkfi6+57/VayVEwp1Eena0N71ry60gEYj7qQRqBbxaoK7QEmr
 Tg8B1Ohx5TWBt6H8hJmZ7lZaMgh7U1v0GXEq0piM5bmI60Kakc2VQNxsguu0hx2Dt8Fis02t
 DYwywE0L6uE0VRHfjfe3JbqO7SRJHOgtBaoI7Xb3F3TyrP0su8G9eg4plP/vQqoCltq8nNp1
 MNQ2med4ZOCBRQbUJb4WEI6vxZgoLSSbi447oLSnXpiVMv8+hrLwdE0H60Izhi6ftFQGLyJH
 kn+HoxSBsSjLvArh0n8dggNb6hZ8K85Od/jduPTgvf0erk62mv31yIYsNMYsArE7Sd3R+/W0
 oxQxviZ2lHCTDLglBK7tcuxn4lYZDYUF275yC7+BYcXaLchGORDQWqoPcCzwc1zwpD3XHsNv
 nuqHVAbw4mEfRSIblry9RJd3wIbrDb0/EnwhywxiDwvoqeFiWbryv7haQFBF2pFXmhkgn/zL
 ILyg91QDy3KJ0A50RCi40j93a1Soq9yenLSTUl/dC/zN2h+U6G0u9JueuZ34Ygz+WVSWeW4O
 xWBT6Ll5gEd2GXlFndfwzYyc3ervI/4llp0kjDVIHF2pXvfMcZ+oHWXrPnVX/1MxXwrQCdii
 D/YLkexNZ+l8J2YmozCvea3S2+6HscKLm+0l8XZ5XH9uj0iCAb3h/2pn9z7DQU2tE2zn8JnU
 ynFtle0Y4Xm0bi7LfMye0BpAFHm7M8pUop6k4Y2mNQRwS1A38rToiBByDapd4oLisecJDIXS
 DUGwsDY+l3g0UxndDeSwp7hE2+ayY1nbsW7ZWUf3mQ86dpLAeGa9u8h/2M9r1ymoAbWefU4k
 C0azK5kzXcAgPwS/icpwD+cBL86AkRSeyDh3UftjZj2vOBMaWCjfKLlnm93h9O8F/evpg9GW
 XD2UogvF2l8448sVTCEmG224Ybidt7KaNsVvRDBiBbMgd9eL5cpn+YLjy5qairt+GcowOkhg
 VlyzIm36cKZfn518vvzUXs6fnXlItke8Tb3geNCk9aKisqxS455FGxDXYO0H6jxSnRI76uhb
 lzQVmRm+jDBRN+9VUee8Bs09SuVVcrxaDfOeT9Bio8/DBiFeB4F2VpSBm9l2MdmUFjtnpOpc
 V8ltGpIuRin8F0Vm7gubUWvFT2OwWXgIjYsFMrPdlwPsFwEvhqEd5TZtLw7HjkErMf480rSc
 CrBP1sOVSZTBQSFHwyxZODxo4aatbHJXKzgc7yUP9Ds4aRfT6valcjpi9U7uWzWZ4PWZSEqD
 uVniBoZGyknRoKDwG1JEXZfgSvJa4TzSA6U3Cpxo4j/9f3qXFiq/o6TE/5INt4p/RmqgKCFP
 urWhSBjKD8e2IlejXnPgKMS2lIfkUQMP3GkDKgAuCjRTanRhr4fDhgVbDl2PddJ6KR01xdEO
 MrSgNf4nrBiift9B1BAXF3n0sanAK5Ca3m6L0/CDV2XOa6uIDrW34fobKn6RbARxORYuhusu
 CqKRk/uOjPQ8luhHxurMOxKkGSaJEkE4d77LUwrUDm5Co22OXjZeJdtgDY7wKM5nCbPPG8Ya
 31ndl9V66eX5mVei+l+HGpI6jxkK/OFkmCX9bq9SN5evP11DyBzj+8f7m49zu4fySheR+Fu3
 gbWoMRvpV6OjeSFjDZqGkkryH4DlMeQsENuNL+MvIFHQmrB9QkR4H+4DhMXu516B9ept60am
 b2t3OrjbTxF9dzT584VAcPZfdmGPHQWOh3sADfIDQEBQFZD2knAikYbnPzArxV9S7Alp5Kql
 JdcEteztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 FhVjOPK4Q==
IronPort-HdrOrdr: A9a23:HMLOo6FzdavkVIExpLqENseALOsnbusQ8zAXPjNKOH9om6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3AVzcRuWh5W0mDF3eGMpuJNUSoujJuX0eGkVfRGh6?=
 =?us-ascii?q?BBkFGWOOzZXHJ8610jJ87?=
X-Talos-MUID: 9a23:Wzlckgg2Q0o8nEm2r/9IeMMpJdZQ3P3xBkk2wJAI/PmndhJOI2ilg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,219,1695679200"; 
   d="scan'208";a="137968954"
X-MGA-submission: =?us-ascii?q?MDGqrlljnggv97fFC1akk8lCt7gojg/JXtL7Gj?=
 =?us-ascii?q?Olm5fFA5DqIS4wB2e/3uZTiO9A3bnWX6dFpDFc9QpeAc1EHyV9mJAVSk?=
 =?us-ascii?q?RPRm0HuenBQq0T5nNwRJzCZnado2ycUwDn2JK9+5mRtTAYcv4/JYVLki?=
 =?us-ascii?q?mIrEzp+CfD9PzG2Io+SNU7Cg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:51:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700679054; x=1701283854; i=markus.elfring@web.de;
	bh=EkhQ39JL4jmEZXtk93Gwy6+8KmZG6HmOBHrfOMMWaFM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=BGtQwAkM4tNV/cBmhJgeevVKkN09NN8ZuVTUU+5rFuvjXHc+ujGJ89V9NVweMr80
	 ZFBrexmow6i2PjtqU9EIJjsCNGZlbX5tbopwk1s0fyHxUF98ey0Q5Tu92aH4MwOqo
	 SBWFoJtkZANrJmNJ8TVdkjS39eOi4O6zHzjFsmLd9lSeTdIemzPdAfev4O0HyWzZB
	 IlRgsz/IFVCe7cTrJaYD4cI2Tnb/gZY7jviYoNIp3mE/Ov+sZm61ot1rGskH0gXEl
	 glSfPGiXTLKNqcHUnx7wHFK1LbmeejPQreDMRAM52x+1laAudXfaV0Wy1KkhpD1Gv
	 SP/Wf9+xg1hgLTWGZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1qmYVU0u9u-00Jc4m; Wed, 22
 Nov 2023 19:50:54 +0100
Message-ID: <a59723a4-9b39-4de3-8efd-101c5f8485ff@web.de>
Date: Wed, 22 Nov 2023 19:50:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <83e9ceda-9f18-4bb5-a945-261e2c03a427@web.de>
 <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <43f969f3-94a5-6cd2-74a1-ae46f74de331@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ySjEJlWrtCoLYvP9jzHQAiDZ9j3wXXGJOMcHdkcjcilYF/DeeP7
 eJUVdiwufdWlVf5P4aNqmzL1p6McKM8X1D7EjOAKSdZJUYhs0CcQphYFwbzqX9+HWiRoB93
 HucRIG6bITcB5vgyvvixmpm29kE3r6sse5vq5FHW1ypSZaahEAFOdew4gZr2tGpjZZoBneI
 tVrbET3QrJsh2Lpj/UWBQ==
UI-OutboundReport: notjunk:1;M01:P0:NSWefav9ij0=;rtWvHTgGSqWz25ruPfWTW+KL/fz
 UutO15fTb83GypNUJn6m2uGIevPICqzVgHbZavTnNKXRgZPsw+Kz8GCmrYAiKvQD5DGFkLgsP
 prDangUhDo2hPYSR/yBhc3Pi3o9dSyOJodoReulcJgSdr7DkKcE0nPo+Fqyt/ckJGdNqbQ+LM
 qLJj2ueCMijb+55WsLINI/VLHwhvh9zahscpOfV7L/K7osoJ6Ci32Y6HT7eZY1yBjEwXtjQjN
 XAlZpFExd99a2m05X6B26yVUy2eVzzX0VRLOrKuTDUwWdxt0Fx9xoDNwc+nvclVyTzNgMm4tf
 NFuyqsPD7yBiwn9ulz+YyhSeMLvdCcsgG11meuFSn1D8/cdQVOkIVrDInGbg6xPcOqPr6KkiC
 Ho50HUftKSB80YRlQRj/Z3+dpyzV9R0zitK+fo8usq4F3aP96L5pyk72WvDrSr6tj10iyDNGz
 IKDifX4KS3yT9vs+nawwF/ErsuICXhWBix/56Ie6bqAEXsfZ62wpuwzEiuVZjIz5LpR3s8os9
 7Rjmy79uZ4jhz6EV7iZbOy/vzPrZV1AC86Es0DauRBXKHuLUS7dAm7PGVpuVOhs5RQ0hoqfrc
 +TrvN7LHbnWc0KJVwtWZJdjGAmGKuQ0NUbNb5WMAJdF8jOCmju+Pdh8oj+Nlf/T9xtkkAnTuR
 OzZmHS6rPDWmYDYDzTuDxL+1ZSnSqfAz1MEp+49N40Kll/qYjNiSKKRk+awDFb3x/ePHCCmjc
 cG/Pc+s0nlqSn5mK6xMm+4rNTaZd8iAMYgXQK+eZGTJHT/uKNaes/2wgZVvqWrni6dXnqoDlR
 rtwOxtCN6dG+KRcgnuG5gy6eRH2oVLkKo0p0+d2xeKJUc/sMcPe64AIiQurArTkxss4F2+BYK
 TPcWjBaOGN7TbQC7zPwmUgB9mba2e5BH2s2LgfTGWCFlmxEJJ4+8z6gfGDfYC6CLif8pRWCZC
 snKNhQ==
Subject: Re: [cocci] Detecting statements from the last if branch (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1308
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/a59723a4-9b39-4de3-8efd-101c5f8485ff%40web.de>

>> Some statements in if branches correspond to exception handling approac=
hes.
>> Would you become interested to detect a few statements from the last if=
 branch
>> in a generic way (with the means of the semantic patch language)?
>
> Normally that would be an if without an else that ends in a return.  So
>
> if (...) {
>   ...
>   return ...;
> }

I would interpret such a simple source code search approach in the way
that some if branches can be found.
But it would be uncertain then if this code block would be really
the last one within a selected control flow.


> The ... on the second line will be allowed to go over gotos.

A goto statement can occasionally also occur instead of the suggested
return statement.

Regards,
Markus
