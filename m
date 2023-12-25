Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648CC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v7V9n1U3DQ5dMKf3Ht8pi3eoz6BvR5RoupOzzD7Q7Io=;
  b=btRrWkP16eeaj2yv0FyZNU2RllNv4i3gM77H0Ei6LDhjhruxi8ZFPSLy
   qcd/+Qap+VkqGkPBxTONtTfORYYdrwOHhA2LxGOj3Zdk6n7XgYaRZ9SxV
   Ec/4ybnRVclGkncXmSCG8RVogNKoghhteQnrY8h61aomAgNj1IrXXxugt
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="143972998"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 11:20:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 42B78E0CCA; Mon, 25 Dec 2023 11:20:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D07E2E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 11:20:20 +0100 (CET)
IronPort-SDR: 65895764_vj7F72PoMvoThQ9df2SCq7DQnnJU3vqFlW26tLt4aqvozyd
 xeXh4z8Tp44hHUwEDEQbTcbDdpGKSE0Qp8IWNEw==
X-IPAS-Result: =?us-ascii?q?A0FdAwDBVollew4P49RagQmBT4I5gVIyBAtIhFOPQYF1M?=
 =?us-ascii?q?IQ7hzWHTIRrhASBVoFAPg8BAwENQQECBAEBAwQ4hEcChzYCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOECeFbA2CXAEQg?=
 =?us-ascii?q?QyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IDAyMdAQERJgEPHwEFAiYCAlYGA?=
 =?us-ascii?q?RICAQGCfIIrAQMxB68QgTKBAYIKAQEGgmasch8sIlaBYAmBGi6IGwGFZ4NBe?=
 =?us-ascii?q?icPgVVEgRUng0GECoQUgmiJHAcyghyDT5FcfQVBcBsDBwN/DysHBDAiBgkUL?=
 =?us-ascii?q?SMGUAQoIQkTEkCBXoFSCn4/Dw4Rgj4iAj02GUiCWxUMNARGdRAqBBQXgQ5uG?=
 =?us-ascii?q?xIeNxEQBRINAwh0HQIRIzwDBQMEMwodCyEFVgNFBkkLAwIaBQMDBIEwBQ0aA?=
 =?us-ascii?q?hAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANsHzIJPA8MGgIbHg0nIwIsQgMJC?=
 =?us-ascii?q?gUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDF?=
 =?us-ascii?q?AcLB1wDGSsdQAIBC209NQYDCxsGPgKmUIEOgnbFATQHgjSBYIFhDJ8rBhMvl?=
 =?us-ascii?q?yYOBpJULodQkE8gqEaBYzqBXDMaJIM2TwMZD45Yg3OPR0A1OwIHCwEBAwmFR?=
 =?us-ascii?q?gEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1jUaNq8vXzbyvGHxRJFuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:Sas9MW2ojyIi3k/h9O45hrxfO8k0I1b4lE3rKGCAFVk3bpfET2ec5/Yx
X-Talos-MUID: 9a23:9THB0wjJ9Piqq7AElf9SGsMpd8NKyY+kMRk30og2ueuYLCZRfBqRk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,302,1695679200"; 
   d="scan'208";a="75314977"
X-MGA-submission: =?us-ascii?q?MDEVAipqNw5W7//AJBZx/Yj6UaCqVuZes7KzHo?=
 =?us-ascii?q?2z+WUb9tKWDybJ7Crv3vdYlzZGAukzKUAniLmyhwEdNiTOqqiHwE8U5A?=
 =?us-ascii?q?MxiD27/iPYP6kUxHQ1FRWPNTv54MKZn9vq/Wq1Lk8pOgihnWttUOHQ1h?=
 =?us-ascii?q?OwtBRcYzeeQsW5nTt2zs6llA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 11:20:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703499619; x=1704104419; i=markus.elfring@web.de;
	bh=BcDjKBOyEaRKAxrqJ8HhD9NG+93EcGaceaR8TsHG4xc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=njxlL7SsWq3EoKB7t/Stasqu/iiTq+qCDkeVWW0/9HtseAk/GOLk5ethgcI2gcTt
	 B5H0dLfJmNZa9TrD/nGl0zsSLEBuevJ1XHeWDmXl7qHJYbFJXMpU/psZmIbOBcVXK
	 xQgTBdyuajcPq7j5rKQu7AZjKbudA2ipENUZqm2s3f/i6sw59D5TPq/1Hmevvqj15
	 13fcmAFP9ikphFnmWyN5ntPfs0z0w5MNGsI0A12YbrrZkHGM2ZgOy14m5lD1S+c6d
	 cfXx5XIvWcesJ9b1FaNm8Kamh7c1t9avy3NcCOogGx6GjvOnyFjXNAb6t2dNG5fN6
	 x9i4gb4pMI+gj72EiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWz8v-1rjzMA2EUD-00XEuK; Mon, 25
 Dec 2023 11:20:19 +0100
Message-ID: <04ced4fa-90b5-4dd7-8f50-2f898b2c0855@web.de>
Date: Mon, 25 Dec 2023 11:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
In-Reply-To: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj+qur51bNboQvrcogJaAioT17jm3VMz9CFbZ6eqKgDxp9sPq3v
 IV5MHrUZQYKCpcBdE18ug+tw4+ty1LiaE29qw3xnn2FYGrLUa26k3TOgQPDQWkO1u0mtQ0j
 2E72Wh6j/y1CYPwhaYjGTjmjvdcAB8vNwxCKDCkCTuqMy+yW6A22nTZLq8/n2nmoff6ijgv
 2EMq14MgnJDhDnp6sXY0g==
UI-OutboundReport: notjunk:1;M01:P0:EechiKC28UA=;Avaih5tdOdZMgr/C+RawOPJ/OYI
 hYAadsHCz8Zdqx78XOgZrEtDT56dqhsT2AU9NKxcF5+HhzCvnOehzkgLI/JFnOPX2OeiICYMg
 izn2Xhj+qRneoJQ7TbEs6ebZItXTH+SmH8Hzs8qZv1qc/hWk1WmQIjTzN7GSVsj6cWTNuweOi
 8HlhABAvO7XG+Z62u/YSetdFK3fO5VoY+EXaRWPsQtA3dk2VEAxtFd0LK/iRKR4qsb2eRbyd9
 2by6EQc75pvclmCaYge+Hga3wQT8jIua77L7kgJzyeiy3drArTULhzoLz26yfrofUWT3b4x9D
 w+A1B+W0eOV//sUMuNiMz6ZCaKz/xwkHbjpJNH94SlRC+TzjKOS3968VseQjrRemqpzqBdQsS
 QHpqSK0REDz3doOtBwUuvyuL8LItkQNM9FlRAtdRqCBT265AG1UOteUgBraMR4fjHln8S6xN8
 dmN37eRWGmsqUlsWS3Wo1eXV2H2P8keXRmO1OUIk2RJCV2ML7hb9VDARLWF7Gneg3C0/CUcr3
 dsMML2P5nceDpesSCfuYhS+i3guv/NyV7A9IurMEBxgq1jJkpLY1BJbLxK1YGKMnl+szQzFCS
 onzYdHxoCEswNPTEKQZii0/eFkEzxxR1XVYlVu+Y+9MGuNY8Xv1p48hxyPHSCMWTHmk+b+Ot7
 31iXQUuyb1kENTNO4Mls/Vv6rW2X1+hmgI/diazCEDUToODgqExarvjMPX95cTbKV8KnAByfE
 Xp2G3cZ5cc7caLfi6TTtH57b1l51ipCPuchjKppqsO+KoMfcQduv3IDQUAEcbWAMWKtVRURTc
 ylK/bQJ8XKcFDGXgcU7AwQvli1AY0SHAchwNh0sh9vi3zLi/7nOHlFQmK+C9qmAMQkgL5wkRr
 BKvQ8HXlqHaacDoSB2jOM2ZD8EjuVbrg7OKajEQJPGQ8+w3CuVLyaGUNqVcYhId3ObhRI8Kgo
 so3qbT8p6m0SA+mA/B6lR8wAmxk=
Subject: [cocci] [PATCH 2/3] dmaengine: timb_dma: Improve a size
 determination in td_alloc_init_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1382
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/04ced4fa-90b5-4dd7-8f50-2f898b2c0855%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 10:50:10 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/dma/timb_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index abcab0b1ad3b..fc1f67bf9c06 100644
=2D-- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -325,7 +325,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct=
 timb_dma_chan *td_chan)
 	struct timb_dma_desc *td_desc;
 	int err;

-	td_desc =3D kzalloc(sizeof(struct timb_dma_desc), GFP_KERNEL);
+	td_desc =3D kzalloc(sizeof(*td_desc), GFP_KERNEL);
 	if (!td_desc)
 		return NULL;

=2D-
2.43.0

