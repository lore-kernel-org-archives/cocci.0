Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78060D1CDA8
	for <cocci@archiver.kernel.org>; Wed,  3 Dec 2025 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z92uvO9kWMQ52hxqT/+ysdWOKTGqxa6evr2hxTk4QpU=;
  b=vYevZVEbZSG7j0ofW1lYAA+b9oHnsgnjgczEUycE4FIECcylSEFpY2Lm
   a2CXb64im1zHGXiapq46eqF6Cwoh2VrNEJMTPXXJJzUuSyp7X98d3fBgb
   buEdqSRwG8EvbPrKt9WAYX2Gvw8AyJtn7PcUV6EMLvD+ip9abRWNF09QR
   s=;
X-CSE-ConnectionGUID: EUlCWnYmTGiaxKxa6ljXYQ==
X-CSE-MsgGUID: 4Uag5TU2Q++OgZ0qyNe9JQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,247,1758578400"; 
   d="scan'208";a="252635578"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Dec 2025 23:53:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 470E4E00B7; Wed,  3 Dec 2025 23:53:38 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC81CE00B7
	for <cocci@sympa.inria.fr>; Wed,  3 Dec 2025 23:53:36 +0100 (CET)
X-CSE-ConnectionGUID: Drz5E0zWRVa13HvgkXXvlw==
X-CSE-MsgGUID: UbyOOtKsSD2XY7o7O3CrgA==
IronPort-SDR: 6930bf70_QXarZbtuzRNuun0gMeqI+jHq9MzT0oZ5KSUnlzFeO1dZPyQ
 sHytAtq/uJ10lGh6dcoF5t5b38ZOtdxvntrLj7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FUAwCLvjBpe0EkQ7lagQmEEIFhMwcISY1QiQ2SBooug?=
 =?us-ascii?q?1QPAQMBDU8CBAEBAwSBTIM0AoxnAh8GAQQ0EwECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQFCDjuGTw2CW4EsgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?iw/AR8CAQM4AgYBATgPCzsLViGFHQJPBwGyV4E0gQGCDAEBBtwngWQJgUuFb?=
 =?us-ascii?q?oJKGwFziXMnD4FVRIQOMT6EWDiFd4ImgQ6GH5NCLCZ4HANZLAEPETUTFwsHB?=
 =?us-ascii?q?YEgQwOBCyNLBS0dgSMhHRcTYD0XQINJGAZnDwaBERlJAgICBQJAOoFoIgYcE?=
 =?us-ascii?q?gIDAQICOlUMgXcCAgSCFn6CCg+IA4ELBS58JQMLB2Y9NxQbBgIBgTWUHE+Bf?=
 =?us-ascii?q?oFeJ4IIWKMIgTahRTQHgjiBZ4FeBgyfbxIcF5dgkwuZBqNohViBfyOBXE0kg?=
 =?us-ascii?q?zZPAxkPjl+Ddb0CQzU8AgcLAQEDCYVpE4wigUsBAQ?=
IronPort-PHdr: A9a23:1SjMCRA+MczfwQaxP4fEUyQUDEoY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua4xygeRFtmDs7oE07OQ7/u7HzRboN6oizMrTt9lb1c9k8IYnggtUoauKHbQC7rHSRJ/N
 +l5EGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIVtJ6or1hfFvnREdutKyW90OFmfmwrw6tqq8JNs/Sldtegt+9JOXKn/Yq81U
 aFWADM6Pm8648HmqQPNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH4Qqg6Vju74
 6p1RxHmlT8LODEl/m7ZjMxwl79brwm6pxNj2Y7UYZqaO+R4c6jAYN4VX2tBXsJWVyxcHoOxa
 pYEAuQdMepEqYT2ul0Dpga8CwaxHuPi0jBHiHH206MkzuouEw/G0g88ENwBq3nUsNf4NKUOX
 eyp0KXE0zPOZO5W1zfn74jIdwgsr++LXb1rcMre01IvHB7LgFqOqIzlOjKV1uICs2eF9eprS
 OWii3Igqw5qozig3NwshpPUiY0Ly1DE8CR5wIA6JdKmUk52esakEJxLtyGGKYR2RdkuTHx2t
 ysjzLANpJG0cjQQxps92x7fd+KIc5KO4h/7WuucLzd2inJrdby/gxu/7VasxvP/W8S3zlpEo
 DRIn9vRu3wR1hHe6MaJR/p980mu2zuB2A/e5/9ELE0pkafWNpgsyaMzmJoLqUnPAyz7lUXsg
 KKXdEgo4Oal5uX9brjnppKQL5J4hwL+P6g0m8GyA/40PwYPUmSB5Oix1bnu8EvkS7tQlPI2i
 LPWsJXCKMQbuKG5BwhV354m6xa4EjemzMgUkWQdIFJdfxKHlJTpNE/JIPziEPiwnUygkDZtx
 //YIr3sGojBI3vDnbv7fLtw6VRQxQQywNxF5p9ZCqkNIPfpVU/wsNzYAAU5Mwuxw+v/FNV90
 ZgRWWOVDa+CKq/drEGH5uMqI+mNYo8VtyjyK+I+6v72in85gkMdcreu3ZcNdX+3AOxqI1+Fb
 nr0ntcBDWAKsxIiQ+ztlFKNTT9Tam2pX6M84zE7EJipAZ3CRoCrmryB3T20EodYZmBcElyMF
 2zneJ2eW/gQcCKSPtNhkjscWLS8U4Mh2g+htAj5xbR9Nufa9CIWuYr51Ndr+e3dlgs8+CRxD
 8SazmGNU314kn4SSz8u26B/ulB9xUmE0aRinvNXC8Rf6O5KUgc7MJ7R1/R0Bd/8VQzfYtmEV
 FCoTs27DjE0VN0x2cMBbl5lFdu7lh7N0DKmA6QNl7yFHJE66L7R0WXsKcpl0HbGzKchgEEmQ
 sRRMW2mgbZy+RLPCoDUjkvK35qtIK8b1yXM3GaF12uH+k9CAyBqVqCQYXcVZ0LN5fj050bDS
 bCjE/xzLgxLyMeZbKdHa9joi1pLXt/7P8/CbmX3l2rmVkXA/a+FcIe/IzZV5y7aEkVRy2j7n
 F6DPAk6XWK6pn7GSSdpDRTpal/t9u93rDW6SFU1xkeEdR4pzKK7rzgSg/HUUPYPxvQcoi50t
 zJ+HV+mmd7bCt+BoQVsZo1EZsgh7VAB2W+K/xdlMMmYJrt5zkUbbxwxukrv0xttDYAVjc8gr
 XoxigZ/KKeZ1lxMbRuA2ovsN7qRJmShtAu3Zfvu00rFmM2T5r9J6Pk8rAD7uxq1E0M573h9+
 9xSzmfEv9PSCxEOXJW3XktfGwFSgbbcb2F94orV0SYpKqyoqnrZ3MpvAuI5yxGmdtMZMaWeF
 Qa0HddIT86pYPcnnVSkdHdmdKhb6bI0MsW6dvCHxL/jPeBumyijhHhG54Y121yF9i51QOrFl
 5gfxPTQ0gyCXjb6xFCv16K/0ZxDbzAbBSyzxCnhBYhea7daZYEQFWqpZcG6h51/i5PrR39E5
 Qu7HVpVva3hMRGWblH7wUhRzRFO8SHhx3T+lGIyzWx6y8jXlDbDyOnjahcdb2tCRW05yEzpP
 ZDxlNcCGk6hcwkukhKho0f83alS4qplfAyxCQ9FeTb7K2Z6X+6+rL2HNoRT75kpuD4RXOm9Z
 FGcRbPniwMdyD/uGC1SyXpoElPi8oW8hBF8hG+HeTxvq3DYcNo2yRre4d3aSvNL9iIBXzV1j
 n/bCxLvWrvhtcXRnJDFvOekUmunXZAGaijnw7SLsy6j7HFrCxmy9xyqsuXuChNykSry1t0xE
 D7NsA65eY7zkaKzLeNgeEBsQl768ctzXI9kwMM8g5QZ2H5SgZvwnzJPjWD5MNxAn67zbX8MQ
 zEG2fbN5xP51UolIn/By4/iV3qby9dsfJHjMj5QhH17tJ4MVvrc5ach/2M9uleiqAPNffVx1
 iwQz/cj8j9Sgu0EvhYs0jTIB7kTGUdCOim/3x+M7t24sOBWfDP2IeX2ihU4xo7nUuzRx2MUE
 Gz0cZojAyJqu8B2MVaXlWb29pmhY97IK9QaqhyTlR7EyelTMpM40PQQ1k8FcSrwu2Moz+kjg
 Flgx5a/6cKbLG9s9bn/DhNZMzzzaM4J0inqlrpTmYCa0sr8e/cpUiVOR5buQf+yRXgOsv7mP
 h3IHDA9r3adFrfFNReY81trqDTDHtr4UhPfbGlcxtJkSh6HIUVZiw1BRzQ2kKkyEQWyzdDge
 kN0tXgBo0T1oRxWxqd0JgHyBy3B8RywZG5+G/39ZFJGqxtP7EDPPYmC4/JvSmtGq4a5olXFK
 3THNV0YUCdXBQrfWRa7eeP1gLuIu+mAWLjkJqOTM7+F8b4HD6/Ql8DojtQu6T+IMo/n0mBKN
 /QgwQIDWHl4H5+cgDATU2kMkDqLaceHpRC68ykxr8al8f2tVhi9rYeIDrJTN51o9XXUye+bM
 PWMgS9iNTtC/pYL2GOQkf4H20UOhiYoezTlHbkbtCHLRb7dgecOX0NdNXw1b5UOsf901xIoW
 4aTkt7v079kkvM5Q0xIU1DsgIDhZMAHJX28KEKSBEuPM+fOLjnKzsfrJKKkHOQA0aMK6Fvr5
 3DFThyGXHzLjTTiWhGxPPsZiSiaOEcbo4ShalN2DnClStv6axq9OdsxjDsswLRyiGmZUAxUe
 TV6bU5JqaWdqC1ChfAqUXBG5HtsNq+Iliec7u/XJ4w+qfxwHilz0e5XqidfqfMd/GRfSfp5l
 TGH5MZpuE2jm/KTxyBPVR1Ttm4SwpqMpllvPuPV+9MTPBSMtAJI5mKWBRMQotJjAdC6oKFcx
 O/Ek6frIStD+dbZroMMQtLZI8WdPD89IALkTXTKWRAdQ2fhZgS9zwRN1euf/XqPot0mp4jwz
 dAQH6RDWgV9F+tGWB01QZpcf9EsAHV81uTA6axArXum8kuLTZ0H7JrMDqDLWa23emTe0eYMc
 RIMxfmQxWE7Lorgx0FlLFV3ztyi86v4WNdQvnU4KBczu1lA9z5yQz9qs6oKQhuq+2MeEri4k
 0xv4jY=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZQp4HamMwMAMIB5viNBSUJcrpibpDfIl3DAbv31ZSRFFG/Fw8P
 re+8jztCWE7Ar5PUtLpTnuAsa9qB/nm6KdpLNhXotKPzOLhILLFvAG0WKK+VSJcEDDH6xmpM
 VdmsNFaOEYY2IasfrH
X-Talos-CUID: 9a23:+31DrmBgdBv67c/6EwV95hM5QtIaSEPUlSzwPUC7OVZ3TKLAHA==
X-Talos-MUID: 9a23:XXAkNgkIgMKpCOd//o1KdnpfPtZPxLiNE3shy6U35M7bEndbITi02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,247,1758578400"; 
   d="scan'208";a="132704583"
X-MGA-submission: =?us-ascii?q?MDHumvABCd8Gvssa7LyqkcXMa37Gbh/A7jWE5B?=
 =?us-ascii?q?yvRspnKO8c3g6U8IEWi6fjQiiKhJolBXEwj18mBvt47eBzYq1zNLjIo4?=
 =?us-ascii?q?Sg6fv8VBInaewcFuPqt4N1PqLMrs+V5Hj5xG6pWlwJoENop4B6+bhhs7?=
 =?us-ascii?q?dWZXYiSVy2v6BaSNP3YxTy2g=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 23:53:37 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2852B240027
	for <cocci@inria.fr>; Wed,  3 Dec 2025 23:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764802414; bh=z92uvO9kWMQ52hxqT/+ysdWOKTGqxa6evr2hxTk4QpU=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=WzKL1TAlbVudAwDT1FOeZ2ZVmGmMgNTbEw8PClVNdbZEru30q0H9+maB2PRbchkBj
	 g+PO7sy4/wNf2XeOZWNjRJ1+j9EL4j1vOwYFxqL5MoN7SJy7OiXzV6/YTfKSFgEqVo
	 IPGo90M3ctVO3cgtOJzPXbWRHpQobbtoDiQiw7/ZomyqinjwRzv34+CsOVn/3Q1Zkg
	 sqnamwKXFOXJucIMq0r0KV8u8aPD9ocI3fUSDpk1z/gP2gft1S25SmiVDiGM2FdDN4
	 fBVw60q21qQEhOgdpvbQGJcz0Okp0PQZ/PhGmqadWSdmK+DawiYEtNHNumkiNUmfa1
	 53t0wNudnRcDg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dMCbx56qHz6tvx
	for <cocci@inria.fr>; Wed,  3 Dec 2025 23:53:33 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 03 Dec 2025 22:53:33 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Message-ID: <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Search for the concatenation of meta variable + fixed
 string (similar fresh identifier)
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3237
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/9ab63cb6ee4a0354c053f22fb0934317%40posteo.de>

Am 03.12.2025 22:47 schrieb Tobias Deiminger:
> Hello again :)
> 
> In Linux, the DEVICE_ATTR_RO macro works like this:
> 
> static ssize_t led_status_show(struct device *dev, struct
> device_attribute *attr, char *buf) { /* ... */ }
> 
> // The macro automatically concatenates led_status + _show for struct
> initialization.
> static DEVICE_ATTR_RO(led_status);
> 
> 
> I'd like to find the position of all functions assigned by
> DEVICE_ATTR_RO. So I thought to use a 1st rule to search for the
> identifier inside DEVICE_ATTR_RO, then use a 2nd rule to search for
> the inherited meta variable, concatenated with the fixed string
> "_show". Like:
> 
> @device_attr_ro@
> declarer name DEVICE_ATTR_RO;
> identifier attr_name;
> @@
>   DEVICE_ATTR_RO(attr_name);
> 
> @device_attr_ro_show_fn@
> identifier device_attr_ro.attr_name;
> position p_fn;
> @@
>   attr_name ## "_show" @ p_fn (...) {...}     // invalid syntax, but
> you get the point
> 
> 
> This doesn't work and I couldn't figure how to do it correctly.
> There's "fresh identifier" which looks close, but it only works for +,
> not for search context. Is such a search possible? How?
> 
> Tobias

Found a workaround using fresh identifier to add an intermediate helper 
construct:

@device_attr_ro@
declarer name DEVICE_ATTR_RO;
typedef __DEVICE_ATTR_RO_T;
identifier attr_name;
fresh identifier show_fn_name = attr_name ## "_show";
@@
   DEVICE_ATTR_RO(attr_name);
+ __DEVICE_ATTR_RO_T attr_name = show_fn_name;

/* Helper construct needed to get concatenated identifier for final 
search. */
@device_attr_ro_2@
identifier device_attr_ro.attr_name;
identifier show_fn;
@@
   __DEVICE_ATTR_RO_T attr_name = show_fn;

@device_attr_ro_show_fn@
identifier device_attr_ro_2.show_fn;
position p_fn;
@@
   show_fn@p_fn(...) {...}

Seems to work good enough. If there are cleaner ways, let me know.

Tobias
