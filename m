Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085F1C77B61
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vYC3rt9V2mTZ2sZnUeA8pQ/LU5bVw2JivRZjfpJX6fg=;
  b=MHU49HSdFRBkXlZ68CoNBx1OJ2+ZMOdEm56ogW4Ta6YZheqv0/3D7WRQ
   /31CDmGv440ev1CFYbaK/Sr8XXnr0DGWJ9PnwBBIOLdeVV+N1RuxGMtl8
   enQjVn0yWQ7wav/+FCXDbJEosjVaFylWcRIV0wvO+DbvD+qt8ZeqzrPPp
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,202,1677538800"; 
   d="scan'208";a="103293736"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 20:01:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 651DFE0298; Sun, 16 Apr 2023 20:01:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7753BE00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 20:01:25 +0200 (CEST)
IronPort-SDR: 643c37f4_Daj53H7t4wL7dFpNsl7jaEoaS+BFzrCI0aBiTG7zo97BhyN
 7CiCDUVcX1+kuS7BTbzwnMckuQTYOXvfaAH7/bA==
X-IPAS-Result: =?us-ascii?q?A0EGAABuNjxkhwMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItdVYvBAtGAwUihCmRAjGEMI5shGeEA4FWg?=
 =?us-ascii?q?UA+DwEDAQ07BgECBAEBAwEDgUmCcEYCa4RRAh0HAQQxCA4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFWDoEGA?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgINOj4BAgIBIx0BAREmAQQLCxoCH?=
 =?us-ascii?q?wcCAlcGAQwIAQGCegGCJwEDDiMHDAatUoEygQGCCAEBBpwLHywiVIFeAwaBF?=
 =?us-ascii?q?C0BjEs/gzZ6Jw+BVUSBFSeCUzE+gmIBA4Feg1uCZ4lrhRGLFUWBNHaBIA6BP?=
 =?us-ascii?q?IEEAgkCEWuBEAhqOYFAQAINZAsOb4FJY0yBewQCFDYODh0lBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsgBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8GJkQMQjczEwYFV?=
 =?us-ascii?q?wEpCw4RA06BIh8GBCQLWoEBBgEmJJ4uc4E5CZg8Aa1CNAeCK4FWgVkMig2VA?=
 =?us-ascii?q?AYTL4N9jGaGJg4GkiUuhzKQFyCNM5pMgWQBOIFcMxokgzZPAxkPjiAMDQkVg?=
 =?us-ascii?q?zszj0g/NAIBBTUCBwsBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:DhR3caB238VSz3nlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AYtTXd2uiRzAJeZt7LZHQ4Xc06Is5f3/Z/GXJA3a?=
 =?us-ascii?q?eUz1qVIaNZgO03qJ7xp8=3D?=
X-Talos-MUID: 9a23:SGFOowjA51pquq+Xjd7sw8MpG/5lpJu2I38xiZg2l8qiOjUtBBqxtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,202,1677538800"; 
   d="scan'208";a="53481499"
X-MGA-submission: =?us-ascii?q?MDE0zQ3CQgDtUOwjMskLUKGZELnQWNQIDv6Vhf?=
 =?us-ascii?q?Qv3+575W6qZU0iE0DK9gGf40TbCKmUTnYUM2o8vgorDbg21AK5wkkBMA?=
 =?us-ascii?q?p2s1eaQ7k8PK2vGWI9hZtLB3b6NS/iBXejYO82kCLpDjJnQTcrR9BgEu?=
 =?us-ascii?q?pPxVUDRzXznNnDPmbA+zfijg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 20:01:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681668077; i=markus.elfring@web.de;
	bh=vYC3rt9V2mTZ2sZnUeA8pQ/LU5bVw2JivRZjfpJX6fg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gDD2DtDPfmpxx19yV55dHJk0pQwMkeBqL793QBpndzFiO6hqc1Iy12WSZhjoMaYpu
	 SBqMtVFtjbZJCwJp/o+e3ITLbyIR+UFRrSUwr4iBH3I+kURdfzaNY4Lhw0fW+LRWw7
	 DGcZsnyTyhbWuhSEZfTgpWT5JVrsvXfpIZ3ACu2mI6yWzaikyeI4thVfcwN7gfOX/O
	 tA16RnZ3vWX6SHpDN4uskVoBSmsE+BeYbp+DGdJQuCSIn0p8vq64D3KbzIcO43uutd
	 ZpL3qQ4HyjD8/3ves/kmC/OTxxQrDFVppZXttZPCIgYhMuyLe5efLKreDSv24Z5rtu
	 k1kp8LBxgVUdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1pxlJ13hJr-00RH45; Sun, 16
 Apr 2023 20:01:16 +0200
Message-ID: <435216c4-f9fc-57af-eecb-66f6f261badb@web.de>
Date: Sun, 16 Apr 2023 20:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d8ed4e5d-49d4-ca7e-1283-1ec166bf643d@web.de>
 <ZDmJsemYldOsMMrH@smile.fi.intel.com>
 <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TCSYIG+iQi+PiDEJUC0TtW+MoN64yprk4Bdps0uHCtZiUpOC8WX
 9EVQoE1OfFWCzECc4guJ7LwWSW+nYPFtONMurVbQezn7nK11Nqru+KKjxxMlTVRkLjd31io
 l2JHLbcziho9EiYVI5QIHBZwzeTDiAWleYfuLJaw/EfdQnWLvAAQ21inIC+Ck0go/joknGe
 5PewtB5sIpQGx3b/C4hgg==
UI-OutboundReport: notjunk:1;M01:P0:DMiA8dxln7A=;++9l2k1zCJod3YdOe5ixgx5c0zV
 uqipX9iX9WDVzAPYwKIAN/Joz8zbqGzcgh61eMKeOEsBEn6/J1Wl9gvdrNQ2JosssdVfDbez2
 YN+ukLiiQzvJKLGU1JT7OR1hOUhcuYqjVZbL01/VyJknEO3E+6GMU9GeRR1bVyunPpai3xkc9
 fXWPTYMMD3QmSUwhWxt8Woyhoyk9L+5OrrGn/TV2nIHONQfoipfIbv4yru9GyzEounX/vZOwm
 3xq55ND2oh1ZuVunrx3z33EOlGctSf6JVfL5hi+6OD8Xtgl+pp3DWbLV3Ao07UZO5lht1Gla+
 +8/QHQKLh/iYe6UGDZH1sHMHd2G7JYf2wqMn3BJhdorgcmTU+HBNEKKSN4Or8ywwNE+/ubJL/
 QODEY/SrPhRAysSLrpsGNaHvlsd1RnskXU7YR50/T5xSQDeCApPrhVKdSXb8Xjf/Wo9GR2yy5
 1yW6AiV4oYUKtQuk9sajU9PASTGIyaPLFyljoXjpNfUrTgTnaY/0Ng2m2zMdKg5T69l2gmEt9
 7t1bru8WXuUr8YS9HYu58bhcrku2qNH332RpYdBmJ9XTn/M9CRPR4FcIfcDKwS35GlYJJpmL+
 MFkCs7IjZcoyuA3XWb6FHs9kELe+sBent0oJ+jbz7UKm/zrpvpXsaLGsGf9gUnQgkFo3aT6Dp
 olAN1hwAZvj5BNDFbLm/6tuhjf3+i4wUAP4HfkGvck1tQlplNTCyJUXuiLeyfbo0YeL3kyisH
 gsKfO0E5LXTP0JTe8pfQHXrYjFyls9tn2FCg+9RnbNzne6ahZN4dyG6MwrTH2ysIy9IhsicEq
 SZq0AMI0GJcYntejBgrGam3lKRK3n9+NVegV2IEwHDI900pO3TZtJSN7WUXYxKjCciXcIHzpP
 9EVIA/+eNcqFGjD39QwpfEzGKnR9E4/n8k+sMbZD61NtZaKzFkIEjwJHN
Subject: Re: [cocci] [PATCH] media: atomisp: Move a variable assignment
 behind a null pointer check in atomisp_cp_general_isp_parameters()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1071
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/435216c4-f9fc-57af-eecb-66f6f261badb%40web.de>

> Instead of this patch, can you please audit the callers of this function=
?

Did any analysis tool publish a call tree already (according to your enqui=
ry)?
https://elixir.bootlin.com/linux/v6.3-rc6/source/drivers/staging/media/ato=
misp/pci/atomisp_cmd.c#L2721


> I expect that you will likely find that the callers
> already unconditionally deref css_param themselves, or they
> guarantee a non NULL value in other ways (e.g. address of
> local variable).
>
> So I expect that the check can simply be dropped completely,
> which would be a much better fix.

Are you really looking for ways to omit null pointer checks
for three input parameters here?

Would you like to increase the application of any annotations
or API attributes?

Regards,
Markus
