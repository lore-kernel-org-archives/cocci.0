Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBCCC44536
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wwkYAnzrR9H5JuOst+KHjnlTlju1x8d1nLb34XV/XR0=;
  b=E39Hggrj5CIUyVMb0Dv452gPQ/x1MKG0/nqzdXg+1vI22RXeg9OIQUXz
   bvveZ3kZGhEh3Fzt7mhWmw2LZOZIMF8c+05Ka31UXXMLwBGetg/QR/l4t
   wDDQLJybiHmjcYfVbss1M69l9lJLP+2iQ6Xnt98Qzf9ei8i2uUzQrbsya
   o=;
X-CSE-ConnectionGUID: aKeJ7srYTkKMJS+jXunRDg==
X-CSE-MsgGUID: XfMSFh6fRe2bED477givcA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259699688"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 17:21:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6E2D681A27; Wed, 21 Jan 2026 17:21:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9C43B81A3D
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 17:21:44 +0100 (CET)
X-CSE-ConnectionGUID: ZW81Mw/qS1a87XYPhoJaBg==
X-CSE-MsgGUID: 2Bkyq4OJR0SIMmbFSMFTJA==
IronPort-SDR: 6970fd18_z+TueqK1kuKdAKWmDX78KdjeF1qsPCw5FgFV2i+lomxudKH
 ZY0UDFt7igF3eNlrbBmL7KH1xO1Dy8xYbXnPJyg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HzBQCY+3BpgAMP49RagQmBUIJBaB8GWTMEC0mEWI9Tg?=
 =?us-ascii?q?iSEO48RjEsCDwEDAQ1ECgECBAEBAwMBggyCdAKNBAIeBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBDwsaAiYCAlYGARQBAYJ+AYIiAQYQAQMPJwcNsWOBMoEBg?=
 =?us-ascii?q?gwBAQbaZB8sIlmBZwMGFYEKLoVugmUBiW16Jw+BVUSBPAuCRzE+hEODW4Jpg?=
 =?us-ascii?q?iaBDpQIUngcA1ksAVUTFwsHBYEjQwMqLy0jSwUtHYEjIR0XEx9YGwcFEyNTB?=
 =?us-ascii?q?hsGHBICAwECAjpTDIF1AgIEghB7ggEPhwWBAAUubxoOIgJBbgIBC209NwkLG?=
 =?us-ascii?q?wQ9j3dFgi2BOyJvSccgNAeCOIFngWQMii6VPwYTL4QEjROGOw4GkwWZBiKCN?=
 =?us-ascii?q?osxmziBfiSBXDMaJIM2TwMZD5JUgQvGAEI1CzECBwsBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 UE2bF/5
IronPort-Data: A9a23:F+V4gaqupzb3dgbca6sW7W82QDpeBmIcYRIvgKrLsJaIsI4StFCzt
 garIBmHb6uMNDD9KN50b9yx9RwOvZTVy4MyS1dtrC8xHiND9uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVaiZfHk3HVI5IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kk21BjOkGlA5AJmPKoT5AS2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 L2hhrTsIesdBZAgrcxGO/Vu/46SCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656ICEGrBJmYM6F5DibNwvi0lgyhPQJ/lzFPgvQ42SjTNZ9DI3m9wIAvvUI
 cYUAdZtRE6ZOVsVYAhRUc94x49EhVGnG9FcgHecv6kq+C7+yAJr0b7iGMXYcJqGSK25m27B/
 TyYpDulXkpy2Nq3kxCG42vwoc31xRjafYcYOoad2MJIqQjGroAUIEZKBQPg8abRZlSFc9lYI
 EcV0jE/qLA7sk2tVNj0GROiyFaAtwEVX954Aew/4huEjKvS+QeQQGYeJhZfZ9Ujvs47XxQ41
 1qDhdqvBDp1sbTTR2j1y1uPhTa1JDRTMmIIIyMJJecY3zX9iLMM3kvqUZF6K/e83oLFKAnwx
 BKDhidr0t3/kvU3O7OHEUfvrx/Em3QkZgsy+xmRQW+vqA90DGJEW2BKwQmFhRqjBN/HJrVkg
 JTis5XOhAzpJczd/BFhuM1XQNmUCw+taVUwe2KD4KXNBxz2py77JtAPiN2PDEZuNMEfMSTkC
 HLuVfdqzMYLZhOCNPcpC6roUphC5fa6SbzNCKqKBvIQOcIZXFHco0lTibu4hTCFfL4Ey/FnY
 c/znAfFJSpyNJmLOxLpGrhGgO9xmXxWKKG6bcmT8ilLGIG2PBa9IYrp+nPXBgzgxPLa/lfm4
 JxEOtGUyh5SduT7b2OFucQQNF0GZzxzT5z/t8UdJKbJLxtECVMRLabb4YogXIh5wIVTtOPDp
 U+mVmFilVHQuHzgKCexUE5FVo/BZ5hEgEweAT0NJnetgngqXpau5vwQdrwxZrgWy9Zgxv9VE
 dgAItuMMs1SRm75+hAYV53crZNjRjuvlwmhLyqoWxlhXp9CFiji2M7oQRvrzwYKVhGIjMoZp
 6ay8y/qWr8Rbl1GIOePT9z31HK3n3wWuNwqbnvyOtMJJXndqtl7GRL+ntocAp8qKyya4hC4y
 gzPIxMThdeVkr8P6NOT2Jy19da4IdBfQHhfMXLQt4utFC/g+WGm/49MfcCIcR3ZV0L24K+SX
 vpU/d6tLMw4mEt2jKQkH4ZJ1a4e4/7dl41exClgH1TJaA2PIZFkKX+kw8JOl/Nswpl0hAiIY
 X+Mq+JqYeixBMDYEVAqNFUEaMaH3qoqgTX816k+D3j7wy5Vx4C5d3tuESOCshEAE4stArgZm
 b8gnOU09z2AjgEbN4faryJMqEWJAH8yc4QmkZA4W73UqxcZ5WxDRbf+CSbGxo6FRPsRE0stI
 x6S3LHjgZYFzGX8UnMDL1r/9ssDuoYrpzZx004kG1SFvvHnl80H9kRd3hpvRzsE0ygd9fx4P
 1ZaEnFcJIKMzm9Ov9dCVWX9IDNxLkSV1WKpwmRYiVCDaVejU1HMC2gPOeyt2kQ92EAEdxh5+
 ICo8krUYQzITurQgBRrAVVErsb9R+Nf7gfBwcCrP/qUFqkAPAbKvPWcWnoqmTDGX+UKm0z1l
 ct79r1RaIr6FxIqjY8VNo247YkUGTe4fDFsYPc5564YP3DuSBfr0xi0Fk2BUMdsJfvLzEyGN
 /JTNv9/DxST6SLfgQ0YVIgtIqB1lsEH/NAtWK3mDk9Yvqq9rghGioPx9C//iDUVQvFrq8IcK
 5zQRR2GAGe/lXtZoE6Tjchma06TQ8gIWx3458+xqN42LpMktPp+VG0PyZ62gimlCxRm9Beqo
 w/zXa/a4Oh8w4BKnYG3MKF8KyirCNH0DsKkzRuStolQUNbxLsv+jQMZhV35NQBwP7FKedBWl
 6yIgeHnznH+o7c6fGDIqaavT5ATy52JY9NWFcbrIF1xvyiIApbs6iRe3VGIE8VCldcF6/S3Q
 we9VtCLSucUfNVg31xQVTlVFkcMKqbwb5q4nxiHkda3NkE/3zDEffSdzl24XVEDI2VMc9f7B
 xTvsvmj2sFAoc4eTFUYDvVhGNljLEWlRaIicMbruCKFCnWzxGmPoabmiQFq/ASj5qNoyyomy
 cmtqtnCmBWOVGXgydZEr8ptsxdRAHsVbSzcuK4C04Yettx4JDduwSch3VEuFZxe1CD/vH09T
 C+Yd3MsUE0RQhwdGSgRI73fssO3GeEEfNv0TtDsE4V4dA/ubL697HBdGuuMLpu4lvYPDA1qF
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:qy+GqahWN1Q0LdZEvqgOzmvXo3BQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3A++xhXmiA2omUZuGocowNQ1qyRTJuQEKNlVLPZFa?=
 =?us-ascii?q?DUG85F42kcV+X2qpOnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AmQA7PgyyZFrB/ikUxYiOsx/vnRaaqP6EC1EUzbI?=
 =?us-ascii?q?kgZG/FAl1MRmmqRqLYKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="136637443"
X-MGA-submission: =?us-ascii?q?MDEZ6fGdNs+asdS7XEgi2GzNsr9uhkNeuKpTNg?=
 =?us-ascii?q?mPHc1Kdh4l2KUkkJDdRNDOIRiajzEsdSNm3/9aFZAr5z8qURFLPcZFH1?=
 =?us-ascii?q?VKZIV8DnmWqG18EDjPEPsJGbguT0cyBjs/HmQd0NXYhP88NJBQEde36M?=
 =?us-ascii?q?W+zLgrRHdVXK5cft4f5c1QMA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:21:44 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1vZlH51JK4-005d3G; Wed, 21
 Jan 2026 17:21:43 +0100
Message-ID: <421aee9d-5483-4c74-a149-778d439e33ff@web.de>
Date: Wed, 21 Jan 2026 17:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
 <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
 <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
 <258386cb-4f80-64a-4340-ec9b7c4d336@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <258386cb-4f80-64a-4340-ec9b7c4d336@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYasjuoRL0CHqv2hMDTHnO4RFi1WA/IgoQmWP7LcZSST8JjCXVq
 vi/dU4e+g7tuwc2Fu8BoTHs94ySSxF7wqQLmSUY/OaJ0RBYIAvUQh+3scEJCfrmiOvuwLME
 /AEyyjVcIbpOrYLFS6Gx9wKnd0o7bVxWUqGhA6s9wEp+V/Rfm7v80GX6s68HGGOQHzqN2kO
 XUik9PS4BCW0qdUgupa0g==
UI-OutboundReport: notjunk:1;M01:P0:DdL6Flohd9I=;qrEcKmgaG1ICjA/7d5ovbwmkn5k
 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
 ITUAPLb0=
Subject: Re: [cocci] Evolution for the software build system?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3298
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/n6KXLqoaQXNTmlOTYyk-hg>

>> Unfortunately, I would miss further improvements for the software build=
 system so far.
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b231de0db3f9513f=
6ea936caea5428fe627af1b9
>>
>> I tried also to influence corresponding adjustments somehow.
>> Will development interests grow accordingly?
>=20
> If you want something to change, could you please explain what should
> change, or better yet provide a patch?

I pointed remaining update candidates out.

I presented some patches before.

I would appreciate if corresponding development discussions can become
more constructive again.


>                                         "miss further improvements" give=
s
> no information about what should be done.

Please take another look at previous clarification approaches.
Would you like to offer further answers to remaining open issues?

Regards,
Markus
