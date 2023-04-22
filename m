Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF9CC7618E
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=piNjPWClbljgLwBnJ9dgVIkAtw6TBLhhk+jI+g1ug98=;
  b=V99fix5pyDxmt9d+f2ez2/m3L8yfeqyfNWVh/5TLOUx3V1u7pFn8m4Eg
   BkkUlUT5w0r7EnQUr3WDdBjJgTZQqj+KtEr/IVWQVczBKni8q38f8n9Vf
   Lokv+306BlUq2r/pFwHSoL011njlgLmqYsIJE9XyQM2gq6o/2y+PaR0ya
   g=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104279290"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 10:56:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAFA2E019F; Sat, 22 Apr 2023 10:56:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1AD12E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 10:56:24 +0200 (CEST)
IronPort-SDR: 6443a137_nBdBuIgblJoEzTk2gSn4As9smNXF04jR06/MWxGCui6RRC3
 gfqvf6flWfX83mHVwn3N4G5Bvbsge+hIoupdPHA==
X-IPAS-Result: =?us-ascii?q?A0EeAAAGoENkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYZzgiQDhDCHLpF+gUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IILgnQChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPgECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnqCKAEDDiMHqxCBM?=
 =?us-ascii?q?oEBgggBAQacDB8sIlSBXgmBFC0BkFZ6Jw+BVUSBPAyCRzE+hESDW4JniWSMN?=
 =?us-ascii?q?IEzdIEngTKBBAIJAhFrgRAIaIF0QAINZAsOcIFFgxcEAhQ0DgwWBUIlBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PTUJCx8GRAIfgWwEL1h3CgYBJSSZAgyBcRWBIK8GlAg0B4Irg?=
 =?us-ascii?q?VaBWQyfDQYTL4N9jGaGJg4GkiUel1kgp3+BYzqBXDMaJIM2TwMZD44gDA0JF?=
 =?us-ascii?q?YNuj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 aXZi4yJrIFXhHMdyfpdRkM=
IronPort-HdrOrdr: A9a23:UyMrp6nSRyXBMK8zBmcC6RDz2N7pDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:SJI3HW5vOaBU5Avgbtss+HwvGMx+dGHh427BLn6DFlcudISZYArF
X-Talos-MUID: 9a23:56snuAo4iJIb5Tt8UGIez2hwa+ZM8vqsNEomq4xFuurdFSZ9HB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54029105"
X-MGA-submission: =?us-ascii?q?MDGvxoOTjdtNlqW+YWZHXug6EkurVFp5Gvon86?=
 =?us-ascii?q?5pqG6RPKbPOn/ctna4nG6qt0lc4snFpkASopAQklkBUWrpvaWI6I+iKw?=
 =?us-ascii?q?kxWzhHqR4dspe2sBAuUkissa1YsaL7/pb7E0cGOeviSlIy30mKSilVwf?=
 =?us-ascii?q?5JVo2YKj3autFS5s9YJa/X0A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 10:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682153782; i=markus.elfring@web.de;
	bh=OtX7ELHiWwEidOL9XzrW+C15G6DmGluTp9KyHb+YQFw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uQkq389fQS/xPVnkUgH5rsvBfTfsQ0sPfybSch8Kggn3Qn41Ea7OELA7qVC6Qel7o
	 PkBc6Z1QAxCxNG7PlsVolJAPZWd6AEBorloDELIBuOp8tRm0ZqpL8WgyP8dbHHq1Cx
	 S5Ru9ETvokXL4crDVzhSdEz+dSlfUDQ/9LLoSvckd5Nf+lPy1dEiFjGQdev+zmq7Bd
	 cY/15jNu8mgeyoBOhsfyd3EL/RC/9dxgx+QCM7OsNBx945dYaP+XSfb91RQ2AtibfK
	 xw6/ywFyOsP0E79IwDzdunbSuA6tzN4cDmjTMt2pSJUHsHYA2NTdSE19uBPRBmjKLK
	 nfWOgF2Arv1MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j5y-1pwDqW1Pa6-007Zkk; Sat, 22
 Apr 2023 10:56:22 +0200
Message-ID: <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
Date: Sat, 22 Apr 2023 10:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>
Cc: cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rzIu1EekW7ZNp6PiB/R4q4E+qO89Tzwa/a4ihdOwNVDPyyOMVG7
 ZZaNK1zIjyjcq4uviKMlaPqvvbm9/1UW3FsxYIYteCRXRH271Ikupql+pbh8sDz6fTdnDc6
 VVCBKrGcq8SbHDqUUfkbKt4pvQb4/26Z2Ia3hn7oqi/53OpIhzXPfNQK91xcdS/G11ijZpV
 otpJ342Cz4pauEg6mBy1w==
UI-OutboundReport: notjunk:1;M01:P0:q79WAT1kox4=;ZvSMVBV0/EhUMmCJ9Ct/HIQw99+
 FVhA5/9Id8C77iBUQ2XR6sVs/glF614w9TPecrDBGCmMMUX5XExT6AfOD0OvBOJImXQGgFG9j
 YR4/WE3sDG0fCgSi1Cn3Rs72NvVnRDB7TksNBds/OS90INbOjBif8LOnXOhl/c/c4DAotx2ZL
 UET4V+F83blfKTwTviw0zK7gJGmVJBqlUWmigu6YaHLMjhg6kxscxjc3uZvRdKCJ8zVynC81c
 CthAi1IwZrnmeLsSK1fBcym6NZqEnbf8Vk5f0HfD7ptui07bhX+sCGAjGVSBboWhs02oy1WSE
 EnBEnGfeUsW/onJYQcRGbZYh1LMYwwJ0YgPJ7ZjI7jXSl77/b7ijudSwEEUPhhcU8gg4fTnJa
 wS5uYJIIjEgpVCQaxVRAoy8Oq6Wzf5r0x+MveRGVKbAdzOitV9altln3ozNYzFluntiPOirjf
 0qQmQOC/D/VHoMcT4BYBEI2s1nzYBuN5ThSsOqVXBx30+rKCIDBuN3sfkXczvfuao2HXHaznp
 CIRCIexzg9bdubS7Cv5htKNNJADCoPHm397hasUmNRYLPH9RiHGtL2MTE14hDvLUpB1ElIRXr
 usHMwemrLbbbG4GyOHMuzORui0sy9NKEB87QV2qq2oH2yh4UZBwr5y8euU1WC7A3/fj9S9yCw
 Q0QA8aFssiW9Q5iU9mxRoeImb1MgE2qfuSJEhQ19yTqp0rXU7xoSov6IWKmw5i/IMxBwLX2Ge
 OKP7j84Bxctxdeyc8YLQKrv+9SjU7anCiYaGxX+5wlB7JaEWJN46O6BATqbTwq2RrqOqndLEO
 7fEWgVpYVInuSzfJfeVWXMWrcLhzcVHOxZCWGKriOC5X3p4ALdDK5BaUFmtMTmpx+MM9eVZ72
 9Wrvd4YW5SETfjK05FruiYL7gWNIBejf5Uk2Psf6WSLGbejawn3jN++d+
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1111
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1f0089f3-3c8f-60e3-5520-f7813093076a%40web.de>

>> I tried script variants out again for the semantic patch language.
>> Software combination: Coccinelle 1.1.1-00448-g8e007c83 (OCaml 5.0)
>>
>>
>> @initialize:python@
>> @@
>> import re, sys
>>
>> @script:python selection1@
>> @@
>> text =3D '"]"'
>> sys.stderr.write('text: ' + text + '\n')
>> match =3D re.match('"([^"]+)"', text)
>> if match:
>>    content =3D match.group(1)
>>    sys.stderr.write('content: ' + content + '\n')
>>    if (len(content) =3D=3D 1) or ((len(content) =3D=3D 2) and (content[=
0] =3D=3D '\\')):
>>       sys.stderr.write('Result: c\n')
>>    else:
>>       sys.stderr.write('Result: s\n')
>> else:
>>    sys.stderr.write('no match\n')
>>
>>
>> Expected test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch match-=
20230422-debug.cocci seq_printf1.c
>> =E2=80=A6
>> text: "]"
>> content: ]
>> Result: c
>>
>>
>> A corresponding source file example:
>> int main(void)
>> {
>> 	seq_printf(seq, "]");
>> 	seq_printf(seq, "<>");
>> 	seq_printf(seq, "%s", "Test");
>> 	return 0;
>> }
>>
>>
>> @initialize:python@
>> @@
>> import re, sys
>>
>> @find_update_candidate@
>> constant char[] input_string;
>> expression input_context;
>> position pos;
>> @@
>>  seq_printf@pos(input_context, input_string);
>>
>> @script:python selection2@
>> call;
>> param << find_update_candidate.input_string;
>> pos << find_update_candidate.pos;
>> text;
>> @@
>> sys.stderr.write('param: ' + param + '\n')
>> match =3D re.match('"([^"]+)"', param)
>> if match:
>>    content =3D match.group(1)
>>    sys.stderr.write('content: ' + content + '\n')
>>    if (len(content) =3D=3D 1) or ((len(content) =3D=3D 2) and (content[=
0] =3D=3D '\\')):
>>       x =3D "c"
>>       mark =3D ["'", content, "'"]
>>       t =3D ''.join(mark)
>>    else:
>>       x =3D "s"
>>       t =3D param
>>
>>    coccinelle.call =3D "seq_put" + x
>>    sys.stderr.write('call: ' + coccinelle.call + '\n')
>>    coccinelle.text =3D cocci.make_expr(t)
>> else:
>>    cocci.include_match(False)
>>    sys.stderr.write('include_match(False)\n')
>>
>>
>> Unexpected test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch use_se=
q_putc_or_seq_puts-20230422-debug2.cocci seq_printf1.c
>> =E2=80=A6
>> param:   "<>"
>> include_match(False)
>> param:   "]"
>> include_match(False)
>>
>>
>> Why do I observe an undesirable difference for the evaluation of regula=
r expressions here?
>
> I know almost nothing about either python or regular expressions.

You probably know more about such software areas than you express here.


> Furthermore your semantic patch is very complicated and you have not
> provided the .c file.

Please take another look at the provided source file example.


> If you want a response, greatly simplify your semantic patch
> to the minimum necessary to show the problem,

I did that for this bug report.


> and provide the .c file, which should also be the minimum necessary to s=
how the problem.

Have you accidentally overlooked any available information?

Do we need to compare the desired data processing by the means of OCaml co=
de?

Regards,
Markus
